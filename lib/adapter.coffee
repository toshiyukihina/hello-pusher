class Adapter

  constructor: ->

  trigger: =>
    throw new Error "You must override trigger()"

  getChannels: (options={}) =>
    throw new Error "You must override getChannels()"

module.exports = Adapter
