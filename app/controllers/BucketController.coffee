
Mmh        = require('mmh')

Bucket = require '../models/Bucket'


module.exports = class BucketController extends Mmh.RestController

  get: ( req, res, next ) -> 
    if req.params.id 
      Bucket.findById req.params.id, (err, bucket) ->
        if err then return next new Error err
        if not bucket then return next new Mmh.Error.NotFound "No bucket with id #{req.params.id}"
        res.json bucket
    else
      Bucket.find {'type': 'bucket'}, (err, buckets) ->
        if err then return next new Error err
        res.json 
          length: buckets.length
          data:   buckets


  post: ( req, res, next ) -> 

    # delete read only props
    delete req.body.type
    delete req.body.user

    bucket = new Bucket req.body

    bucket.from._id  = req.user._id
    bucket.from.name = req.user.name

    bucket.save (err) ->
      if err then return next new Error err
      res.json bucket


  put: ( req, res, next ) -> 
    Bucket.findById req.params.id, (err, bucket) ->
      if err then return next new Error err

      bucket.name      = req.body.name
      bucket.location  = req.body.location
      bucket.tags      = req.body.tags
      
      bucket.save (err) ->
        if err then return next new Error err
        res.json bucket


  delete: ( req, res, next ) -> 
    Bucket.findById req.params.id, (err, collection) ->
      if err then return next new Error err

      bucket.delete (err) ->
        if err then return next new Error err
        res.json code: 'ok'

