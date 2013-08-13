define [
  'chaplin'
  'models/base/model'
], (Chaplin, Model) ->
  'use strict'

  class Collection extends Model
    _.extend @prototype, Chaplin.EventBroker

    urlRoot: '/api/collection'

    defaults:
      name:       'Galerie'
