
Mmh        = require('mmh')

Collection = require '../models/Collection'


module.exports = class CollectionController extends Mmh.RestController

  get: ( req, res, next ) -> 
    if req.params.id 
      Collection.findById req.params.id, (err, collection) ->
        if err then return next new Error err
        if not collection then return next new Mmh.Error.NotFound "No collection with id #{req.params.id}"
        res.json collection
    else
      Collection.find (err, collections) ->
        if err then return next new Error err
        res.json collections


  post: ( req, res, next ) -> 

    # delete read only props
    delete req.body.type
    delete req.body.user

    collection = new Collection req.body

    collection.user._id  = req.user._id
    collection.user.name = req.user.name

    collection.save (err) ->
      if err then return next new Error err
      res.json collection


  put: ( req, res, next ) -> 
    Collection.findById req.params.id, (err, collection) ->
      if err then return next new Error err

      collection.name      = req.body.name
      collection.location  = req.body.location
      collection.tags      = req.body.tags
      
      collection.save (err) ->
        if err then return next new Error err
        res.json collection


  delete: ( req, res, next ) -> 
    Collection.findById req.params.id, (err, collection) ->
      if err then return next new Error err

      collection.delete (err) ->
        if err then return next new Error err
        res.json code: 'ok'

