
mongoose    = require 'mongoose'
textSearch  = require 'mongoose-text-search'


PictureSchema = new mongoose.Schema
    
  type:          
    type:     String
    default:  'picture'
    select:   false

  name:
    type:     String
    required: true

  mime:
    type: String
    required: true

  exif: 
    type:     mongoose.Schema.Types.Mixed
    select:   false

  sources:
    thumb:
      type:     String
      required: true

    low:
      type:     String
      required: true

    middle:
      type:     String
      required: true

    standard:
      type:     String
      required: true

    original:   
      type:     String
      required: true

  filesize: 
    type: String
    required: true
  
  location:
    type: [Number]
    index: '2d'

  user: 
    _id:
      type:   mongoose.Schema.Types.ObjectId
      ref:    'User'
    name: String

  tags: 
    type: [String]
    index: 'text'

  collections:
    type:   [mongoose.Schema.Types.ObjectId]
    ref:    'Collection'


PictureSchema.plugin textSearch

module.exports = Picture = mongoose.model 'Picture', PictureSchema, 'content'