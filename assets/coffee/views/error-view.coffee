define [
  'jquery'
  'lib/utils'
  'views/base/view'
  'templates/error'
], ($, util, View, Template) ->
  'use strict'

  class ErrorView extends View
    template:   Template

    initialize: ->
      super
      @subscribeEvent '!error', (e) => 
        console.error 'A error occured', e
        @model = e
        @render()

    getTemplateData: ->
      data = 
        name:     @model.name
        message:  @model.message
        lineno:   @model.lineNumber
        file:     @model.fileName

      data

    render: ->
      if not @model then return

      super
      util.pageTransition @$el.parent(), 'left'