define (require) ->
  'use strict'

  Chaplin       = require 'chaplin'

  CCollection   = require 'models/base/collection'
  Collection    = require 'models/collection'

  class Collections extends CCollection
    _.extend @prototype, Chaplin.EventBroker

    url:    '/api/collection'
    model:  Collection
