Adapter = require '../../lib/adapter'

describe 'Adapter', ->

  describe '#trigger()', ->

    it 'should throw Error', (done) ->
      adapter = new Adapter()
      adapter.trigger.should.throw()
      done()

  describe '#getChannels()', ->

    it 'should throw Error', (done) ->
      adapter = new Adapter()
      adapter.getChannels.should.throw()
      done()
