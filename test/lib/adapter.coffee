Adapter = require '../../lib/adapter'

describe 'Adapter', ->
  adapter = undefined

  beforeEach ->
    adapter = new Adapter()
  
  afterEach ->
    adapter = undefined

  it 'trigger should throw Error', (done) ->
    catched = try
      adapter.trigger()
      false
    catch e
      true

    catched.should.equal true
    done()

  it 'getChannels should throw Error', (done) ->
    catched = try
      adapter.getChannels()
      false
    catch e
      true

    catched.should.equal true
    done()
