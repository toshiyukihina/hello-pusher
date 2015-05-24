PusherAdapter = require '../../lib/pusher_adapter'
assert = require 'assert'

describe 'PusherAdapter', ->

  describe '#new()', ->

    context 'if all of env vars are not exported', ->

      before ->
        delete process.env.PUSHER_APPID
        delete process.env.PUSHER_KEY 
        delete process.env.PUSHER_SECRET

      it 'should throw an exception', (done) ->
        PusherAdapter.should.throw()
        done()
  
    context 'if all of env vars are empty', ->

      before ->
        process.env.PUSHER_APPID = ''
        process.env.PUSHER_KEY = ''
        process.env.PUSHER_SECRET = ''

      it 'should throw an exception', (done) ->
        PusherAdapter.should.throw()
        done()

    context 'if one of env vars are not exported', ->

      before ->
        process.env.PUSHER_APPID = 'your-app-id'
        process.env.PUSHER_KEY = 'your-key'
        delete process.env.PUSHER_SECRET

      it 'should throw an exception', (done) ->
        PusherAdapter.should.throw()
        done()

    context 'if one of env vars are empty', ->

      before ->
        process.env.PUSHER_APPID = ''
        process.env.PUSHER_KEY = 'your-key'
        process.env.PUSHER_SECRET = 'your-secret'

      it 'should throw an exception', (done) ->
        PusherAdapter.should.throw()
        done()

    context 'if all of env vars are exported', ->

      before ->
        process.env.PUSHER_APPID = 'your-appid'
        process.env.PUSHER_KEY = 'your-key'
        process.env.PUSHER_SECRET = 'your-secret'

      after ->
        delete process.env.PUSHER_APPID
        delete process.env.PUSHER_KEY 
        delete process.env.PUSHER_SECRET

      it 'should throw an exception', (done) ->
        PusherAdapter.should.not.throw()
        done()

  describe '#trigger()', ->

    adapter = null

    before ->
      process.env.PUSHER_APPID = 'your-appid'
      process.env.PUSHER_KEY = 'your-key'
      process.env.PUSHER_SECRET = 'your-secret'
      adapter = new PusherAdapter()

    context 'if the valid params are given', ->

      it 'should call then()', (done) ->
        # Pass the valid param
        promise = adapter.trigger
          channels: ['my_channel1', 'my_channel2']
          name: 'my_evnet'
          data: {}
          
        promise.then -> assert true
        .finally -> done()

    context 'if the invalid params are given', ->

      it 'should fail (no params)', (done) ->
        adapter.trigger.should.throw()
        done()

      it.skip 'should fail (only channels given)', (done) ->
        adapter.trigger(channels: ['my_channel']).should.throw()
        done()
