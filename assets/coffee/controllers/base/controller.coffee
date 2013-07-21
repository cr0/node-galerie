define [
  'chaplin'
  'views/skeleton-view'
], (Chaplin, SekeltonView) ->
  'use strict'

  class Controller extends Chaplin.Controller
    beforeAction: (params, route) ->
      @compose 'site', SekeltonView
