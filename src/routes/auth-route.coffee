
passport  = require 'passport'

Route     = require './'

class AuthRoute extends Route

  setup: ->

    # google
    @app.all '/auth/google', passport.authenticate 'google', scope: [
      'https://www.googleapis.com/auth/userinfo.profile',
      'https://www.googleapis.com/auth/userinfo.email'
    ]
    @app.all '/auth/google/callback', passport.authenticate 'google', 
      failureRedirect: '/auth/failed'
      successRedirect: '/auth/success'

    # facebook
    @app.all '/auth/facebook', passport.authenticate 'facebook', scope: ['email'], display: 'popup'
    @app.all '/auth/facebook/callback', passport.authenticate 'facebook', 
      failureRedirect: '/auth/failed'
      successRedirect: '/auth/success'

    # amazon
    @app.all '/auth/amazon', passport.authenticate 'amazon', scope: ['profile']
    @app.all '/auth/amazon/callback', passport.authenticate 'amazon', 
      failureRedirect: '/auth/failed'
      successRedirect: '/auth/success'

    # local
    @app.all '/auth/local', passport.authenticate 'local', 
      failureRedirect: '/auth/failed'
      successRedirect: '/auth/success'

    @app.all '/auth/logout', (req, res) ->
      req.logout()
      res.status 200
      if req.xhr then res.json
          code:     200
          message: 'logout successful'
      else res.redirect '/'

    # auth req
    @app.all '/auth/req', (req, res) ->
      res.status 401
      if req.xhr then res.json
        error:
          code:     401
          message: 'login required'
      else
        res.render 'error',
          error:
            code:     401
            message:  'login required'

    # auth req
    @app.all '/auth/success', (req, res) ->
      res.status 200
      if req.xhr then res.redirect '/user/me'
      else res.render 'success'

    # error
    @app.all '/auth/failed', (req, res) ->
      res.status 401
      if req.xhr then res.json 
        error:
          code:     401
          message:  'login failed'
      else res.render 'error',
        error:
          code:     401
          message:  'login failed'


module.exports = AuthRoute