
mongoose    = require 'mongoose'
textSearch  = require 'mongoose-text-search'


CollectionSchema = new mongoose.Schema

  type:          
    type:     String
    default:  'collection'
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
    name: 
      type: String
      index: 'text'
  ]


CollectionSchema.plugin textSearch

module.exports = Collection = mongoose.model 'Collection', CollectionSchema, 'contents'