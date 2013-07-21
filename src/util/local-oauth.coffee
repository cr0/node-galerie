passport            = require 'passport'
LocalStrategy       = require('passport-local').Strategy

Config              = require './config'
Oauth               = require './oauth'

LocalUser           = require '../models/user'


class FacebookOauth extends Oauth

  constructor: ->
    super()
    passport.use @_createStrategy()


  _createStrategy: ->
    config = Config.getInstance().get()
    
    new LocalStrategy (username, password, done) ->
      LocalUser.findOne
        nickname:   username
        , (err, user) ->
          if err
            console.log "unknown user"
            done error
          if not user?.authenticate password
            done null, false
            
          done null, user


module.exports = FacebookOauth