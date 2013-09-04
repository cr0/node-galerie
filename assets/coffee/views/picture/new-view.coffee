define (require) ->
  'use strict'

  View            = require 'views/base/view'
  ToolView        = require 'views/picture/tool-view'
  UploadView      = require 'views/picture/upload-view'
  Template        = require 'templates/picture-new'


  class PictureNewView extends View
    template:   Template
    className:  'picture'

    regions:
      'tools':        '.tools'
      'upload':       '.upload'

    render: ->
      super

      toolView = new ToolView region: 'tools'
      @subview 'tool', toolView

      uploadView = new UploadView region: 'upload'
      @subview 'upload', uploadView, model: @model # model is a temporary bucket

