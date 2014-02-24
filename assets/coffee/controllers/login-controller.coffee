define [
  'jquery'
  'chaplin'
  'lib/utils'
  'controllers/base/controller'
  'models/current-user'
], ($, Chaplin, utils, Controller, CurrentUser) ->
  'use strict'

  class LoginController extends Controller

    login: (params) ->
      @adjustTitle 'Login'

      (fetch = (again) =>
        Chaplin.mediator.user.fetch
          success: (model) =>
            if not Chaplin.mediator.redirectUrl then @redirectTo 'hello_home'
            else @redirectTo url: Chaplin.mediator.redirectUrl

          error: (model, error) -> console.error 'error requesting', error
          denied: ->
            if not again then utils.pageTransition $('#login'), 'top'
            $(document).one 'loginsuccess', -> fetch true
      )()

    logout: (params) ->
      user = Chaplin.mediator.user

      if user?.get 'loggedin'
        try
          user.logout()
        catch e
          @publishEvent '!error', e

      else
        @redirectTo 'hello_home'



