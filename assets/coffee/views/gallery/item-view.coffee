define [
  'views/base/view'
  'templates/gallery-item'
], (View, Template) ->
  'use strict'

  class GalleryItemView extends View
    template:   Template
    className:  'item'
    tagName:    'div'
