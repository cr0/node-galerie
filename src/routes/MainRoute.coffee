
Route   = require './'

class MainRoute extends Route

  setup: ->
    @app.get '/', (req, res) ->
      res.render 'index', title: 'Express'


module.exports = MainRoute