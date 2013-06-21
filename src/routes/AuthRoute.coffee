
passport  = require 'passport'

Route     = require './'

class AuthRoute extends Route

  setup: ->

    # google
    @app.all '/auth/google', passport.authenticate 'google', scope: [
      'https://www.googleapis.com/auth/userinfo.profile',
      'https://www.googleapis.com/auth/userinfo.email'
    ]
    @app.all '/auth/google/callback', passport.authenticate('google', failureRedirect: '/auth/failed'), (req, res) ->
      res.redirect '/account'

    # facebook
    @app.all '/auth/facebook', passport.authenticate 'facebook', scope: ['email']
    @app.all '/auth/facebook/callback', passport.authenticate('facebook', failureRedirect: '/auth/failed'), (req, res) ->
      res.redirect '/account'

    # amazon
    @app.all '/auth/amazon', passport.authenticate 'amazon', scope: ['profile']
    @app.all '/auth/amazon/callback', passport.authenticate('amazon', failureRedirect: '/auth/failed'), (req, res) ->
      res.redirect '/account'

    # error
    @app.all '/auth/failed', (req, res) ->
      if req.xhr
        res.json 
          error:
            code:     401
            message:  "login failed"
        , 401
      else
        res.status 401
        res.render 'error',
          error:
            code:     401
            message:  "login failed"


module.exports = AuthRoute