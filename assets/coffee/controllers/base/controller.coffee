define [
  'chaplin'
  'views/skeleton-view'
  'views/imprint-view'
  'views/login-view'
  'views/search-view'
], (Chaplin, SekeltonView, ImprintView, LoginView, SearchView) ->
  'use strict'

  class Controller extends Chaplin.Controller
    beforeAction: (params, route) ->
      @compose 'site', SekeltonView
      @compose 'imprint', ImprintView, region: 'imprint'
      @compose 'login', LoginView, region: 'login'
      @compose 'search', SearchView, region: 'search'
