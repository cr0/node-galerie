define [
  'chaplin'
  'models/base/collection'
  'models/picture'
], (Chaplin, Collection, Picture) ->
  'use strict'

  class PictureCollection extends Collection
    _.extend @prototype, Chaplin.EventBroker

    url:    => "/picture/#{@id}"
    model:  Picture
