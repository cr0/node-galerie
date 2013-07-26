define [
  'jquery'
  'lib/utils'
  'controllers/base/controller'
], ($, utils, Controller) ->
  'use strict'

  class HelloController extends Controller

    show: (params) ->
      @title = 'Hello'

      $out = $('.pt-page.pt-page-current').first()
      $in = $('#search')

      utils.pageTransition $in, $out, 'left'

    imprint: (params) ->
      @title = 'Imprint'
      
      $out = $('.pt-page.pt-page-current').first()
      $in = $('#imprint')

      utils.pageTransition $in, $out, 'bottom'

