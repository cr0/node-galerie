define [
  'chaplin'
  'models/base/model'
], (Chaplin, Model) ->
  'use strict'

  class Picture extends Model
    _.extend @prototype, Chaplin.EventBroker

    urlRoot: '/picture'

    defaults:
      type:       'picture'
      name:       'Picture'
      url:        'http://localhost:3000/img/background.jpg'
