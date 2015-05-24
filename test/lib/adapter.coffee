Adapter = require '../../lib/adapter'

describe 'Adapter', ->

  it 'trigger should throw Error', (done) ->
    adapter = new Adapter()
    adapter.trigger.should.throw()
    done()

  it 'getChannels should throw Error', (done) ->
    adapter = new Adapter()
    adapter.getChannels.should.throw()
    done()
