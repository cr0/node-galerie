define [
  'chaplin'
  'models/base/collection'
  'models/gallery'
], (Chaplin, Collection, Gallery) ->
  'use strict'

  class GalleryCollection extends Collection
    _.extend @prototype, Chaplin.EventBroker

    url:    '/gallery'
    model:  Gallery
