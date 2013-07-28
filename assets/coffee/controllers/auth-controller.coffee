define [
  'jquery'
  'lib/utils'
  'controllers/base/controller'
  'models/current-user'
], ($, utils, Controller, CurrentUser) ->
  'use strict'

  class AuthController extends Controller

    form: (params) ->
      @title = 'Login'

      @model = new CurrentUser

      (fetch = (again) =>
        @model.fetch
          success: => @redirectToRoute 'home'
          error: (model, error) -> console.error 'error requesting', error
          denied: ->
            if not again then utils.pageTransition $('#login'), 'top'
            $(document).one 'loginsuccess', -> fetch true
      )()