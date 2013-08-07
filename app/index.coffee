
Mmh       = require 'mmh'
mongoose  = require 'mongoose'

User      = require './models/User'

dbconfig  = require '../config/mongo'


module.exports = class App extends Mmh.Application

  constructor: () ->
    super

    mongoose.connect "mongodb://#{dbconfig.host}:#{dbconfig.port}/#{dbconfig.database}"

    Mmh.Event.on '!error', (err, req, res) ->
      console.error 'Error occured', err
      res.send 500, err

    Mmh.Event.on '!error:404', (err, req, res) ->
      console.log 'Not found', err
      res.send 404, err

