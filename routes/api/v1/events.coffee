express = require 'express'
router = express.Router()

getAdapterClass = ->
  libpath = '../../../lib'

  switch process.env.ADAPTER
    when 'pusher'
      require "#{libpath}/pusher_adapter"
    when 'pns'
      require "#{libpath}/redis_adapter"
    else
      throw new Error "Adapter type is not set. Export ADAPTER env."

router.post '/', (req, res, next) ->
  Adapter = getAdapterClass()

  adapter = new Adapter()
  adapter.trigger
    channels: req.body.channels
    name: req.body.name
    data: req.body.data
  .then ->
    res.json().end()
  .catch (e) ->
    next e

module.exports = router
