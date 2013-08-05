define [
  'lib/utils'
  'views/base/view'
  'templates/skeleton'
], (utils, View, Template) ->
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
      'dynamic':  '#dynamic'
    template: Template

    initialize: ->
      super
      @subscribeEvent 'loggedout', -> @publishEvent '!router:routeByName', 'hello_home'