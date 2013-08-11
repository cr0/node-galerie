define [
  'views/base/view'
  'templates/search'
], (View, Template) ->
  'use strict'

  class SearchView extends View
    template:   Template

    regions:
      'results':  '.results'
