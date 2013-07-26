define [
  'jquery'
  'lib/utils'
  'controllers/base/controller'
], ($, utils, Controller) ->
  'use strict'

  class AuthController extends Controller

    form: (params) ->
      @title = 'Login'

      $out = $('.pt-page.pt-page-current').first()
      $in = $('#login')

      utils.pageTransition $in, $out, 'top'

