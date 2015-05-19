express = require 'express'
Pusher = require 'pusher'

router = express.Router()

router.post '/', (req, res, next) ->
  # No response body
  res.end()

router.post '/:id', (req, res, next) ->
  pusher = new Pusher
    appId: process.env.APPID
    key: process.env.KEY
    secret: process.env.SECRET

  pusher.trigger 'test_channel', 'my_event', req.body

  # No response body
  res.end()

module.exports = router
