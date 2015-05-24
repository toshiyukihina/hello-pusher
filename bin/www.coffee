#!/usr/bin/env coffee

# Module dependencies.
app = require '../app'
debug = require('debug') 'pns-pub:server'
http = require 'http'
config = require 'config'
log4js = require 'log4js'
log4js.configure config.log4js

# Load environment variables
require('dotenv').load()

try
  require('fs').mkdirSync('logs')
catch e
  if e.code isnt 'EEXIST'
    console.log 'Could not set up log directory, error was: ', e
    process.exit 1

# Normalize a port into a number, string, or false.
normalizePort = (val) ->
  port = parseInt val, 10

  # named pipe
  if isNaN port
    val
  # port number
  else if port >= 0
    port
  else
    false

# Event listener for HTTP server "error" event.
onError = (error) ->
  if error.syscall isnt 'listen'
    throw error

  bind = if typeof port is 'string' then "Pipe #{port}" else "Port #{port}"

  # handle specific listen errors with friendly messages
  switch error.code
    when 'EACCES'
      console.error "#{bind} requires elevated privileges"
      process.exit 1
    when 'EADDRINUSE'
      console.error "#{bind} is already in use"
      process.exit 1
    else
      throw error

# Event listener for HTTP server "listening" event.
onListening = ->
  addr = server.address()
  bind = if typeof addr is 'string' then "pipe #{addr}" else "port #{addr.port}"
  debug "Listening on #{bind}"


# Get port from environment and store in Express.
port = normalizePort(config.http.port) or '3000'
app.set 'port', port

# Create HTTP server.
server = http.createServer app

# Listen on provided port, on all network interfaces.
server.listen port
server.on 'error', onError
server.on 'listening', onListening
