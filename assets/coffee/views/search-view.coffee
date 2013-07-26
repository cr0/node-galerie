define [
  'jquery'
  'views/base/view'
  'templates/search'
], ($, View, Template) ->
  'use strict'

  class SearchView extends View
    template:   Template
