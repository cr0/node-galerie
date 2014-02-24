define (require) ->
  'use strict'

  $                   = require 'jquery'
  Chaplin             = require 'chaplin'
  utils               = require 'lib/utils'
  AuthController      = require 'controllers/base/auth-controller'

  Buckets             = require 'models/buckets'

  HomeView            = require 'views/home/index-view'


  class HelloController extends AuthController

    show: (params) ->
      @adjustTitle 'Hello'

      buckets = new Buckets
      buckets.add id: num, name: "gallery #{num}", date: new Date() for num in [1..20]

      @search = new HomeView
        collection:  buckets
        region:     'home'

      utils.pageTransition $('#home'), 'left'

