
mongoose      = require 'mongoose'
basicAuth     = require 'basic-auth-mongoose'
extend        = require 'mongoose-schema-extend'


BaseUserSchema = new mongoose.Schema

  type:          
    type:     String
    default:  'user'

  email:            
    type:     String
    required: true

  name:                         
    type:     String
    required: true

  username:   String

  albums:   [ 
    id:
      type:   mongoose.Schema.Types.ObjectId
      ref:    'Gallery'

    name:           
      type:     String
      required: true
  ]

  roles:    [ 
    name:
      type:   String
  ]

, collection : 'gallery'


LocalUserSchema = BaseUserSchema.extend

  'provider.name':              
    type:     String
    default:  'local'

  verified:   Boolean
    

OauthUserSchema = BaseUserSchema.extend

  'provider.name':              
    type:     String
    required: true

  'provider.id':                
    type:     String
    required: true


# add 'username' and salted 'password'
LocalUserSchema.plugin basicAuth

BaseUser  = mongoose.model 'BaseUser', BaseUserSchema
LocalUser = mongoose.model 'LocalUser', LocalUserSchema
OauthUser = mongoose.model 'OauthUser', OauthUserSchema

module.exports = {LocalUser, OauthUser, BaseUser}