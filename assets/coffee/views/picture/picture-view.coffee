define (require) ->
  'use strict'

  require 'jquery.resizestop'
  require 'jquery.autocomplete'

  $               = require 'jquery'
  _               = require 'underscore'
  gmaps           = require 'gmaps'

  View            = require 'views/base/view'
  Tag             = require 'models/tag'
  Buckets         = require 'models/buckets'
  Template        = require 'templates/picture-item'


  class PictureView extends View
    template:   Template
    className:  'item'
    tagName:    'li'

    inlineScrollingPercentage: 0.05
    inlineScollingX: 160
    loadThreshold: 400

    tagselector: 'input.tagselector'

    events:
      'click .icon.calendar': 'toggleIconCalendar'
      'click .icon.location':      'toggleIconLocation'
      'click .icon.tag':      'toggleIconTag'


    initialize: () ->
      @listenTo @model, 'change', @render

      @buckets = new Buckets url: "/api/picture/#{@model.id}/buckets"
      @buckets.syncing =>
        @$el.find('div.icon.bucket span.badge').addClass(' entypo loading').text()
      @buckets.synced =>
        @$el.find('div.icon.bucket span.badge').removeClass('entypo loading').text(@buckets.length)
      @buckets.unsynced =>
        @$el.find('div.icon.bucket span.badge').removeClass('entypo warning').text()


    getTemplateData: () ->
      _.extend super, num_tags: @model.get('tags').length, num_buckets: 0


    toggleIconCalendar: (e, hide = no) ->
      $content = @$el.find('li.date .content')
      shown = if hide then true else $content.data('__shown')
      shown ?= false

      @disableOthers() if not hide
      if !shown then $content.addClass('active') else $content.removeClass('active')
      $content.data('__shown', !shown)


    toggleIconLocation: (e, hide = no) ->
      $content = @$el.find('li.location .content')
      shown = if hide then true else $content.data('__shown')
      shown ?= false

      @disableOthers() if not hide
      if !shown then $content.addClass('active') else $content.removeClass('active')
      $content.data('__shown', !shown)


    toggleIconTag: (e, hide = no) ->
      $content = @$el.find('li.tags .content')
      shown = if hide then true else $content.data('__shown')
      shown ?= false

      @disableOthers() if not hide
      if !shown then $content.addClass('active') else $content.removeClass('active')
      $content.data('__shown', !shown)


    disableOthers: () ->
      @toggleIconCalendar(null, true)
      @toggleIconLocation(null, true)
      @toggleIconTag(null, true)


    render: ->
      super

      @buckets.fetch()
      $img = @$el.children('.image').first()

      @$el.find(@tagselector).autocomplete
        serviceUrl: '/ajax/tag/autocomplete'
        minChars: 2

              # when 'location'
              #   lat = @model.get('location').get('lat') || 48.144
              #   long = @model.get('location').get('long') || 11.558

              #   map = new gmaps.Map @$el.find('div.gmap').first()[0],
              #     zoom: 7
              #     mapTypeId: gmaps.MapTypeId.HYBRID
              #     center: new gmaps.LatLng(lat, long)

              #   if @model.get('location').get('lat') and @model.get('location').get('long')
              #     marker = new gmaps.Marker
              #       position: new gmaps.LatLng(lat, long)
              #       map: map,
              #       title: @model.get('location').get('address')

      # create tagits
      # @$el.find(@taglist).tagit
      #   fieldName: 'tags'
      #   autocomplete:
      #     minLength: 2
      #     delay: 0
      #     source: '/ajax/tag/autocomplete'
      #   allowSpaces: yes
      #   singleField: yes
      #   removeConfirmation: yes
      #   placeholderText: 'Tags helfen beim organisieren'
      #   beforeTagAdded: (event, ui) =>
      #     if not ui.duringInitialization
      #       tag = Tag.findOrCreate _id: ui.tagLabel
      #       @model.get('tags').add tag
      #       @model.save()
      #   afterTagRemoved: (event, ui) =>
      #     tagToRemove = @model.get('tags').get ui.tagLabel
      #     @model.get('tags').remove tagToRemove
      #     @model.save()

      # add image handler (resize, inlinescrolling)
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
