define (require) ->
  'use strict'

  Chaplin         = require 'chaplin'

  Model           = require 'models/base/model'
  #Collections     = require 'models/collections'
  PictureSources  = require 'models/picture-sources'
  Location        = require 'models/location'
  Tags            = require 'models/tags'
  User            = require 'models/user'


  class Picture extends Model
    _.extend @prototype, Chaplin.EventBroker

    urlRoot: '/api/picture'

    defaults:
      name:       'Picture'
      from:       null
      sources:    null
      location:   null
      collections:null
      tags:       null

    initialize: (options) ->
      @set 'sources', new PictureSources(options?.sources)
      @set 'from', new User(options?.from)
      #@set 'collections', new Collections(options?.collections)
      @set 'tags', new Tags(options?.tags)

      if options.location.length > 0 then @set 'location', new Location(options?.location)
      else @set 'location', null
