define (require) ->
  'use strict'

  Chaplin        = require 'chaplin'

  CollectionView = require 'views/base/collection-view'
  SearchView     = require 'views/home/search-view'
  ResultView     = require 'views/home/result-view'

  Template       = require 'templates/home/index'


  class HomeView extends CollectionView
    @MIN_WIDTH: 250
    @MAX_WIDTH: 300

    template:   Template
    className:  'results'
    itemView:   ResultView

    regions:
      'search':   '.search'


    render: ->
      super

      @$el.prepend(@$el.find('.search'))

      searchView = new SearchView region: 'search', model: Chaplin.mediator.user
      @subview 'search', searchView

      ## resize to fit window width
      resizeTiles = =>
        console.time('resizeTiles')

        innerWidth = $(window).innerWidth()
        elPP = 3
        desiredWidth = -1
        console.debug "Resizing tiles for innerWidth of #{innerWidth}px..."

        console.time('findsize')

        while true
          potentialWidth = innerWidth / elPP
          console.debug potentialWidth, elPP, HomeView.MAX_WIDTH

          if HomeView.MIN_WIDTH < potentialWidth < HomeView.MAX_WIDTH
            desiredWidth = potentialWidth
            console.debug "Found desiredWidth (#{desiredWidth}px) with #{elPP} elements per line"
            break
          else if HomeView.MIN_WIDTH > potentialWidth then --elPP
          else if HomeView.MAX_WIDTH < potentialWidth then ++elPP
          else if elPP < 2 then throw "WINDOW_TOO_SMALL_ERROR"
          else throw "UNEXPECTED_ERROR"

        console.timeEnd('findsize')

        @$el.children().each (idx, el) =>
          $el = $(el)
          if $el.hasClass('search') then $el.css('width', "#{desiredWidth*2}px")
          else $el.css('width', "#{desiredWidth}px")

        console.timeEnd('resizeTiles')

      $(window).resize resizeTiles
      $(window).resize()


