define [
  'views/base/collection-view'
  'views/gallery/item-view'
  'lazyload'
  'mousewheel'
  'scrollto'
], (CollectionView, GalleryItemView) ->
  'use strict'

  class GalleryItemsView extends CollectionView
    className:  'wrapper'
    itemView:   GalleryItemView
    tagName:    'div'
    useCssAnimation: false

    initialize: ->
      @addCollectionListeners()

    renderAllItems: ->
      super
      $images = @$el.find('.item > img')
      #$images.css 'display', 'none'
      $images.lazyload
        threshold: 400
        container: @$el
        effect:   "fadeIn"
        skip_invisible: false

      # show the first N pictures directly
      $images.filter(":lt(#{@inititems ? 10})").trigger('appear')

      $images.click (e) =>
        console.log('click!', e)
        @$el.scrollTo $(e.target), axis: 'x', duration: 600, easing: 'swing', offset: {left: -50}

      @$el.mousewheel (event, delta) ->
        @scrollLeft -= delta
        event.preventDefault()