Adapter = require './adapter'
redis = require 'thunk-redis'
Promise = require 'bluebird'
logger = require('log4js').getLogger()
config = require 'config'
_ = require 'lodash'

class RedisAdapter extends Adapter

  createClient = ->
    logger.info "Connect to redis server: host=#{@host} port=#{@port}"
    redis.createClient @port, @host, usePromise: Promise

  connect = (client) ->
    new Promise (resolve, reject) ->
      client.on 'connect', ->
        resolve()
      .on 'warn', (e) ->
        reject e
      .on 'error', (e) ->
        reject e

  publish = (client, channels, name, data) ->
    Promise.map channels, (channel) ->
      logger.debug "#{channel}:#{name} => #{JSON.stringify(data)}"
      # Invalid value error occurs unless JSON.stringify()
      client.publish "#{channel}:#{name}", JSON.stringify(data)
    
  pubsub = (client, subcommand) ->
    client.pubsub subcommand

  constructor: ->
    super()
    @host = config.redis.host or 'localhost'
    @port = parseInt config.redis.port or 6379

  trigger: ({channels, name, data}) =>
    channels = [channels] unless _.isArray channels
    channels = _.uniq channels

    if channels.length <= 0 or channels.length > 10
      throw new RangeError "Can't trigger a message to more than 10 channels"

    new Promise (resolve, reject) =>
      client = createClient.call @
      connect.call @, client
        .then =>
          publish.call @, client, channels, name, data
        .then (res) ->
          resolve res
        .catch (e) ->
          reject e
        .finally ->
          client.clientEnd()

  getChannels: =>
    new Promise (resolve, reject) =>
      client = createClient.call @
      connect.call @, client
        .then =>
          pubsub.call @, client, 'channels'
        .then (channels) ->
          resolve channels
        .catch (e) ->
          reject e
        .finally ->
          client.clientEnd()

module.exports = RedisAdapter
