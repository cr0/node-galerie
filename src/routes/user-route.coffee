
ensureLoggedIn  = require('connect-ensure-login').ensureLoggedIn

Route           = require './'


class UserRoute extends Route

  setup: ->
    @app.all '/user/me', ensureLoggedIn('/login'), (req, res) ->
      res.json
        id:         req.user.id
        type:       req.user.type
        name:       req.user.name
        username:   req.user.username
        email:      req.user.email
        provider:   req.user.provider
        albums:     req.user.albums
        roles:      req.user.roles
        groups:     []

module.exports = UserRoute