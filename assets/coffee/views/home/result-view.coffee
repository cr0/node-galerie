define (require) ->
  'use strict'

  View        = require 'views/base/view'

  Template    = require 'templates/home/result'


  class ResultView extends View
    template:   Template
    className:  'result-item'
    noWrap:     yes
