
passport    = require 'passport'


class Oauth
  
  @INITIALIZED: false

  constructor: ->
    if not @INITIALIZED
      passport.serializeUser (user, done) ->
        done null, user

      passport.deserializeUser (obj, done) ->
        done null, obj

      @INITIALIZED = true


module.exports = Oauth
