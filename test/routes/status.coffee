request = require 'supertest'
app = require '../../app'

describe 'GET /status', ->

  it 'should response text with 200', (done) ->
    request app
      .get '/status'
      .expect 200, 'alive'
      .expect 'Connection', 'close'
      .expect 'Content-Type', /text\/plain/, done
