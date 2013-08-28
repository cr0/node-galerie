define (require) ->
  'use strict'

  $                   = require 'jquery'
  utils               = require 'lib/utils'

  AuthController      = require 'controllers/base/auth-controller'
  Buckets             = require 'models/buckets'
  NewPictureView      = require 'views/picture/new-view'


  class PictureController extends AuthController

    create: (params) ->
      @adjustTitle 'a/Picture'

      @view = new NewPictureView
        region:      'dynamic'

      utils.pageTransition $('#dynamic'), 'top'

