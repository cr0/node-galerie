passport            = require 'passport'
GoogleStrategy      = require('passport-google-oauth').OAuth2Strategy

Config              = require './config'
Oauth               = require './oauth'


class GoogleOauth extends Oauth

  constructor: ->
    super()
    passport.use @_createStrategy()


  _createStrategy: ->
    config = Config.getInstance().get()

    new GoogleStrategy
      clientID:       config.oauth.google.clientId,
      clientSecret:   config.oauth.google.secret,
      callbackURL:    config.baseurl + '/auth/google/callback'
      , (accessToken, refreshToken, profile, done) =>
        console.log "Got accesstoken #{accessToken} and a profile", profile
        @_findOauthUser 'google', profile, done


module.exports = GoogleOauth