define (require) ->
  'use strict'

  View            = require 'views/base/view'
  Template        = require 'templates/picture-collection'


  class PictureCollectionView extends View
    template:   Template
    className:  'item'