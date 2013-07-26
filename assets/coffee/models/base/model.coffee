define [
  'chaplin'
], (Chaplin) ->
  'use strict'

  class Model extends Chaplin.Model
    _.extend @prototype, Chaplin.SyncMachine

    fetch: (options = {}) ->
      @beginSync()

      success = options.success
      error = options.error

      options.success = (model, response) =>
        success? model, response
        @finishSync()

      options.error = (model, err) =>
        error? model, err
        @abortSync()

      super options
