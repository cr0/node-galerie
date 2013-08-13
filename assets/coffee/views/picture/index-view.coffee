define (require) ->
  'use strict'

  View            = require 'views/base/view'
  Template        = require 'templates/picture-index'


  class PictureView extends View
    template:   Template
    className:  'picture'

  render: ->
    