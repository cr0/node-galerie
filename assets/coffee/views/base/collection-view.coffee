define [
  'chaplin',
  'views/base/view'
], (Chaplin, View) ->
  'use strict'

  class CollectionView extends Chaplin.CollectionView
    autoRender: true
    getTemplateFunction: View::getTemplateFunction
    
    render: ->
      super
      @trigger 'rendered'
    
    dispose: ->
      window.setTimeout () =>
        console.log 'dispose', @
        super
      , 600
