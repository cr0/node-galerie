
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

  exif: 
    type:     mongoose.Schema.Types.Mixed
    select:   false

  sources:
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
  
  location:
    type: [Number]
    index: '2d'

  user: 
    _id:
      type:   mongoose.Schema.Types.ObjectId
      ref:    'User'
    name: String


GallerySchema = new mongoose.Schema

  type:          
    type:     String
    default:  'gallery'
    select:   false

  name:
    type:     String
    required: true
    unique:   true

  location:
    type: [Number]
    index: '2d'

  user: 
    _id:
      type:   mongoose.Schema.Types.ObjectId
      ref:    'User'
    name: String

  pictures: [PictureSchema]

  tags: 
    type: [String]
    index: 'text'


GallerySchema.plugin textSearch

module.exports = Gallery = mongoose.model 'Gallery', GallerySchema