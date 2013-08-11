define [
  'jquery'
  'chaplin'
  'lib/utils'
  'controllers/base/auth-controller'
  'models/collections'
  'views/search/search-view'
  'views/search/items-view'
], ($, Chaplin, utils, AuthController, Collections, SearchView, SearchItemsView) ->
  'use strict'

  class HelloController extends AuthController

    show: (params) ->
      @adjustTitle 'Hello'
      
      collection = new Collections
      collection.add id: num, name: "gallery #{num}" for num in [1..8]

      @search = new SearchView
        model:  Chaplin.mediator.user
        region: 'search'

      @results = new SearchItemsView
        collection: collection
        region:     'results'

      utils.pageTransition $('#search'), 'left'

