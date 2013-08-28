define (require) ->
  'use strict'

  $                   = require 'jquery'
  utils               = require 'lib/utils'
  
  AuthController      = require 'controllers/base/auth-controller'

  Bucket              = require 'models/bucket'

  CollectionView      = require 'views/collection/index-view'
  CollectionItemsView = require 'views/collection/items-view'
  NewCollectionView   = require 'views/collection/new-view'

  class BucketController extends AuthController

    show: (params) ->
      @adjustTitle 'bucket'

      @bucket = new Bucket _id: params.id
      @bucket.fetch
        success: (bucket) =>
          @pictures = @bucket.get('pictures')
          @pictures.id = '1234'
          @pictures.add id: num, url: "//lorempixel.com/1600/1200/?r=#{num}" for num in [1..40]

          @search = new CollectionView
            model:   @gallery
            region: 'gallery'

          @pictures = new CollectionItemsView
            collection:   @pictures
            region:       'images'
            preload:      params.preload ? 10

          utils.pageTransition $('#gallery'), 'right'

        error: (bucket, error) =>
          @publishEvent '!error', error


    create: (params) ->
      @adjustTitle 'a/Collection'

      @view = new NewCollectionView
        region: 'dynamic'

      utils.pageTransition $('#dynamic'), 'top'

