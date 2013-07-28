define [
  'views/base/view'
  'templates/gallery'
], (View, Template) ->
  'use strict'

  class GalleryView extends View
    template:   Template

    regions:
      'images': '.images'