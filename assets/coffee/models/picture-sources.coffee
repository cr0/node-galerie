define (require) ->
  'use strict'

  Chaplin = require 'chaplin'

  Model   = require 'models/base/model'


  class PictureSources extends Model
    _.extend @prototype, Chaplin.EventBroker

    urlRoot: '/api/picture'

    defaults:
      thumb:    null
      low:      null
      middle:   null
      standard: null
      original: null
      canvas:   null

    embed: ->
      if @get('standard')? then return @get('standard')
      else if @get('canvas')? then return @get('canvas')

      null
