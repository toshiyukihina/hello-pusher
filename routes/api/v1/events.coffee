express = require 'express'
router = express.Router()
AdapterFactory = require '../../../lib/adapter_factory'

router.post '/', (req, res, next) ->
  Adapter = AdapterFactory.getAdapter()
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
