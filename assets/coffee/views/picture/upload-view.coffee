define (require) ->
  'use strict'

  require 'jquery.fileupload'
  require 'jquery.fileupload-ui'
  require 'jquery.resizestop'

  $               = require 'jquery'
  _               = require 'underscore'
  utils           = require 'lib/utils'

  View            = require 'views/base/view'
  Template        = require 'templates/picture-upload'


  class PictureUploadView extends View
    template: Template

    render: ->
      super

      $hint = @$el.children 'div.drop'
      $list = @$el.children 'div.list'

      rowToUse = 0
      itemsPerRow = 3
      rowDefaultHeight = 400

      addToRow = ($item, cb) =>

        validateRow = ($row) ->
          $children = $row.children()

          ratios = _.map $children, (child) -> $(child).data('ratio')

          newheight = rowDefaultHeight
          width = 1e10
          difference = -100

          i = 0
          start = _.reduce $children, (memo, child) -> 
            memo + parseInt($(child).css('margin-left'), 10) + parseInt($(child).css('margin-right'), 10)
          , 0

          while difference > 1 or difference < -1
            oldheightdiff = heightdiff * -1
            if difference > 1 then heightdiff = Math.ceil(difference / $children.length)
            # math ceil make -0.6 to 0 which should be -1
            else if  difference < 1 then heightdiff = Math.ceil(difference / $children.length * -1) * -1

            if heightdiff is oldheightdiff then heightdiff--
            newheight -= heightdiff

            width = _.reduce ratios, (memo, ratio) -> 
              memo + ratio * newheight
            , start
            difference = parseInt(width - $list.width(), 10)
            # console.log "new difference #{difference} and newheight is #{newheight} (#{width} - #{$list.width()}) -- smallered about #{heightdiff}"

            # kill endless loops
            if ++i is 1000 then throw new Error "Cannot find correct height for item"

          if newheight > rowDefaultHeight then  newheight = rowDefaultHeight

          console.log "need resize from #{$row.height()} to #{newheight}, took #{i} iterations"
          $children.each (idx, child) -> resizeImage($(child), newheight)

          cb?()

        resizeImage = ($item, newheight) ->
          ratio = $item.data('ratio')
          $image = $item.find('.determiner').first()
          $image.height(newheight)
          $image.width(newheight * ratio) 
          $item.css('opacity', 1)


        $currentRow = $list.children(".row-#{rowToUse}")
        $image = $item.find('.determiner').first()
        if not $image.length then throw new Error 'Item to add has no *.determiner'

        imageWidth = $image.width() || parseInt $image.attr('width'), 10
        imageHeight = $image.height() || parseInt $image.attr('height'), 10
        # add ratio to image
        $item.data('ratio', imageWidth / imageHeight)
        $item.addClass('row-item')

        # row does not exist, create one
        if not $currentRow.length
          $currentRow = $('<div>').addClass("row row-#{rowToUse}")
          $list.append($currentRow)
          $(window).resizestop -> validateRow $currentRow 

        # if row is full create a new one
        if $currentRow.children().length >= itemsPerRow 
          rowToUse++
          return addToRow $item

        $currentRow.append $item
        validateRow $currentRow 
          

      $file = $('<input>', type: 'file', name: 'files[]')

      $file.fileupload
        url: '/upload'
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
        $description= $('<div>').addClass('meta').append($('<span>').addClass('description').html("#{file.name} (#{utils.formatFileSize(file.size)})"))
        $context.append($preview).append($description)

        addToRow $context, ->
          data.submit()


      $file.on 'fileuploadprogress', (e, data) =>
        context = data.contexts[data.index]
        initialheight = context.data 'initialheight'

        context.children('.shadow').stop().animate
          height: "#{ initialheight * ( 1 - data.loaded / data.total ) }px"


      $file.on 'fileuploadfail', (e, data) =>
        console.error "upload failed: #{data.errorThrown} - #{data.textStatus}"

      $hint.append $file