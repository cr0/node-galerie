
ensureLoggedIn  = require('connect-ensure-login').ensureLoggedIn

Route           = require './'

Album           = require '../models/album'


class AlbumRoute extends Route

  setup: ->

    @app.get '/api/album/:id', ensureLoggedIn('/login'), (req, res) ->
      Album.findById req.params.id, (err, album) ->
        if not err
          res.statusCode = 201
          res.json 
            code:   'ok'
            type:   'album'
            data:   album
        else
          res.statusCode = 500
          res.json 
            code:   'error'
            type:   'album'
            error:  err

    @app.put '/api/album/:id', ensureLoggedIn('/login'), (req, res) ->
      Album.findByIdAndUpdate req.params.id, {"$set":req.body}, (err, album) ->
        if not err
          res.statusCode = 201
          res.json 
            code:   'ok'
            type:   'album'
            data:   album
        else
          res.statusCode = 500
          res.json 
            code:   'error'
            type:   'album'
            error:  err
    
    @app.delete '/api/album/:id', ensureLoggedIn('/login'), (req, res) ->
      Album.findByIdAndRemove req.params.id, (err) ->
      if not err
        res.statusCode = 201
        res.json 
          code:   'ok'
          type:   'album'
          data:   []
      else
          res.statusCode = 500
          res.json 
            code:   'error'
            type:   'album'
            error:  err

    @app.get '/api/album', ensureLoggedIn('/login'), (req, res) ->
      Album.find
        type: 'album'
      , (err, albums) ->
        res.json
          code:   'ok'
          type:     'album'
          count:    albums.length
          data:     albums

    @app.post '/api/album', ensureLoggedIn('/login'), (req, res) ->
      album = new Album req.body
      album.save (err, album) ->
        if not err
          res.statusCode = 201
          res.json 
            code:   'ok'
            type:   'album'
            data:   album
        else
          res.statusCode = 500
          res.json 
            code:   'error'
            type:   'album'
            error:  err
      

module.exports = AlbumRoute