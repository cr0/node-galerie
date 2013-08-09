
Mmh     = require('mmh')

Gallery = require '../models/Gallery'


module.exports = class GalleryController extends Mmh.RestController

  get: ( req, res, next ) -> 
    if req.params.id 
      Gallery.findById req.params.id, (err, gallery) ->
        if err then return next new Error err
        res.json gallery
    else
      Gallery.find (err, galleries) ->
        if err then return next new Error err
        res.json galleries


  post: ( req, res, next ) -> 

    # delete read only props
    delete req.body.type
    delete req.body.user

    gallery = new Gallery req.body

    gallery.user._id = req.user._id
    gallery.user.name = req.user.name

    gallery.save (err) ->
      if err then return next new Error err
      res.json gallery


  put: ( req, res, next ) -> 
    Gallery.findById req.params.id, (err, gallery) ->
      if err then return next new Error err

      gallery.name      = req.body.name
      gallery.location  = req.body.location
      gallery.tags      = req.body.tags
      
      gallery.save (err) ->
        if err then return next new Error err
        res.json gallery


  delete: ( req, res, next ) -> 
    Gallery.findById req.params.id, (err, gallery) ->
      if err then return next new Error err

      gallery.delete (err) ->
        if err then return next new Error err
        res.json code: 'ok'

