define [
  'views/base/collection-view'
  'views/search/item-view'
], (CollectionView, SearchItemView) ->
  'use strict'

  class SearchItemsView extends CollectionView
    className:  'search-list'
    itemView:   SearchItemView
    tagName:    'ul'
    useCssAnimation: true

    initialize: ->
      @addCollectionListeners()