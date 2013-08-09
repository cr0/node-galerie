
Mmh       = require 'mmh'
gravatar  = require 'gravatar'
_         = require 'lodash'

User      = require '../models/User'

module.exports = class AuthController extends Mmh.Controller

  logout:  (req, res) ->
    req.logout()
    res.status 200
    if req.xhr then res.json
        code:     200
        message: 'logout successful'
    else res.redirect '/'


  failed: ( req, res ) ->
    res.status 400
    if req.xhr then res.json
      error: 400
      message: 'auth failed'
    else res.render 'failed'


  validate: ( req, res, next ) ->
    res.status 200
    auth = req.session.auth
    req.session.auth = null

    # find user id by provider
    User.findOne
      'provider.name':  auth.provider.name
      'provider.id':    auth.provider.id
    , "+provider.finalized +verified", (err, user) ->
      if err then next err
      else
        # known user
        if user
          req.logIn user, (err) ->
            if err then return next err
            else if not user.provider.finalized then res.render 'finialize', user.toJSON()
            else if not user.verified then return next new Error 'User Account is not verified'
            else 
              if req.xhr then res.redirect (if req.session.returnto? then req.session.returnto else '/user/me')
              else res.render 'success'
        # new user
        else
          # validate if user with same email exists
          User.count email: auth.info.emails[0]?.value, (err, count) ->
            if err then return next err
            if count > 0 then return next new Error "User with this email (#{auth.info.emails[0]?.value}) " + 
              "already registered with another oauth provider"

            # ok create new user
            avatarProvider = 'gravatar'
            avatarUrl = gravatar.url auth.info.emails[0]?.value, s: '150', r: 'x', d: 'identicon'

            switch auth.provider.name
              when 'facebook' 
                avatarProvider = 'facebook'
                avatarUrl = "https://graph.facebook.com/#{auth.provider.id}/picture?width=150&height=150"
              when 'google'
                if auth.info.picture
                  avatarProvider = 'google'
                  avatarUrl = "https://plus.google.com/s2/photos/profile/#{auth.provider.id}?sz=150"

            user = new User
              name:             auth.info.displayName
              email:            auth.info.emails[0]?.value
              username:         auth.info.username
              birthday:         auth.info.birthday
              'avatar.url':     avatarUrl
              'avatar.provider':avatarProvider
              'provider.name':  auth.provider.name
              'provider.id':    auth.provider.id

            user.save (err) ->
              if err then return next err
              else
                res.render 'finialize', user.toJSON()



  finalize: ( req, res, next ) ->
    id        = req.body._id
    username  = req.body.username
    birthday  = req.body.birthday

    User.findById id, (err, user) =>
      if err then return next err
      else
        if not user then return next new Error "Unable to finalize user: User not found (id #{id})"

        if not username then usernameM = true
        if not birthday then birthdayM = true

        if usernameM or birthdayM then return res.render 'finialize', _.extend user.toJSON(), 
          missing_username: usernameM || false
          missing_birthday: birthdayM || false

        user.username = username
        user.birthday = birthday
        user.provider.finalized = true

        user.save (err) ->
          if err then return next err
          else
            req.logIn user, (err) ->
              if err then return next err
              else 
                if req.xhr then res.redirect (if req.session.returnto? then req.session.returnto else '/user/me')
                else res.render 'success'



    
    


