define [
  'views/base/view'
  'templates/skeleton'
], (View, Template) ->
  'use strict'

  class SkeletonView extends View
    container: 'div#content'
    id:        'skeleton'
    regions:
      'teaser': '.teaser'
      'main':   '.main'
    template: Template