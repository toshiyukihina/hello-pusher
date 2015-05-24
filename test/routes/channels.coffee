request = require 'supertest'
app = require '../../app'

describe 'GET /api/v1/channels', ->

  context 'if the adapter is RedisAdapter', ->

    before ->
      process.env.ADAPTER = 'redis'

    after ->
      delete process.env.ADAPTER

    it 'should response with 200', (done) ->
      request app
        .get '/api/v1/channels'
        .expect 'Content-Type', /json/
        .expect 200, done


  context 'if the adapter is PusherAdapter', ->

    context 'if the valid env is exported', ->

      before ->
        process.env.ADAPTER = 'pusher'
        process.env.PUSHER_APPID = 'your-appid'
        process.env.PUSHER_KEY = 'your-key'
        process.env.PUSHER_SECRET = 'your-secret'

      after ->
        delete process.env.ADAPTER
        delete process.env.PUSHER_APPID
        delete process.env.PUSHER_KEY
        delete process.env.PUSHER_SECRET

      it.skip 'should response with 200', (done)->
        request app
          .get '/api/v1/channels'
          .expect 'Content-Type', /json/
          .expect 200, done
