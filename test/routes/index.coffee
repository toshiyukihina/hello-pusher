request = require 'supertest'
app = require '../../app'

describe 'GET /index', ->

  it 'should response text with 200', (done) ->
    request app
      .get '/'
      .expect 200
      .expect 'Content-Type', /text\/html/, done
