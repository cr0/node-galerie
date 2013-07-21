define [
  'views/base/view'
  'templates/home'
], (View, Template) ->
  'use strict'

  class HomeView extends View
    id:         'home'
    template:   Template