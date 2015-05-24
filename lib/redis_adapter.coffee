Adapter = require './adapter'
redis = require 'thunk-redis'
Promise = require 'bluebird'
_ = require 'lodash'
logger = require('log4js').getLogger()

class RedisAdapter extends Adapter

  createClient = ->
    logger.info "Connect to redis server: host=#{@host} port=#{@port}"
    redis.createClient @port, @host, usePromise: Promise

  validate = (params) ->
    if params.channels.length > 10
      e = new Error "Can't trigger a message to more than 10 channels"
      e.status = 400
      throw e

  connect = (client) ->
    new Promise (resolve, reject) ->
      client.on 'connect', ->
        resolve()
      .on 'warn', (e) ->
        reject e
      .on 'error', (e) ->
        reject e

  publish = (client, params) ->
    Promise.map params.channels, (channel) ->
      # Invalid value error occurs unless JSON.stringify()
      client.publish "#{channel}:#{params.name}", JSON.stringify(params.data)
    
  pubsub = (client, subcommand, options={}) ->
    client.pubsub subcommand

  constructor: ->
    super()

    @host = process.env.REDIS_HOST
    @host = if @host? then @host else 'localhost'

    @port = parseInt process.env.REDIS_PORT
    @port = 6379 if _.isNaN @port

  trigger: (params={channels, name, data}) =>
    params.channels = [params.channels] unless _.isArray params.channels
    params.channels = _.uniq params.channels
    
    validate.call @, params

    new Promise (resolve, reject) =>
      client = createClient.call @
      connect.call @, client
        .then =>
          publish.call @, client, params
        .then (res) ->
          resolve res
        .catch (e) ->
          reject e
        .finally ->
          client.clientEnd()

  getChannels: (options={}) =>
    new Promise (resolve, reject) =>
      client = createClient.call @
      connect.call @, client
        .then =>
          pubsub.call @, client, 'channels', options
        .then (channels) ->
          resolve channels
        .catch (e) ->
          reject e
        .finally ->
          client.clientEnd()

module.exports = RedisAdapter
