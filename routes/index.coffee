express = require 'express'
router = express.Router()

# GET home page.
router.get '/', (req, res, next) ->
  res.render 'index',
    title: 'Hello Pusher'

module.exports = router
