define [
  'jquery'
  'views/base/view'
  'templates/login'
], ($, View, Template) ->
  'use strict'

  class LoginView extends View
    template:   Template