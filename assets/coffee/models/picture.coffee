define [
  'chaplin'
  'models/base/model'
], (Chaplin, Model) ->
  'use strict'

  class Picture extends Model
    _.extend @prototype, Chaplin.EventBroker

    urlRoot: '/picture'

    defaults:
      name:       'Picture'
