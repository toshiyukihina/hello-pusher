express = require 'express'
router = express.Router()
AdapterFactory = require '../../../lib/adapter_factory'

router.get '/', (req, res, next) ->
  Adapter = AdapterFactory.getAdapter()
  adapter = new Adapter()
  adapter.getChannels().then (channels) ->
    res.json(channels).end()
  .catch (e) ->
    next e

module.exports = router
