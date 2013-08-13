define [
  'chaplin'
  'models/base/collection'
  'models/picture'
], (Chaplin, Collection, Picture) ->
  'use strict'

  class Pictures extends Collection
    _.extend @prototype, Chaplin.EventBroker

    url:    => "/api/picture/#{@id}"
    model:  Picture
