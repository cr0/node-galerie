define [
  'chaplin'
  'models/base/model'
], (Chaplin, Model) ->
  'use strict'

  class User extends Model
    _.extend @prototype, Chaplin.EventBroker

    urlRoot: '/user'

    defaults:
      name:       null
      username:   null
      email:      null
      loggedin:   false
