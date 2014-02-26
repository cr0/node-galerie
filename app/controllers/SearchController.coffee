
async      = require 'async'
Mmh        = require 'mmh'
mongoose   = require 'mongoose'
_          = require 'lodash'

Bucket     = require '../models/Bucket'


module.exports = class SearchController extends Mmh.Controller

  # go tries to dispatch the current request and always outputs collections
  get: ( req, res, next ) ->

    query = req.query.q
    res.status(503).send('Service Temporarily Unavailable')





