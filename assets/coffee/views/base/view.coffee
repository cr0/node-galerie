define [
  'chaplin'
  'lib/view-helper'
], (Chaplin) ->
  'use strict'

  class View extends Chaplin.View
    autoRender: true
    getTemplateFunction: -> @template
    
    render: ->
      super
      @trigger 'rendered'

    dispose: ->
      window.setTimeout () =>
        super
      , 600
