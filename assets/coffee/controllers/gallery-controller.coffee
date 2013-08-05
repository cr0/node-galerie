define [
  'jquery'
  'lib/utils'
  'controllers/base/auth-controller'
  'models/gallery'
  'views/gallery/gallery-view'
  'views/gallery/items-view'
], ($, utils, AuthController, Gallery, GalleryView, GalleryItemsView) ->
  'use strict'

  class HelloController extends AuthController

    show: (params) ->
      @adjustTitle 'Gallery'

      @gallery = new Gallery name: "Test #{params.id}"
      @pictures = @gallery.get('pictures')
      @pictures.id = '1234'
      @pictures.add id: num, url: "//lorempixel.com/1600/1200/?r=#{num}" for num in [1..40]

      @search = new GalleryView
        model:   @gallery
        region: 'gallery'

      @pictures = new GalleryItemsView
        collection:   @pictures
        region:       'images'
        preload:      params.preload ? 10

      utils.pageTransition $('#gallery'), 'right'

