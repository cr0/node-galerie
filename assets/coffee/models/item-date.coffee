define (require) ->
  'use strict'

  Chaplin = require 'chaplin'
  Moment  = require 'moment'

  Model   = require 'models/base/model'


  class ItemDate extends Model
    _.extend @prototype, Chaplin.EventBroker

    defaults:
      changed: null
      created: null

    initialize: (options) ->
      @on 'change:changed', @updateFormattedChanged, @
      @on 'change:created', @updateFormattedCreated, @

    updateFormattedChanged: (model, value, options) ->
      @set 'formatted_changed', "#{Moment(value).format('D. MMM YYYY, HH:mm:ss')} Uhr" if value? 

    updateFormattedCreated: (model, value, options) ->
      @set 'formatted_created', "#{Moment(value).format('D. MMM YYYY, HH:mm:ss')} Uhr" if value? 