define (require) ->
  'use strict'

  Chaplin = require 'chaplin'

  Model   = require 'models/base/model'


  class Location extends Model
    _.extend @prototype, Chaplin.EventBroker

    urlRoot: '/api/location'

    defaults:
      lat:    null
      long:   null

    initialize: (options) ->
      @unset '0'
      @unset '1'
      @set 'lat', options[0]
      @set 'long', options[1]