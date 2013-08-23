define (require) ->
  'use strict'

  Chaplin         = require 'chaplin'

  Model           = require 'models/base/model'
  User            = require 'models/user'
  #Pictures        = require 'models/pictures'
  Location        = require 'models/location'
  Tags            = require 'models/tags'


  class Collection extends Model
    _.extend @prototype, Chaplin.EventBroker

    urlRoot: '/api/collection'

    defaults:
      name:       'Collection'
      from:       null
      pictures:   null
      location:   null
      tags:       null

    initialize: (options) ->
      @set 'from', new User(options?.from)
      #@set 'pictures', new Pictures(options?.pictures)
      @set 'tags', new Tags(options?.tags)

      if options.location.length > 0 then @set 'location', new Location(options?.location)
      else @set 'location', null
