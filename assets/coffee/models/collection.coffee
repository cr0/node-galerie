define [
  'chaplin'
  'models/base/model'
  'models/pictures'
], (Chaplin, Model, Pictures) ->
  'use strict'

  class Collection extends Model
    _.extend @prototype, Chaplin.EventBroker

    urlRoot: '/api/collection'

    defaults:
      name:       'Galerie'
      pictures:   new Pictures
