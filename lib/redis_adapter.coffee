Adapter = require './adapter'
redis = require 'thunk-redis'
Promise = require 'bluebird'
_ = require 'lodash'

class RedisAdapter extends Adapter

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
      client.publish "#{channel}:#{params.name}", JSON.stringify(params.data)
    
  constructor: ->
    super()
    @port = parseInt process.env.REDIS_PORT
    @port = 6379 if _.isNaN @port

  trigger: (params={channels, name, data}) =>
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
