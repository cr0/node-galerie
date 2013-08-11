define [
  'chaplin'
], (Chaplin) ->
  'use strict'

  class Model extends Chaplin.Model
    _.extend @prototype, Chaplin.SyncMachine
    
    idAttribute: '_id'

    fetch: (options = {}) ->
      class ServerError extends Error
        constructor: (@name, @code, @message, @stack) ->

      @beginSync()

      success = options.success
      denied = options.denied
      error = options.error

      options.success = (model, response, options) =>
        success? model, response, options
        @finishSync()

      options.error = (model, response, options) =>
        json     = response.responseJSON.error
        response = new ServerError json.name, json.code, json.message, json.details?.stack
        if response.status is 401 or 403 and typeof denied is 'function' then denied? model, response, options
        else error? model, response, options
        @abortSync()

      super options

    # make usage of save more comfortable
    save: (cb, attributes = {}) ->
      super attributes, cb
