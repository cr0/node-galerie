define [
  'chaplin'
  'models/base/model'
], (Chaplin, Model) ->

  class Collection extends Chaplin.Collection
    _.extend @prototype, Chaplin.SyncMachine

    model: Model

    fetch: (options = {}) ->
      @beginSync()

      success = options.success
      denied = options.denied
      error = options.error

      options.success = (collection, response, options) =>
        success? collection, response, options
        @finishSync()

      options.error = (collection, response, options) =>
        if response.status is 401 and typeof denied is 'function' then denied? collection, response, options
        else error? collection, response, options
        @abortSync()

      super options