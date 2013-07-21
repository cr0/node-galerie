passport            = require 'passport'
AmazonStrategy      = require('passport-amazon').Strategy

Config              = require './config'
Oauth               = require './oauth'


class AmazonOauth extends Oauth

  constructor: ->
    super()
    passport.use @_createStrategy()


  _createStrategy: ->
    config = Config.getInstance().get()

    new AmazonStrategy
      clientID:       config.oauth.amazon.clientId,
      clientSecret:   config.oauth.amazon.secret,
      callbackURL:    config.baseurl + '/auth/amazon/callback'
      , (accessToken, refreshToken, profile, done) =>
        console.log "Got accesstoken #{accessToken} and a profile", profile
        @_findOauthUser 'amazon', profile, done


module.exports = AmazonOauth