define (require) ->
  'use strict'

  CollectionView  = require 'views/base/collection-view'
  ItemView        = require 'views/picture/collection-view'
  Template        = require 'templates/picture-collections'


  class PictureCollectionsView extends CollectionView
    template:     Template
    itemView:     ItemView
    listSelector: 'ul.collection-list'

    initialize: ->
      @addCollectionListeners()
