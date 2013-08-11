define (require) ->
  'use strict'

  View            = require 'views/base/view'
  Template        = require 'templates/picture-tool'


  class PictureToolView extends View
    template:   Template

    events:
      'click #create-collection': 'showCollectionTools'

    showCollectionTools: ->
      @$el.find('.create-collection').fadeToggle()
