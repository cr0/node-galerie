define (require) ->
  'use strict'

  View        = require 'views/base/view'
  Collection  = require 'models/collection'
  Template    = require 'templates/gallery-new'

  require 'vendor/jquerypp/dom/form_params'

  class NewGalleryView extends View
    template:   Template
    id:         'gallery-new'

    events:
      'submit form': 'create'

    create: (e) ->
      e.preventDefault()

      form = @$el.find('form').formParams()

      collection = new Collection
        name:         form.name
        description:  form.description
        tags:         form.tags.split(', ')

      collection.save
        success: (collection) =>
          console.log 'collection created with id', collection.id
          @publishEvent '!router:routeByName', 'collection', id: collection.id

        error: (collection, err) =>
          console.error "unable to create collection: #{err}"


