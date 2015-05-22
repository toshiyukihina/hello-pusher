Adapter = require './adapter'
Pusher = require 'pusher'

# Pusher Adapter
# https://pusher.com/
class PusherAdapter extends Adapter

  constructor: ->
    super()

    params =
      appId: process.env.PUSHER_APPID
      key: process.env.PUSHER_KEY
      secret: process.env.PUSHER_SECRET
    
    unless params.appId? and params.key? and params.secret?
      throw new Error('You must export PUSHER_APPID/PUSHER_KEY/PUSHER_SECRET via ENV')

    @pusher = new Pusher params

  trigger: (params = {channels, name, data}) =>
    console.log "Triggered with #{JSON.stringify(params)}"
    @pusher.trigger params.channels, params.name, params.data

module.exports = PusherAdapter
