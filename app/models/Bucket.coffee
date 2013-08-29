
mongoose    = require 'mongoose'
textSearch  = require 'mongoose-text-search'
lifecycle   = require 'mongoose-lifecycle'

Lookup      = require '../models/Lookup'


BucketSchema = new mongoose.Schema

  type:          
    type:     String
    default:  'bucket'
    select:   false

  name:
    type:     String
    required: true

  description: String

  from: 
    _id:
      type:   mongoose.Schema.Types.ObjectId
      ref:    'User'
    name: String

  pictures:
    type:   [mongoose.Schema.Types.ObjectId]
    ref:    'Picture'

  tags: [
    _id:
      type: String
      index: 'text'
  ]


BucketSchema.plugin textSearch
BucketSchema.plugin lifecycle

module.exports = Bucket = mongoose.model 'Bucket', BucketSchema, 'contents'


Bucket.on 'afterInsert', (bucket) ->
  lookup = new Lookup
    _id:  bucket._id
    type: 'bucket'
  lookup.save()