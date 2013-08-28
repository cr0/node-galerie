define (require) ->
  'use strict'

  CollectionView  = require 'views/base/collection-view'
  ItemView        = require 'views/picture/bucket-view'
  Template        = require 'templates/picture-buckets'


  class PictureBucketsView extends CollectionView
    template:     Template
    itemView:     ItemView
    listSelector: 'ul.bucket-list'
    
    initialize: ->
      @addCollectionListeners()
