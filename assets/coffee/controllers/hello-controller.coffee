define [
  'controllers/base/controller'
  'models/hello-world'
  'views/search-view'
  'views/imprint-view'
], (Controller, HelloWorld, SearchView, ImprintView) ->
  'use strict'

  class HelloController extends Controller

    show: (params) ->
      @title = 'Hello'
      @model = new HelloWorld()
      @view = new SearchView
        model:   @model
        region: 'teaser'

    imprint: (params) ->
      @title = 'Imprint'
      @view = new ImprintView
        region: 'teaser'

