
Mmh  = require 'mmh'

User = require './models/User'


module.exports = class App extends Mmh.Application

  constructor: () ->
    super

    Mmh.Event.on '!error', (err, req, res) ->
      console.error 'Error occured', err
      res.send 500, err

    Mmh.Event.on '!error:404', (err, req, res) ->
      res.send 404, err

