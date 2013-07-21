define [
  'controllers/base/controller'
  'models/hello-world'
  'views/home-view'
  'views/imprint-view'
], (Controller, HelloWorld, HomeView, ImprintView) ->
  'use strict'

  class HelloController extends Controller

    show: (params) ->
      @title = 'Hello'
      @model = new HelloWorld()
      @view = new HomeView
        model:   @model
        region: 'main'

    imprint: (params) ->
      @title = 'Imprint'
      @view = new ImprintView
        region: 'main'

