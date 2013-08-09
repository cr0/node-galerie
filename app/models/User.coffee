
mongoose  = require 'mongoose'

UserSchema = new mongoose.Schema

  type:          
    type:     String
    default:  'user'
    select:   false

  email:            
    type:     String
    required: true
    unique:   true

  name:                         
    type:     String
    required: true

  avatar:
    url:      String
    provider: String

  username:   
    type:     String
    unique:   true

  birthday:   Date

  verified:   
    type:     Boolean
    default:  true # for testing set to true
    select:   false

  provider:
    finalized:  
      type:     Boolean
      default:  false
      select:   false

    name:              
      type:     String
      required: true

    id:                
      type:     String
      required: true


module.exports = User = mongoose.model 'User', UserSchema