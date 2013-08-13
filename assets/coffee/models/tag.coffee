define (require) ->
  'use strict'

  Chaplin       = require 'chaplin'

  Model         = require 'models/base/model'


  class Tag extends Model
    _.extend @prototype, Chaplin.EventBroker

    urlRoot: '/api/tag'

    defaults:
      name:   null