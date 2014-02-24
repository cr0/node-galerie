define (require) ->
  'use strict'

  require 'jquery-autosize'

  _           = require 'underscore'

  View        = require 'views/base/view'

  Template    = require 'templates/home/search'

  class SearchView extends View
    @PLACEHOLDER: [
      'Motorradtour in den Alpen 2013', 'Was war vor einem Jahr?', 'Zeig mir ein zufälliges Album!',
      'Der letzte Geburtstag', 'Geburtstag von Reiner Roth in 2012', '!hilfe', '#geburtstag #kassler',
      'Irgendeine Feier', 'Fotos in meiner Gegend', 'Fotos aus Regensburg'
    ]

    template: Template
    bindings:
      '.user.reputation':
        observe:      'reputation'
        afterUpdate:  'highlight'


    initialize: ->
      @delegate 'focus', 'textarea.search', (e) ->
        $(e.target).autosize()


    render: ->
      super

      animate = ($textarea, placeholder) =>
        i = 0
        int = window.setInterval =>
          if i is placeholder.length
            window.clearInterval int
            @_interval = window.setTimeout =>
              $textarea = @$el.find('textarea.search')
              if $textarea.val() is ""
                animate $textarea, _.sample(SearchView.PLACEHOLDER)
            , 5000

          $textarea.attr('placeholder', placeholder[0..++i])
          $textarea.trigger('autosize.resize')
        ,  _.random(5, 250)

      animate @$el.find('textarea.search'), _.sample(SearchView.PLACEHOLDER)

