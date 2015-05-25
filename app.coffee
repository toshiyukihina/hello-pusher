express = require 'express'
path = require 'path'
cookieParser = require 'cookie-parser'
bodyParser = require 'body-parser'
log4js = require('log4js')
logger = log4js.getLogger()
HTTPStatus = require 'http-status'

app = express()

# view engine setup
app.set 'views', path.join __dirname, 'views'
app.set 'view engine', 'jade'
app.set 'x-powered-by', false

app.use bodyParser.json()
app.use bodyParser.urlencoded
  extended: false
app.use cookieParser()
app.use require('less-middleware') path.join __dirname, 'public'
app.use express.static path.join __dirname, 'public'

# Logger setting
app.use log4js.connectLogger(log4js.getLogger('http'),
  level: 'auto'
  nolog: [
    '\\.css'
    '\\.js'
    '\\.gif'
  ]
  format: JSON.stringify
    'remote-addr': ':remote-addr'
    'method': ':method'
    'url': ':url'
    'http-version': ':http-version'
    'status': ':status'
    'content-length': ':content-length'
    'referrer': ':referrer'
    'user-agent': ':user-agent'
)

# Router setting
index = require './routes/index'
status = require './routes/status'
about = require './routes/about'
channels = require './routes/api/v1/channels'
events = require './routes/api/v1/events'

app.use '/', index
app.use '/status', status
app.use '/about', about
app.use '/api/v1/channels', channels
app.use '/api/v1/events', events

# catch 404 and forward to error handler
app.use (req, res, next) ->
  err = new Error 'Not Found'
  err.status = HTTPStatus.NOT_FOUND
  next err

# error handlers

# development error handler
if app.get('env') is 'development'
    app.use (err, req, res, next) ->
      logger.error err.stack
      res.status err.status or HTTPStatus.INTERNAL_SERVER_ERROR
        .json message: err.message

# production error handler
app.use (err, req, res, next) ->
  logger.error err.stack
  res.status err.status or HTTPStatus.INTERNAL_SERVER_ERROR
    .json message: err.message

module.exports = app
