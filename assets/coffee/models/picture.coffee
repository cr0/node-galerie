define (require) ->
  'use strict'

  Chaplin         = require 'chaplin'

  Model           = require 'models/base/model'
  PictureSource   = require 'models/picture-source'
  Location        = require 'models/location'
  Tag             = require 'models/tag'
  Tags            = require 'models/tags'
  User            = require 'models/user'


  class Picture extends Model
    _.extend @prototype, Chaplin.EventBroker

    urlRoot: '/api/picture'

    defaults:
      name:       'Picture'

    relations: [
      type:           'HasOne'
      key:            'from'
      relatedModel:   User
      includeInJSON:  ['_id', 'name']
      reverseRelation:
        includeInJSON:no
    ,
      type:           'HasMany'
      key:            'tags'
      relatedModel:   Tag
      collectionType: Tags
      includeInJSON:  'name'
      parse:          yes
      reverseRelation:
        includeInJSON:no
    ,
      type:           'HasOne'
      key:            'location'
      relatedModel:   Location
      includeInJSON:  yes
      reverseRelation:
        includeInJSON:no
    ,
      type:           'HasOne'
      key:            'sources'
      relatedModel:   PictureSource
      includeInJSON:  yes
      reverseRelation:
        includeInJSON:no
        type:         'HasOne'
    ]
