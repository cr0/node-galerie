define [
  'models/user'
], (User) ->
  'use strict'

  class CurrentUser extends User

    # current user has fixed location on the server
    url: -> return @urlRoot + '/me'

    initialize: () ->
      @on 'change:loggedin', (model) =>
        if model.get 'loggedin' then @publishEvent 'loggedin', model
        else @publishEvent 'loggedout', model

      @on 'dispose', => @unsubscribeAllEvents()

      @subscribeEvent 'loggedin', (model) -> console.log "current user has id ##{model.id}"


  CurrentUser