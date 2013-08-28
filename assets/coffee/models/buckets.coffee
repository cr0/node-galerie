define (require) ->
  'use strict'

  Chaplin       = require 'chaplin'

  Collection    = require 'models/base/collection'
  Bucket        = require 'models/bucket'


  class Buckets extends Collection
    _.extend @prototype, Chaplin.EventBroker

    url:    '/api/bucket'
    model:  Bucket
