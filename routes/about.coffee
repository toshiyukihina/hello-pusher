express = require 'express'
router = express.Router()
pjson = require '../package.json'

router.get '/', (req, res, next) ->
  res.json
    name: pjson.name
    version: pjson.version

module.exports = router
