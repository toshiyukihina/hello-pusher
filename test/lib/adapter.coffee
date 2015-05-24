Adapter = require '../../lib/adapter'

describe 'Adapter', ->

  describe '#trigger()', ->

    context 'if the trigger() method is not overridden', ->

      it 'should throw Error', (done) ->
        adapter = new Adapter()
        adapter.trigger.should.throw()
        done()

  describe '#getChannels()', ->

    context 'if the getChannels() method is not overridden', ->

      it 'should throw Error', (done) ->
        adapter = new Adapter()
        adapter.getChannels.should.throw()
        done()
