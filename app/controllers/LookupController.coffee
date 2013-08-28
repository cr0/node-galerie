
Mmh        = require 'mmh' 
mongoose   = require 'mongoose'
_          = require 'lodash'

Lookup     = require '../models/Lookup'


module.exports = class LookupController extends Mmh.Controller

  find: ( req, res, next ) -> 

    return next new Error 'NoSuchMethod'

    Lookup.findById req.params.id, (err, doc) ->
      if err then return next new Error err


