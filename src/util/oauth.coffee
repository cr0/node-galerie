
passport      = require 'passport'

{LocalUser, OauthUser, BaseUser} = require '../models/user'
Role          = require '../models/role'


class Oauth
  
  @INITIALIZED: false

  constructor: ->
    if not @INITIALIZED
      passport.serializeUser (user, done) ->
        done null, user.id

      passport.deserializeUser (id, done) ->
        LocalUser.findById id, (err, user) ->
          return done err, user if not err
          OauthUser .findById id, (err, user) ->
            return done err, user if not err

      @INITIALIZED = true


  _findOauthUser: (providerName, profile, done) ->
    OauthUser.findOne
      'provider.name':   providerName
      'provider.id':     profile.id
    , (err, user) ->
      if user
        console.log "got user from db #{user}"
        done null, user
      else
        BaseUser.count
          email: profile.emails[0]?.value
        , (err, count) ->
          if count > 0
            done null, false, { message: 'Email address already in use' }
          else 
            user = new OauthUser
              name:             profile.displayName
              username:         profile.username
              email:            profile.emails[0]?.value
              'provider.id':    profile.id
              'provider.name':  providerName
              roles:            [
                  name:         'user'
                , 
                  name:         'oauth'
              ]
            user.save (err) ->
              console.log "stored user in db #{user}"
              done null, user if not err


module.exports = Oauth