define [
  'views/base/view'
  'templates/search'
], (View, Template) ->
  'use strict'

  class SearchView extends View
    id:         'search'
    template:   Template