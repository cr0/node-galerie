define [
  'chaplin'
  'models/current-user'
], (Chaplin, CurrentUser) ->
  'use strict'

  class Application extends Chaplin.Application
    title: 'node-galerie.'

    initMediator: ->
      Chaplin.mediator.user = CurrentUser
      Chaplin.mediator.redirectUrl = null

      super