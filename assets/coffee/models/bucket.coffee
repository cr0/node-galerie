define (require) ->
  'use strict'

  Chaplin         = require 'chaplin'

  Model           = require 'models/base/model'
  Picture         = require 'models/picture'
  Pictures        = require 'models/pictures'
  Location        = require 'models/location'
  Tag             = require 'models/tag'
  Tags            = require 'models/tags'
  User            = require 'models/user'


  class Bucket extends Model
    _.extend @prototype, Chaplin.EventBroker

    urlRoot: '/api/bucket'

    defaults:
      name:       'Bucket'

    relations: [
      type:           'HasOne'
      key:            'from'
      relatedModel:   User
      includeInJSON:  ['_id', 'name']
      reverseRelation:
        includeInJSON:no
    ,
      type:           'HasMany'
      key:            'pictures'
      relatedModel:   Picture
      collectionType: Pictures
      includeInJSON:  ['_id', 'name']
      reverseRelation:
        includeInJSON:  ['_id', 'name']
    ,
      type:           'HasMany'
      key:            'tags'
      relatedModel:   Tag
      collectionType: Tags
      includeInJSON:  ['_id', 'deletable']
      reverseRelation:
        includeInJSON:no
    ,
      type:           'HasOne'
      key:            'location'
      relatedModel:   Location
      includeInJSON:  yes
      reverseRelation:
        includeInJSON:no
    ]
