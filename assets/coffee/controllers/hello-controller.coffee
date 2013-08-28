define (require) ->
  'use strict'

  $                   = require 'jquery'
  Chaplin             = require 'chaplin'
  utils               = require 'lib/utils'
  AuthController      = require 'controllers/base/auth-controller'

  Buckets             = require 'models/buckets'

  SearchView          = require 'views/search/search-view'
  SearchItemsView     = require 'views/search/items-view'


  class HelloController extends AuthController

    show: (params) ->
      @adjustTitle 'Hello'
      
      buckets = new Buckets
      buckets.add id: num, name: "gallery #{num}" for num in [1..8]

      @search = new SearchView
        model:  Chaplin.mediator.user
        region: 'search'

      @results = new SearchItemsView
        collection: buckets
        region:     'results'

      utils.pageTransition $('#search'), 'left'

