define (require) ->
  'use strict'

  View            = require 'views/base/view'
  Template        = require 'templates/picture-bucket'


  class PictureBucketView extends View
    template:   Template
    className:  'item'