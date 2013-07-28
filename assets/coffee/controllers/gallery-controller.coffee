define [
  'jquery'
  'lib/utils'
  'controllers/base/controller'
  'models/current-user'
  'models/gallery'
  'views/gallery/gallery-view'
  'views/gallery/items-view'
], ($, utils, Controller, CurrentUser, Gallery, GalleryView, GalleryItemsView) ->
  'use strict'

  class HelloController extends Controller

    show: (params) ->
      @title = 'Gallery'

      @currentuser = new CurrentUser
      @gallery = new Gallery name: "Test #{params.id}"
      @gallery.get('pictures').add id: num for num in [1..10]

      @currentuser.fetch
        success: (model) =>
          @search = new GalleryView
            model:   @gallery
            region: 'gallery'

          @pictures = new GalleryItemsView
            collection:   @gallery.get 'pictures'
            region:       'images'

          utils.pageTransition $('#gallery'), 'right'

        denied: => 
          @currentuser.dispose()
          @redirectToRoute 'login'
        error: (model, error) -> console.error 'error requesting', error
