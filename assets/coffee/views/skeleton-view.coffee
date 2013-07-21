define [
  'views/base/view'
  'templates/skeleton'
], (View, Template) ->
  'use strict'

  class SkeletonView extends View
    container: 'div#main'
    id:        'skeleton'
    regions:
      'main': '#content'
    template: Template