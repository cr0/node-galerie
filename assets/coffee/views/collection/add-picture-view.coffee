define [
  'views/base/view'
], (View, Template) ->
  'use strict'

  class AddPictureView extends View

    render: ->

      console.log @collection

      $file = $('<input>', type: 'file', name: 'files[]')

      $file.fileupload
        autoUpload: no
        uploadTemplateId: null
        downloadTemplateId: null
        previewMaxWidth: 1600
        previewMaxHeight: 1200
        disableImageResize: no

      $file.on 'fileuploadadd', (e, data) =>
        data.contexts ?= []
        for file, i in data.files
          console.log "#{file.name} added"
          data.contexts[i] = $('<div>').addClass('item').hide()
          @$el.prepend data.contexts[i]

      $file.on 'fileuploadprocessalways', (e, data) =>
          file = data.files[data.index]
          context = data.contexts[data.index]
          console.log "#{file.name} read (preview generated, exif extracted)"
          context.append(file.preview).append($('<div>').addClass('shadow')).fadeIn()

      @$el.prepend $file