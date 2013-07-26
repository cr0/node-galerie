define [
  'models/user'
], (User) ->
  'use strict'

  class CurrentUser extends User

    _denied: null # cache denied

    # current user has fixed location on the server
    url: -> return @urlRoot + '/me'

    initialize: () ->
      @on 'change:loggedin', (model) =>
        if model.get 'loggedin' then @publishEvent 'loggedin', model
        else @publishEvent 'loggedout', model

      @subscribeEvent 'loggedin', (model) -> console.log "current user has id# #{model.id}"


    fetch: (options = {}) ->
        
      success = options.success
      denied = options.denied

      options.success = (model, response, options) => 
        @_denied = null
        success? model, response, options

      options.denied = (model, response, options) =>
        @_denied = response
        denied? model, response, options
        
      super options


    validateSync: (options={}) ->
      options.start?()

      if @_denied?
        console.debug 'denied models are never sync'
        options.denied? @, @_denied
        return

      if @isUnsynced()
        console.warn 'current user is unsync, syncing and proceeding'
        @fetch options

      else 
        console.info 'current user is sync'
        options.success? @

  new CurrentUser