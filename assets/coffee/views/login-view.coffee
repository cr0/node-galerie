define [
  'jquery'
  'views/base/view'
  'templates/login'
], ($, View, Template) ->
  'use strict'

  class LoginView extends View
    template:   Template

    initialize: () ->
      super

      @delegate 'click', 'a', @onProviderClick

    onProviderClick: (e) ->
      e.preventDefault()
      window.open $(e.target).attr('href'), "Login", "width=700,height=550,resizable=no"
      false
