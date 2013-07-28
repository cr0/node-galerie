define [
  'views/base/collection-view'
  'views/gallery/item-view'
], (CollectionView, GalleryItemView) ->
  'use strict'

  class GalleryItemsView extends CollectionView
    className:  'wrapper'
    itemView:   GalleryItemView
    tagName:    'div'
    useCssAnimation: true

    initialize: ->
      @addCollectionListeners()