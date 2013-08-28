define (require) ->
  'use strict'

  require 'jquery.mousewheel'

  CollectionView  = require 'views/base/collection-view'
  ItemView        = require 'views/picture/picture-view'
  Template        = require 'templates/picture-items'


  class PicturesView extends CollectionView
    template:     Template
    itemView:     ItemView
    className:    'horizontal-scroll'
    listSelector: 'ul.pictures'
    eventhandler: no
    
    initialize: ->
      @addCollectionListeners()

    renderAllItems: ->
      super
      if not @eventhandler
        @eventhandler = yes
        console.debug 'Adding scrollwheel..'
        @$el.children(@listSelector).mousewheel (event, delta) ->
          @scrollLeft -= delta
          event.preventDefault()
