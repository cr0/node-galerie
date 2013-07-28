define [
  'views/base/view'
  'templates/search-item'
], (View, Template) ->
  'use strict'

  class SearchItemView extends View
    template:   Template
    className:  'search-item'
    tagName:    'li'
