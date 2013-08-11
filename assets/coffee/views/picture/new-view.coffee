define (require) ->
  'use strict'

  View            = require 'views/base/view'
  ToolView        = require 'views/picture/tool-view'
  UploadView      = require 'views/picture/upload-view'
  CollectionsView = require 'views/picture/collections-view'
  Template        = require 'templates/picture-new'


  class PictureNewView extends View
    template:   Template
    className:  'picture'

    regions:
      'tools':        '.tools'
      'collections':  '.collections'
      'upload':       '.upload'

    render: ->
      super

      toolView = new ToolView region: 'tools'
      @subview 'tool', toolView

      uploadView = new UploadView region: 'upload'
      @subview 'upload', uploadView

      console.log @collection

      collectionView = new CollectionsView region: 'collections', collection: @collection
      @subview 'collection', collectionView

