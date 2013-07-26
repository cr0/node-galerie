
passport  = require 'passport'

Route     = require './'

class AuthRoute extends Route

  setup: ->

    # login
#    @app.all '/login', (req, res) ->
#      res.render '/', 
#        needslogin: true

    # google
    @app.all '/auth/google', passport.authenticate 'google', scope: [
      'https://www.googleapis.com/auth/userinfo.profile',
      'https://www.googleapis.com/auth/userinfo.email'
    ]
    @app.all '/auth/google/callback', passport.authenticate 'google', 
      failureRedirect: '/auth/failed'
      successReturnToOrRedirect: '/account'

    # facebook
    @app.all '/auth/facebook', passport.authenticate 'facebook', scope: ['email']
    @app.all '/auth/facebook/callback', passport.authenticate 'facebook', 
      failureRedirect: '/auth/failed'
      successReturnToOrRedirect: '/account'

    # amazon
    @app.all '/auth/amazon', passport.authenticate 'amazon', scope: ['profile']
    @app.all '/auth/amazon/callback', passport.authenticate 'amazon', 
      failureRedirect: '/auth/failed'
      successReturnToOrRedirect: '/account'

    # local
    @app.all '/auth/local', passport.authenticate 'local', 
      failureRedirect: '/auth/failed'
      successReturnToOrRedirect: '/account'

    @app.all '/logout', (req, res) ->
      req.logout()
      res.format
        'json': () -> 
          res.json
            code: 'ok'
            num:  200
        'default': () ->
            res.send 200

    # error
    @app.all '/auth/failed', (req, res) ->
      if req.xhr
        res.json 
          error:
            code:     401
            message:  'login failed'
        , 401
      else
        res.status 401
        res.render 'error',
          error:
            code:     401
            message:  'login failed'


module.exports = AuthRoute