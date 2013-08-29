define (require) ->
  'use strict'

  require 'jquery.resizestop'

  $               = require 'jquery'
  _               = require 'underscore'

  View            = require 'views/base/view'
  Template        = require 'templates/picture-item'


  class PictureView extends View
    template:   Template
    className:  'item'
    tagName:    'li'
    inlineScrollingPercentage: 0.1
    inlineScollingX: 160
    loadThreshold: 400

    render: ->
      super
      $img = @$el.children('.image').first()
      $img.data('loaded', no)

      highSource = $img.data('original');
      imageHeight = $img.data('height');
      imageWidth = $img.data('width');
      imageScreen = imageWidth / imageHeight

      $('ul.pictures').first().scroll =>
        imagePos = $img.offset().left

        position = (@inlineScollingX - @inlineScollingX / $('body').innerWidth() * imagePos) / -2
        if -@inlineScollingX <= position <= 0 then $img.css('background-position', "#{position}px 100%")

        if imagePos - $('body').innerWidth() - @loadThreshold < 0 and not $img.data('loaded')
          $img.data('loaded', yes)
          $preloadImg = $('<img>').attr('src', highSource)
          $preloadImg.appendTo('body').hide().on 'load', =>
            $preloadImg.remove()
            $img.fadeOut 'fast', ->
              $img.css('background-image', "url('#{highSource}')").fadeIn 'fast'


      $(window).resizestop => 
        @inlineScollingX = $('body').innerWidth() * @inlineScrollingPercentage 
        windowHeight = $('body').innerHeight()
        windowWidth  = $('body').innerWidth()
        windowScreen = windowWidth / windowHeight

        #console.log "window size has changed to w #{windowWidth} and h #{windowHeight}, resizing image w #{imageWidth} and h #{imageHeight}"

        [width, height] = if windowScreen > imageScreen then [imageWidth * windowHeight/imageHeight, windowHeight] else [windowWidth, imageHeight * windowWidth/imageWidth]

        @$el.css('width', width - @inlineScollingX)
        $img.css('width', width)

        if $img.offset().left is 0
          $img.css('background-position', "#{-@inlineScollingX / 2}px 100%")
          console.log "first image detected"
        else
          $img.css('background-position', "0px 100%")

        @$el.css('height', height)
        @$el.css('margin-top', (windowHeight - height) / 2)

      $(window).trigger 'resize'
