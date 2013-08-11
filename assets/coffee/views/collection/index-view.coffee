define [
  'views/base/view'
  'templates/gallery'
], (View, Template) ->
  'use strict'

  class CollectionView extends View
    template:   Template

    regions:
      'images': '.images'