define [
  'views/base/view'
  'templates/imprint'
], (View, Template) ->
  'use strict'

  class ImprintView extends View
    id:       'imprint'
    template: Template