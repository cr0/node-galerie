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
    inlinescrolling: 160

    render: ->
      super
      $img = @$el.children('.image').first()

      highSource = $img.data('original');
      imageHeight = $img.data('height');
      imageWidth = $img.data('width');
      imageScreen = imageWidth / imageHeight


      $('ul.pictures').first().scroll =>
        imagePos = $img.offset().left

        position = (@inlinescrolling - @inlinescrolling / $('body').innerWidth() * imagePos) / -2
        if -@inlinescrolling <= position <= 0 then $img.css('background-position', "#{position}px 100%")

      $(window).resizestop => 
        windowHeight = $('body').innerHeight()
        windowWidth  = $('body').innerWidth()
        windowScreen = windowWidth / windowHeight

        #console.log "window size has changed to w #{windowWidth} and h #{windowHeight}, resizing image w #{imageWidth} and h #{imageHeight}"

        [width, height] = if windowScreen > imageScreen then [imageWidth * windowHeight/imageHeight, windowHeight] else [windowWidth, imageHeight * windowWidth/imageWidth]

        @$el.css('width', width - @inlinescrolling)
        $img.css('width', width)

        if $img.offset().left is 0
          $img.css('background-position', "#{-@inlinescrolling / 2}px 100%")
          console.log "first image detected"
        else
          $img.css('background-position', "0px 100%")

        @$el.css('height', height)
        @$el.css('margin-top', (windowHeight - height) / 2)

      $(window).trigger 'resize'

      $preloadImg = $('<img>').attr('src', highSource)
      $preloadImg.appendTo('body').hide().on 'load', =>
        $preloadImg.remove()
        $img.css('background-image', "url('#{highSource}')")