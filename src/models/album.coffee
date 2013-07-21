
mongoose      = require 'mongoose'


schema        = new mongoose.Schema

  type:          
    type:     String
    default:  'album'

  name:                         
    type:     String
    required: true
    unique:   true

  description:                         
    type:     String
    unique:   true

  tags:
    type:     String

  'location.lat': Number
  'location.lng': Number

  from: [ 
    id:
      type:     mongoose.Schema.Types.ObjectId
      ref:      'BaseUser'
      required: true

    name:
      type:     String
      required: true
  ]

  visible: [
      type:     mongoose.Schema.Types.ObjectId
  ]


, collection : 'gallery'

module.exports = mongoose.model 'Album', schema