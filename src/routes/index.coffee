
ensureLoggedIn = require('connect-ensure-login').ensureLoggedIn


class Route
  constructor: (@app) ->

  setup: ->
    throw Error 'not implemented'


module.exports = Route