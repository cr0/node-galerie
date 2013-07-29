require.config

  baseUrl: '/js/'

  paths:
    jquery:     '//cdnjs.cloudflare.com/ajax/libs/jquery/2.0.3/jquery.min'
    underscore: '//cdnjs.cloudflare.com/ajax/libs/underscore.js/1.5.1/underscore-min'
    backbone:   '//cdnjs.cloudflare.com/ajax/libs/backbone.js/1.0.0/backbone-min'
    jade:       '//cdnjs.cloudflare.com/ajax/libs/jade/0.27.7/runtime.min'
    modernizr:  '//cdnjs.cloudflare.com/ajax/libs/modernizr/2.6.2/modernizr'
    chaplin:    'vendor/chaplin'
    lazyload:   'vendor/jquery.lazyload'
    mousewheel: 'vendor/jquery.mousewheel'
    scrollto:   'vendor/jquery.scrollto'

    # plugins
    text:       '//cdnjs.cloudflare.com/ajax/libs/require-text/2.0.5/text'

  shim:
    backbone:
      deps:     ['underscore', 'jquery'],
      exports:  'Backbone'
    underscore:
      exports: '_'
    jade:
      exports: 'jade'
    modernizr:
      exports: 'Modernizr'
    lazyload:
      deps:    ['jquery']
      exports: 'jQuery.fn.lazyload'
    mousewheel:
      deps:    ['jquery']
      exports: 'jQuery.fn.mousewheel'
    scrollto:
      deps:    ['jquery']
      exports: 'jQuery.fn.scrollTo'


require ['application', 'routes'], (App, routes) ->
  new App
    routes: routes,
    controllerSuffix: '-controller'