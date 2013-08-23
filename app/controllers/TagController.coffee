
Mmh        = require 'mmh' 
mongoose   = require 'mongoose'
_          = require 'lodash'

Collection = require '../models/Collection'


module.exports = class TagController extends Mmh.Controller

  get: ( req, res, next ) -> 
    o =
      map: () -> emit tag, 1 for tag in @tags
      reduce: (key, values) -> values.length
      query: tags: $exists: yes
      verbose: yes

    Collection.mapReduce o, (err, tags, stats) ->
      if err then return next new Error err
      response = 
      res.json 
        mapreduce:  if stats.processtime then "#{stats.processtime} ms" else 'cached' 
        length:     tags.length
        data:       _.map tags, (tag) -> name: tag._id, occurrence: tag.value
        

  exists: ( req, res, next ) ->
    Collection.count tags: $in: [req.query.tag], (err, count) ->
      if err then return new Error err
      if count > 0 then res.json code: 'ok', occurrence: count, tag: req.query.tag
      else res.status(400).json error: 400, message: 'not allowed to create new tags', occurrence: count, tag: req.query.tag


