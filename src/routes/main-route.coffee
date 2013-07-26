
Route           = require './'


class MainRoute extends Route

  setup: ->
    @app.all '/', (req, res) ->
      res.render 'home'


module.exports = MainRoute