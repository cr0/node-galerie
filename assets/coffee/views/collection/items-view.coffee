define [
  'views/base/collection-view'
  'views/gallery/item-view'
  'jquery.fileupload'
  'jquery.fileupload-ui'
  'lazyload'
  'mousewheel'
  'scrollto'
], (CollectionView, CollectionItemView) ->
  'use strict'

  class CollectionItemsView extends CollectionView
    className:  'wrapper'
    itemView:   CollectionItemView
    tagName:    'div'
    useCssAnimation: false

    preload:    10
    jump:       10

    initialize: ->
      @addCollectionListeners()

    renderAllItems: ->
      super

      $images = @$el.find('.item > img')
      $images.click (e) => @scrollto $(e.target)
      $images.lazyload
        threshold: 400
        container: @$el
        effect:   "fadeIn"
        skip_invisible: false

      # show the first N pictures directly
      $images.slice(0, @preload ? 10).trigger('appear')
      @scrollto $images.eq(@jump ? 10)

      @$el.mousewheel (event, delta) ->
        @scrollLeft -= delta
        event.preventDefault()

      @addUploadForm()


    scrollto: (to) =>
      @$el.scrollTo to, 
        axis: 'x'
        duration: 600
        easing: 'swing'
        event: 'scrollstop'
        offset: 
          left: -50


    addUploadForm: ->
      $file = $('<input>', type: 'file', name: 'files[]')

      $file.fileupload
        url: '/upload'
        dataType: 'json'
        autoUpload: no
        uploadTemplateId: null
        downloadTemplateId: null
        previewMaxWidth: 1600
        previewMaxHeight: 1200
        disableImageResize: no
        previewThumbnail: no

      $file.on 'fileuploadadd', (e, data) =>
        data.contexts ?= []
        for file, i in data.files
          console.log "#{file.name} added"
          data.contexts[i] = $('<div>').addClass('item').hide()
          @$el.append data.contexts[i]

      $file.on 'fileuploadprocessalways', (e, data) =>
        file = data.files[data.index]
        context = data.contexts[data.index]
        console.log "#{file.name} read (preview generated, exif extracted)"
        context.append(file.preview).append($('<div>').addClass('shadow')).fadeIn()
        context.data 'initialheight', context.children('.shadow').height()
        @scrollto context
        data.submit()

      $file.on 'fileuploadprogress', (e, data) =>
        context = data.contexts[data.index]
        initialheight = context.data 'initialheight'

        context.children('.shadow').stop().animate
          height: "#{ initialheight * ( 1 - data.loaded / data.total ) }px"

      $file.on 'fileuploadfail', (e, data) =>
        console.error "upload failed: #{data.errorThrown} - #{data.textStatus}"

      @$el.prepend $file

