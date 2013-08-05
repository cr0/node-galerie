require.config

  baseUrl: '/js/'

  paths:
    jquery:     '//cdnjs.cloudflare.com/ajax/libs/jquery/2.0.3/jquery.min'
    underscore: '//cdnjs.cloudflare.com/ajax/libs/lodash.js/1.3.1/lodash.min'
    backbone:   '//cdnjs.cloudflare.com/ajax/libs/backbone.js/1.0.0/backbone-min'
    jade:       '//cdnjs.cloudflare.com/ajax/libs/jade/0.27.7/runtime.min'
    modernizr:  '//cdnjs.cloudflare.com/ajax/libs/modernizr/2.6.2/modernizr.min'
    chaplin:    'vendor/chaplin'

    # jquery
    lazyload:   'vendor/jquery.lazyload'
    mousewheel: 'vendor/jquery.mousewheel'
    scrollto:   'vendor/jquery.scrollto'
    scrollstop: 'vendor/jquery.scrollstop'

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
    mousewheel:
      deps:    ['jquery']
      exports: 'jQuery.fn.mousewheel'
    scrollto:
      deps:    ['jquery']
      exports: 'jQuery.fn.scrollTo'
#    'jquery.fileupload':
#      deps:     ['load-image', 'canvas-to-blob']


require ['application', 'routes'], (App, routes) ->
  new App
    routes: routes,
    controllerSuffix: '-controller'