
ensureLoggedIn  = require('connect-ensure-login').ensureLoggedIn

Route           = require './'


class MainRoute extends Route

  setup: ->
    @app.all '/', ensureLoggedIn('/login'), (req, res) ->
      res.render 'home'


module.exports = MainRoute