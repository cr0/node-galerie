define [
  'lib/utils'
  'controllers/base/controller'
  'models/current-user'
  'views/user/setting-view'
], (utils, Controller, CurrentUser, SettingView) ->
  'use strict'

  class UserController extends Controller

    setting: (params) ->
      @title = 'Hello'

      @currentuser = new CurrentUser

      @currentuser.fetch
        success: (model) =>
          @search = new SettingView
            model:  model
            region: 'setting'

          utils.pageTransition $('#setting'), 'bottom'

        denied: => 
          @currentuser.dispose()
          @redirectToRoute 'login'
          
        error: (model, error) -> console.error 'error requesting', error