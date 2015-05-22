class Adapter

  constructor: ->

  trigger: =>
    throw new Error "You must override trigger() method."

module.exports = Adapter
