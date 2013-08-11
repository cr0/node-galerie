define [
  'underscore'
  'views/base/view'
  'templates/search-item'
], (_, View, Template) ->
  'use strict'

  class SearchItemView extends View
    template:   Template
    className:  'search-item'
    tagName:    'li'

