define [
  'views/base/view'
  'templates/skeleton'
], (View, Template) ->
  'use strict'

  class SkeletonView extends View
    container: 'div#content'
    id:        'skeleton'
    className: 'skeleton'
    regions:
      'imprint':  '#imprint'
      'login':    '#login'
      'search':   '#search'
      'gallery':  '#gallery'
      'setting':  '#setting'
    template: Template