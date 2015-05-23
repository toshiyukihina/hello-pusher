request = require 'supertest'
app = require '../app'

describe 'GET /index', ->

  it 'should response text with 200', (done) ->
    request app
      .get '/'
      .expect 200
      .expect 'Content-Type', /text\/html/, done

describe 'GET /api/v1/channels (Using RedisAdapter)', ->

  before ->
    process.env.ADAPTER = 'redis'

  after ->
    process.env.ADAPTER = undefined

  it 'should response with 200', (done) ->
    request app
      .get '/api/v1/channels'
      .expect 'Content-Type', /json/
      .expect 200, done

describe 'GET /api/v1/channels (Using PusherAdapter)', ->

  before ->
    process.env.ADAPTER = 'pusher'
    process.env.PUSHER_APPID = '<Your valid appid>'
    process.env.PUSHER_KEY = '<Your valid key>'
    process.env.PUSHER_SECRET = '<Your valid secret>'

  after ->
    process.env.ADAPTER = undefined
    process.env.PUSHER_APPID = undefined
    process.env.PUSHER_KEY = undefined
    process.env.PUSHER_SECRET = undefined

  it 'should response with 200', (done)->
    request app
      .get '/api/v1/channels'
      .expect 'Content-Type', /json/
      .expect 200, done
