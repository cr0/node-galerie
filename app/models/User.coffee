
mongoose    = require 'mongoose'
lifecycle   = require 'mongoose-lifecycle'

Lookup      = require '../models/Lookup'


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

  reputation: 
    type:     Number
    default:  13

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


UserSchema.plugin lifecycle

module.exports = User = mongoose.model 'User', UserSchema


User.on 'afterInsert', (user) ->
  lookup = new Lookup
    _id:  user._id
    type: 'user'
  lookup.save()