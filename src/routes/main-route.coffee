
ensureLoggedIn  = require('connect-ensure-login').ensureLoggedIn

Route           = require './'


class MainRoute extends Route

  setup: ->
    @app.all '/', ensureLoggedIn('/login'), (req, res) ->
      res.render 'home'

    @app.all '/imprint', (req, res) ->
      res.redirect '/#/imprint'


module.exports = MainRoute