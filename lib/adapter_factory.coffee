class AdapterFactory
  
  @getAdapter: ->
    switch process.env.ADAPTER
      when 'pusher' then require './pusher_adapter'
      when 'redis' then require './redis_adapter'
      else throw new Error 'Adapter type is not set. Export ADAPTER env.'

module.exports = AdapterFactory
