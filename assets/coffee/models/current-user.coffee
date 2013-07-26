define [
  'models/user'
], (User) ->
  'use strict'

  class CurrentUser extends User

    defaults:
      id:         'me'

    initialize: () ->
      @on 'change:loggedin', (model) =>
        if model.get 'loggedin' then @publishEvent 'loggedin', model
        else @publishEvent 'loggedout', model


    validateSync: (options={}) ->
      options?.start?()

      if @isUnsynced()
        console.warn 'current user is unsync, syncing and proceeding'

        @fetch
          success: (model, resp) -> options?.success? model, resp
          error: (model, error) => options?.error? model, error

      else 
        console.info 'current user is sync'
        options?.success? @
  
  new CurrentUser