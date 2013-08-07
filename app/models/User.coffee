
mongoose  = require 'mongoose'

UserSchema = new mongoose.Schema

  type:          
    type:     String
    default:  'user'

  email:            
    type:     String
    required: true

  name:                         
    type:     String
    required: true

  avatar:
    type:     String

  username:   String

  birthday:   Date

  verified:   
    type:     Boolean
    default:  false

  'provider.name':              
    type:     String
    required: true

  'provider.id':                
    type:     String
    required: true


module.exports = User = mongoose.model 'User', UserSchema