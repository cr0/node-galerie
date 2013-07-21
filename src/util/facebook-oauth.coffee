passport            = require 'passport'
FacebookStrategy    = require('passport-facebook').Strategy

Config              = require './config'
Oauth               = require './oauth'


class FacebookOauth extends Oauth

  constructor: ->
    super()
    passport.use @_createStrategy()


  _createStrategy: ->
    config = Config.getInstance().get()

    new FacebookStrategy
      clientID:       config.oauth.facebook.clientId,
      clientSecret:   config.oauth.facebook.secret,
      callbackURL:    config.baseurl + '/auth/facebook/callback'
      , (accessToken, refreshToken, profile, done) =>
        console.log "Got accesstoken #{accessToken} and a profile", profile
        @_findOauthUser 'facebook', profile, done


module.exports = FacebookOauth