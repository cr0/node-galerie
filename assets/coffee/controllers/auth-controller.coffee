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
        success: (model) =>
          console.log model
          if model.get 'loggedin' then @redirectToRoute 'home'

        error: (model, error) =>
          utils.pageTransition $('#login'), $('.pt-page.pt-page-current').first(), 'top'
          
          $(document).one 'loginsuccess', =>

            model.fetch
              success: (user) => @redirectToRoute 'home'
              error: (user, error) -> console.error('error while logging in')
        

