define [
  'chaplin'
  'views/footer-view'
  'views/skeleton-view'
  'views/imprint-view'
  'views/login-view'
  'views/error-view'
], (Chaplin, FooterView, SekeltonView, ImprintView, LoginView, ErrorView) ->
  'use strict'

  class Controller extends Chaplin.Controller
    beforeAction: (params, route) ->
      @compose 'footer', FooterView
      @compose 'site', SekeltonView
      @compose 'imprint', ImprintView, region: 'imprint'
      @compose 'login', LoginView, region: 'login'
      @compose 'error', ErrorView, region: 'dynamic'



