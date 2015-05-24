request = require 'supertest'
should = require 'should'
app = require '../../app'

describe 'GET /about', ->
  
  it 'should return about info as json with status 200 OK', (done) ->
    request app
      .get '/about'
      .expect 'Content-Type', /json/
      .expect 200
      .end (err, res) ->
        about = res.res.body
        about.should.have.property 'name'
        about.should.have.property 'version'
        done()
