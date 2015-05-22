Adapter = require './adapter'
redis = require 'thunk-redis'
Promise = require 'bluebird'

class PnsAdapter extends Adapter

  publish = (client, params) ->
    requests = for channel in params.channels
      client.publish "#{channel}:#{params.name}", JSON.stringify(params.data)

    Promise.all requests

  constructor: ->
    super()
    @port = 6379

  trigger: (params={channels, name, data}) =>
    client = redis.createClient @port, usePromise: Promise

    client
      .on 'connect', ->
        publish.call @, client, params
          .then (results) ->
            console.log "Success"
          .catch (e) ->
            console.error e
          .finally ->
            client.clientEnd()
      .on 'warn', (e) ->
        throw new Error e
      .on 'error', (e) ->
        throw new Error e

module.exports = PnsAdapter
