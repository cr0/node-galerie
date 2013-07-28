define [
  'chaplin'
], (Chaplin) ->
  'use strict'

  class Model extends Chaplin.Model
    
    idAttribute: '_id'

    fetch: (options = {}) ->
      success = options.success
      denied = options.denied
      error = options.error

      options.success = (model, response, options) =>
        success? model, response, options

      options.error = (model, response, options) =>
        if response.status is 401 and typeof denied is 'function' then denied? model, response, options
        else error? model, response, options

      super options
