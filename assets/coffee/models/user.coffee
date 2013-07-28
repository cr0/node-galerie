define [
  'chaplin'
  'models/base/model'
], (Chaplin, Model) ->
  'use strict'

  class User extends Model
    _.extend @prototype, Chaplin.EventBroker

    urlRoot: '/user'

    defaults:
      type:       'user'
      name:       'Guest'
      username:   'Guest'
      email:      null
      loggedin:   false