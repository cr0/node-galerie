define [
  'jquery'
  'lib/utils'
  'controllers/base/controller'
  'models/current-user'
  'views/search-view'
], ($, utils, Controller, CurrentUser, SearchView) ->
  'use strict'

  class HelloController extends Controller

    show: (params) ->
      @title = 'Hello'

      @model = CurrentUser

      proceed = =>
        if @model.get 'loggedin'
          @view = new SearchView
            model: @model
            region: 'search'

          utils.pageTransition $('#search'), $('.pt-page.pt-page-current').first(), 'left'

        else @redirectToRoute 'login'

      @model.validateSync
        success: proceed
        error: (model, error) => @redirectToRoute 'login'

           

    imprint: (params) ->
      @title = 'Imprint'
      
      $out = $('.pt-page.pt-page-current').first()
      $in = $('#imprint')

      utils.pageTransition $in, $out, 'bottom'

