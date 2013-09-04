define (require) ->
  'use strict'

  $                   = require 'jquery'
  moment              = require 'moment'
  utils               = require 'lib/utils'

  AuthController      = require 'controllers/base/auth-controller'
  Bucket              = require 'models/bucket'
  NewPictureView      = require 'views/picture/new-view'
  BucketView          = require 


  class PictureController extends AuthController

    create: (params) ->
      @adjustTitle 'a/Picture'
      @redirectToRoute 'bucket_create' 

