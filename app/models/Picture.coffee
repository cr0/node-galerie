
mongoose    = require 'mongoose'
textSearch  = require 'mongoose-text-search'
lifecycle   = require 'mongoose-lifecycle'

Lookup      = require '../models/Lookup'


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

  date:
    created:  Date
    uploaded: 
      type:     Date
      default:  Date.now
    changed:  Date

  sources:
    thumb:
      name:
        type:     String
        required: true
      height: Number
      width: Number
      ratio: Number

    low:
      name:
        type:     String
        required: true
      height: Number
      width: Number
      ratio: Number

    blur:   
      name:
        type:     String
        required: true
      height: Number
      width: Number
      ratio: Number

    middle:
      name:
        type:     String
        required: true
      height: Number
      width: Number
      ratio: Number

    standard:
      name:
        type:     String
        required: true
      height: Number
      width: Number
      ratio: Number

    original:   
      name:
        type:     String
        required: true
      height: Number
      width: Number
      ratio: Number

  filesize: 
    type: String
    required: true
  
  location:
    latlng:
      type:   [Number]
      index:  '2d'
    address:  String
    parts:    [String]

  from: 
    _id:
      type:   mongoose.Schema.Types.ObjectId
      ref:    'User'
    name: String

  tags: [
    _id:
      type: String
      index: 'text'
    deletable: 
      type: Boolean
      default: yes
  ]


PictureSchema.plugin textSearch
PictureSchema.plugin lifecycle

module.exports = Picture = mongoose.model 'Picture', PictureSchema, 'contents'


Picture.on 'afterInsert', (picture) ->
  lookup = new Lookup
    _id:  picture._id
    type: 'picture'
  lookup.save()


