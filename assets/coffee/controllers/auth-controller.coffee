define [
  'jquery'
  'lib/utils'
  'controllers/base/controller'
  'models/current-user'
], ($, utils, Controller, CurrentUser) ->
  'use strict'

  class AuthController extends Controller

    form: () ->
      @title = 'Login'

      CurrentUser.validateSync
        success: =>
          if CurrentUser.get 'loggedin' then @redirectToRoute 'home'

        denied: (user) =>
          utils.pageTransition $('#login'), $('.pt-page.pt-page-current').first(), 'top'

          $(document).one 'loginsuccess', =>
            
            CurrentUser.fetch
              success: (user) => 
                console.log CurrentUser
                @redirectToRoute 'home'
              error: (user, error) -> console.error 'error requesting', error

        error: (user, error) -> console.error 'error requesting', error
        

