define (require) ->
  'use strict'

  require 'jquery.fileupload'
  require 'jquery.fileupload-ui'
  require 'jquery.resizestop'
  require 'jquery.mousewheel'
  require 'jquery.scrollto'

  $               = require 'jquery'
  _               = require 'underscore'
  utils           = require 'lib/utils'

  Picture         = require 'models/Picture'
  View            = require 'views/base/view'
  Template        = require 'templates/picture-upload'


  class PictureUploadView extends View
    template: Template

    render: ->
      super

      $hint = @$el.children 'div.drop'
      $list = @$el.children 'div.list'

      minImageHeight = 250
      maxImageHeight = 500
      currentRows = 0
      maxRows = 3

      createRow = (idx) ->
        $list.append($('<div>').addClass("row row-#{idx}"))
        $list.append($('<br>'))


      resizeItem = ($item) ->
        rowHeight = $list.height() / currentRows
        rowHeight = if rowHeight > maxImageHeight then maxImageHeight else rowHeight

        ratio = $item.data('ratio')
        $item.data('initialheight', rowHeight)
        console.log "resizing child (ratio #{ratio}): new height #{rowHeight} new width: #{rowHeight * ratio}"
        $image = $item.find('.determiner').first()
        $image.height(rowHeight)
        $image.width(rowHeight * ratio) 
        $item.css('opacity', 1)


      resizeItems = ($children, cb) ->
        console.log "resizing all rows"
        $children.each (i, child) -> resizeItem($(child))
        cb?()


      addToRow = ($item, cb) ->
        newrow = no
        if currentRows < maxRows
          newrow = yes
          createRow(++currentRows)

        getRow = ->
          currentwidth = 1e10
          $selectedRow = null
          for i in [1..currentRows]
            $row = $("div.row.row-#{i}")
            if $row.width() < currentwidth
              $selectedRow = $row
              currentwidth = $row.width()
          $selectedRow

        $image = $item.find('.determiner').first()
        if not $image.length then throw new Error 'Item to add has no *.determiner'

        imageWidth = $image.width() || parseInt($image.attr('width'), 10)
        imageHeight = $image.height() || parseInt($image.attr('height'), 10)
        # add ratio to image
        $item.data('ratio', imageWidth / imageHeight)
        $item.addClass('row-item').attr('id', "row-item-#{_.random(0,99999)}")
        $row = getRow()
        $row.append($item)

        if newrow then resizeItems($("div.row").children(), cb)
        else 
          resizeItem($item)
          cb?()
      
      $(window).resizestop -> resizeItems($("div.row").children())


      $list.mousewheel (event, delta) ->
        @scrollLeft -= delta
        event.preventDefault()  

      $file = $('<input>', type: 'file', name: 'files[]')

      $file.fileupload
        url: '/api/picture'
        dataType: 'json'
        autoUpload: no
        uploadTemplateId: null
        downloadTemplateId: null
        previewMaxWidth: 800
        previewMaxHeight: 500
        disableImageResize: no
        previewThumbnail: no
        previewCrop: false

      $file.on 'fileuploadadd', (e, data) =>
        data.contexts ?= []

        if data.contexts.length is 0 then $hint.children(':first-child').hide()

        for file, i in data.files
          console.log "#{file.name} added"
          data.contexts[i] = $('<div>').addClass('container')


      $file.on 'fileuploadprocessalways', (e, data) =>
        file = data.files[data.index]
        $context = data.contexts[data.index]
        console.log "#{file.name} read (preview generated, exif extracted)"

        file.preview.className = 'determiner'
        $preview    = $('<div>').addClass('preview').append(file.preview).append($('<div>').addClass('shadow'))
        $meta       = $('<div>').addClass('meta')
        $meta.append($('<span>').addClass('description').html("#{file.name} (#{utils.formatFileSize(file.size)})"))

        $context.append($preview).append($meta)

        addToRow $context, ->
          data.submit()


      $file.on 'fileuploadprogress', (e, data) =>
        context = data.contexts[data.index]
        context.find('.shadow').css('height', "#{100 * ( 1 - data.loaded / data.total ) }%")

      $file.on 'fileuploaddone', (e, data) =>
        context = data.contexts[data.index]
        context.addClass('success').removeClass('failed')

        for pictureJson in data.result.files
          picture = new Picture(pictureJson)
          console.info "Received new picture from server", picture


      $file.on 'fileuploadfail', (e, data) =>
        context = data.contexts[data.index]
        context.addClass('failed')
        context.find('.shadow').css('height', '100%')

        console.error "upload failed: #{data.errorThrown} - #{data.textStatus}"

      $hint.append $file