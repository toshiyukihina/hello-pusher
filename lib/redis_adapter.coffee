Adapter = require './adapter'
redis = require 'thunk-redis'
Promise = require 'bluebird'
_ = require 'lodash'

class RedisAdapter extends Adapter

  validate = (params) =>
    if params.channels.length > 10
      e = new Error "Can't trigger a message to more than 10 channels"
      e.status = 400
      throw e

  connect = (client) =>
    new Promise (resolve, reject) =>
      client.on 'connect', =>
        resolve()
      .on 'warn', (e) =>
        reject e
      .on 'error', (e) =>
        reject e

  publish = (client, params) =>
    Promise.map params.channels, (channel) =>
      # Invalid value error occurs unless JSON.stringify()
      client.publish "#{channel}:#{params.name}", JSON.stringify(params.data)
    
  constructor: ->
    super()
    @port = parseInt process.env.REDIS_PORT
    @port = 6379 if _.isNaN @port

  trigger: (params={channels, name, data}) =>
    params.channels = [params.channels] unless _.isArray params.channels
    
    validate.call @, params

    new Promise (resolve, reject) =>
      client = redis.createClient @port, usePromise: Promise
      connect.call @, client
        .then =>
          publish.call @, client, params
        .then (res) =>
          resolve res
        .catch (e) =>
          reject e
        .finally =>
          client.clientEnd()

module.exports = RedisAdapter
