express = require 'express'
router = express.Router()

getAdapterClass = ->
  libpath = '../../../lib'

  switch process.env.ADAPTER
    when 'pusher' then require "#{libpath}/pusher_adapter"
    when 'pns' then require "#{libpath}/pns_adapter"
    else throw new Error "Adapter type is not set. Export ADAPTER env."

router.post '/', (req, res, next) ->
  Adapter = getAdapterClass()

  adapter = new Adapter()
  adapter.trigger
    channels: req.body.channels
    name: req.body.name
    data: req.body.data

  res.json().end()

module.exports = router
