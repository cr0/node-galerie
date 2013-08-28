define (require) ->
  'use strict'

  Chaplin     = require 'chaplin'

  Model       = require 'models/base/model'


  class User extends Model
    _.extend @prototype, Chaplin.EventBroker

    urlRoot: '/api/user'

    defaults:
      name:       null
      username:   null
      email:      null
      loggedin:   false