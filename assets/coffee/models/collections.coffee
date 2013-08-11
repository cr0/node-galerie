define [
  'chaplin'
  'models/base/collection'
  'models/collection'
], (Chaplin, Collection, CollectionModel) ->
  'use strict'

  class Collections extends Collection
    _.extend @prototype, Chaplin.EventBroker

    url:    '/api/collection'
    model:  CollectionModel
