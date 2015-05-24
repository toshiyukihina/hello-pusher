express = require 'express'
router = express.Router()
HTTPStatus = require 'http-status'

router.get '/', (req, res, next) ->
  res.set
    'Connection': 'close'
    'Content-Type': 'text/plain'
  res.status(HTTPStatus.OK).send('alive')

module.exports = router
