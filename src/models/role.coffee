
mongoose      = require 'mongoose'


schema = new mongoose.Schema

  type:          
    type:     String
    default:  'role'

  name:                         
    type:     String
    required: true
    unique:   true


, collection : 'gallery'

module.exports = mongoose.model 'Role', schema