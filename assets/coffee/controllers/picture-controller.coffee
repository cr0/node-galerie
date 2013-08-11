define (require) ->
  'use strict'

  $                   = require 'jquery'
  utils               = require 'lib/utils'

  AuthController      = require 'controllers/base/auth-controller'
  Collections         = require 'models/collections'
  NewPictureView      = require 'views/picture/new-view'


  class PictureController extends AuthController

    create: (params) ->
      @adjustTitle 'a/Picture'

      collections = new Collections
      collections.fetch()

      @view = new NewPictureView
        region:      'dynamic'
        collection:  collections

      utils.pageTransition $('#dynamic'), 'top'

