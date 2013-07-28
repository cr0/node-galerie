define [
  'chaplin'
  'models/base/model'
  'models/picture-collection'
], (Chaplin, Model, PictureCollection) ->
  'use strict'

  class Gallery extends Model
    _.extend @prototype, Chaplin.EventBroker

    urlRoot: '/gallery'

    defaults:
      type:       'gallery'
      name:       'Galerie'
      pictures:   new PictureCollection
