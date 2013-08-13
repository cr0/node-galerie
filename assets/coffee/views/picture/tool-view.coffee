define (require) ->
  'use strict'

  View            = require 'views/base/view'
  Template        = require 'templates/picture-tool'


  class PictureToolView extends View
    template:   Template

    events:
      'click #create-collection': 'showCreateCollection'
      'click #use-collection':    'showUseCollection'

    showCreateCollection: ->
      @$el.find('.create-collection').fadeToggle()

    showUseCollection: ->
      @$el.find('.collections').fadeToggle()
