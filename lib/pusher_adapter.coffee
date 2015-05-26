Adapter = require './adapter'
Pusher = require 'pusher'
Promise = require 'bluebird'
HTTPStatus = require 'http-status'
_ = require 'lodash'
logger = require('log4js').getLogger()

# Pusher Adapter
# https://pusher.com/
class PusherAdapter extends Adapter

  constructor: ->
    super()

    params =
      appId: process.env.PUSHER_APPID
      key: process.env.PUSHER_KEY
      secret: process.env.PUSHER_SECRET
    
    if _.isEmpty(params.appId) or _.isEmpty(params.key) or _.isEmpty(params.secret)
      throw new Error 'You must export PUSHER_APPID/PUSHER_KEY/PUSHER_SECRET via ENV'

    @pusher = new Pusher params

  trigger: ({channels, name, data}) =>
    channels = [channels] unless _.isArray channels
    channels = _.uniq channels
    data ?= {}

    new Promise (resolve, reject) =>
      try
        @pusher.trigger channels, name, data
        resolve()
      catch e
        e.status = HTTPStatus.BAD_REQUEST
        reject e

  getChannels: =>
    new Promise (resolve, reject) =>
      try
        @pusher.get
          path: '/channels'
          params: {}
        , (error, request, response) ->
          unless error?
            resolve JSON.parse(response.body)
          else
            logger.error error
            e = new Error "#{error.message}"
            reject e
      catch e
        reject e

module.exports = PusherAdapter
