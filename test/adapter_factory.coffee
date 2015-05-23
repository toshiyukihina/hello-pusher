AdapterFactory = require '../lib/adapter_factory'
PusherAdapter = require '../lib/pusher_adapter'
RedisAdapter = require '../lib/redis_adapter'

describe 'AdapterFactory', ->

  describe 'PusherAdapter', ->

    before ->
      process.env.ADAPTER = 'pusher'

    it 'should create PusherAdapter', (done) ->
      Adapter = AdapterFactory.getAdapter()
      Adapter.should.equal PusherAdapter
      done()

  describe 'RedisAdapter', ->

    before ->
      process.env.ADAPTER = 'redis'

    it 'should create RedisAdapter', (done) ->
      Adapter = AdapterFactory.getAdapter()
      Adapter.should.equal RedisAdapter
      done()
