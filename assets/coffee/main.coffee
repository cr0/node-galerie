require.config

  waitSeconds: 15
  baseUrl: '/js/'

  paths:
    jquery:     '//cdnjs.cloudflare.com/ajax/libs/jquery/2.0.3/jquery.min'
    underscore: '//cdnjs.cloudflare.com/ajax/libs/lodash.js/1.3.1/lodash.min'
    backbone:   '//cdnjs.cloudflare.com/ajax/libs/backbone.js/1.0.0/backbone-min'
    jade:       '//cdnjs.cloudflare.com/ajax/libs/jade/0.27.7/runtime.min'
    modernizr:  '//cdnjs.cloudflare.com/ajax/libs/modernizr/2.6.2/modernizr.min'
    chaplin:    'vendor/chaplin'

    # addons
    async:      'vendor/requirejs/async',
    goog:       'vendor/requirejs/goog',
    propertyParser: 'vendor/requirejs/propertyParser'

    # jquery
    lazyload:   'vendor/jquery.lazyload'
    'jquery.mousewheel': 'vendor/jquery.mousewheel'
    'jquery.scrollto':   'vendor/jquery.scrollto'
    scrollstop: 'vendor/jquery.scrollstop'
    'jquery.resizestop': 'vendor/jquery.resizestop'

    # fileupload
    'load-image':                 'vendor/load-image'
    'load-image-meta':            'vendor/load-image-meta'
    'load-image-orientation':     'vendor/load-image-orientation'
    'load-image-exif':            'vendor/load-image-exif'
    'load-image-exif-map':        'vendor/load-image-exif-map'
    'load-image-ios':             'vendor/load-image-ios'
    'canvas-to-blob':             'vendor/canvas-to-blob'
    'tmpl':                       'vendor/tmpl'
    'jquery.ui.widget':           'vendor/jquery.ui.widget'
    'jquery.fileupload-process':  'vendor/jquery.fileupload-process'
    'jquery.fileupload-audio':    'vendor/jquery.fileupload-audio'
    'jquery.fileupload-video':    'vendor/jquery.fileupload-video'
    'jquery.fileupload-image':    'vendor/jquery.fileupload-image'
    'jquery.fileupload-validate': 'vendor/jquery.fileupload-validate'
    'jquery.fileupload-ui':       'vendor/jquery.fileupload-ui'
    'jquery.fileupload':          'vendor/jquery.fileupload'

    # plugins
    text:       '//cdnjs.cloudflare.com/ajax/libs/require-text/2.0.5/text'

  shim:
    backbone:
      deps:     ['underscore', 'jquery'],
      exports:  'Backbone'
    jade:
      exports: 'jade'
    modernizr:
      exports: 'Modernizr'
    lazyload:
      deps:    ['jquery', 'scrollstop']
      exports: 'jQuery.fn.lazyload'
    'jquery.mousewheel':
      deps:    ['jquery']
      exports: 'jQuery.fn.mousewheel'
    'jquery.scrollto':
      deps:    ['jquery']
      exports: 'jQuery.fn.scrollTo'
    'jquery.resizestop':
      deps:    ['jquery']
      exports: 'jQuery.fn.resizestop'
#    'jquery.fileupload':
#      deps:     ['load-image', 'canvas-to-blob']
#      
      
define 'gmaps', ['async!http://maps.google.com/maps/api/js?v=3&key=AIzaSyAPioLTf2snn7k023uPTMreFY-y1e0M10g&sensor=false'], () -> return window.google.maps


require ['application', 'routes'], (App, routes) ->
  new App
    routes: routes,
    controllerSuffix: '-controller'