define (require) ->
  'use strict'

  View        = require 'views/base/view'
  Template    = require 'templates/bucket-index'


  class BucketView extends View
    template:   Template
    id:         'bucket-index'

    initialize: ->
      @listenTo @model, 'sync', @create

    render: ->
      super
      @model.fetch()

    create: ->
      @$el.children('.loading').fadeOut()

