define [
  'jquery'
  'lib/utils'
  'controllers/base/controller'
  'models/current-user'
  'models/gallery'
  'models/gallery-collection'
  'views/search/search-view'
  'views/search/items-view'
], ($, utils, Controller, CurrentUser, Gallery, GalleryCollection, SearchView, SearchItemsView) ->
  'use strict'

  class HelloController extends Controller

    show: (params) ->
      @title = 'Hello'

      @currentuser = new CurrentUser
      
      collection = new GalleryCollection
      collection.add id: num, name: "gallery #{num}" for num in [1..6]

      @currentuser.fetch
        success: (model) =>
          @search = new SearchView
            model:  model
            region: 'search'

          @results = new SearchItemsView
            collection: collection
            region:     'results'

          utils.pageTransition $('#search'), 'left'

        denied: => 
          @currentuser.dispose()
          @redirectToRoute 'login'
          
        error: (model, error) -> console.error 'error requesting', error


    imprint: (params) ->
      @title = 'Imprint'
      
      utils.pageTransition $('#imprint'), 'bottom'

