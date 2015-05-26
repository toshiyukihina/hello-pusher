Adapter = require './adapter'
redis = require 'thunk-redis'
Promise = require 'bluebird'
logger = require('log4js').getLogger()
config = require 'config'
_ = require 'lodash'

pjson = require('../package.json')
debug = require('debug') "#{pjson.name}:RedisAdapter"


class RedisAdapter extends Adapter

  createClient = ->
    logger.debug ">>> Connect to redis server: host=#{@host} port=#{@port}"
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
      debug "#{channel}:#{name} => #{JSON.stringify(data)}"
      # Invalid value error occurs unless JSON.stringify()
      client.publish "#{channel}:#{name}", JSON.stringify(data)
    
  pubsub = (client, subcommand) ->
    client.pubsub subcommand

  channelValues = (channels) ->
    channels = [channels] unless _.isArray channels
    channels = _.uniq channels
    unless 0 < channels.length <= 10
      throw new RangeError "Can't trigger a message to more than 10 or less than 1 channels"
    channels

  constructor: ->
    super()
    @host = config.redis.host or 'localhost'
    @port = parseInt config.redis.port or 6379

  trigger: ({channels, name, data}) =>
    new Promise (resolve, reject) =>
      channels = channelValues.call @, channels

      client = createClient.call @
      connect.call @, client
        .then =>
          publish.call @, client, channels, name, data
        .then (res) ->
          resolve res
        .catch (e) ->
          reject e
        .finally ->
          logger.debug '<<< Disconnected from redis server'
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
          logger.debug '<<< Disconnected from redis server'
          client.clientEnd()

module.exports = RedisAdapter
