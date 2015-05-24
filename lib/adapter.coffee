_ = require 'lodash'

class Adapter

  constructor: ->

  trigger: ({channels, event, data}) =>
    throw new Error "You must override trigger()"

  getChannels: =>
    throw new Error "You must override getChannels()"

module.exports = Adapter
