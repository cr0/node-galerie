
async      = require 'async'
Mmh        = require 'mmh' 
mongoose   = require 'mongoose'
_          = require 'lodash'

Bucket     = require '../models/Bucket'
Picture    = require '../models/Picture'


module.exports = class TagController extends Mmh.Controller

  get: ( req, res, next ) -> 

    query = tags: $exists: yes
    if req.params.id? then query = _.extend _id: req.params.id, query

    o =
      map: () -> emit tag._id, 1 for tag in @tags
      reduce: (key, values) -> values.length
      query: query
      verbose: yes

    Bucket.mapReduce o, (err, tags, stats) ->
      if err then return next new Error err
      res.json 
        mapreduce:      if stats.processtime then "#{stats.processtime} ms" else 'cached' 
        length:         tags.length
        for_contentid:  if req.params.id? then req.params.id else undefined
        data:           tags
        

  exists: ( req, res, next ) ->
    if not req.params.id then return next new Mmh.BadRequest 'Missing tag_name'

    async.parallel
      buckets: (cb) -> Bucket.count {type: 'bucket', tags: $in: [_id: req.params.id]}, (err, count) -> cb err, count
      pictures: (cb) -> Picture.count {type: 'picture', tags: $in: [_id: req.params.id]}, (err, count) -> cb err, count
    , (err, results) ->
      if err then return next new Error err
      count = results.pictures + results.buckets
      if count > 0 then res.json code: 'ok', occurrence: count, tag: req.params.id
      else res.status(400).json error: 400, message: 'not allowed to create new tags', occurrence: count, tag: req.params.id


  pictures: ( req, res, next ) ->
    if not req.params.id then return next new Mmh.BadRequest 'Missing tag_name'
    
    Picture.find {type: 'picture', tags: $in: [_id: req.params.id]}, (err, pictures) ->
      if err then return next new Error err
      res.json 
        length:       pictures.length
        for_tag:      req.params.id
        data:         pictures


  buckets: ( req, res, next ) ->
    if not req.params.id then return next new Mmh.BadRequest 'Missing tag_name'
    
    Bucket.find {type: 'bucket', tags: $in: [_id: req.params.id]}, (err, buckets) ->
      if err then return next new Error err
      res.json 
        length:       buckets.length
        for_tag:      req.params.id
        data:         buckets

  autocomplete: ( req, res, next ) ->

    query = req.query.query

    o =
      map: () -> 
        for tag in @tags
          emit tag._id, 1 if not tag? or tag._id[0..query.length-1] is query
      reduce: (key, values) -> values.length
      scope:
        query: query

    Bucket.mapReduce o, (err, tags) ->
      if err then return next new Error err
      res.json 
        query: query
        suggestions: _.map tags, (tag) -> tag._id

