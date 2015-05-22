express = require 'express'
Pusher = require 'pusher'

router = express.Router()

router.get '/', (req, res, next) ->
  # TODO: Not implemented
  res.end()

module.exports = router
