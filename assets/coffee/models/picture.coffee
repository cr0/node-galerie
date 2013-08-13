define (require) ->
  'use strict'

  Chaplin = require 'chaplin'

  Model           = require 'models/base/model'
  PictureSources  = require 'models/picture-sources'


  class Picture extends Model
    _.extend @prototype, Chaplin.EventBroker

    urlRoot: '/picture'

    defaults:
      name:       'Picture'
      sources:    null

    initialize: (options) ->
      @set 'sources', new PictureSources(options?.sources)
