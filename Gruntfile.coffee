path = require 'path'

module.exports = (grunt) ->
  grunt.initConfig
    pkg: grunt.file.readJSON 'package.json'

    clean:
      server:
        src:        []
      coverage:
        src:        ['src/**/*.js']
      public:
        src:        ['public/css/**', 'public/js/**', '!public/js/vendor/*']
        filter:     'isFile'

    coffee:
      server:
        options:
          sourceMap: true
        files: [
          expand:   true
          cwd:      'src/'
          src:      ['**/*.coffee']
          dest:     'app'
          ext:      '.js'
        ]
      client:
        options:
          sourceMap: true
#          sourceRoot: 'coffee/'
        files: [
          expand:   true
          cwd:      'assets/coffee'
          src:      ['**/*.coffee']
          dest:     'public/js/'
          ext:      '.js'
        ]

    mochacov:
      coverage:
        options:
          require:        ['.codecov.js']
          coveralls:
            serviceName:  'travis-ci'
      server:
        options:
          reporter:   'spec'
          growl:      true
      options:
        recursive:    true
        files:        'test/**/*-test.coffee'
        compilers:    ['coffee:coffee-script']

    stylus:
      assets:
        options:
          use: [
            require('nib')
          ]
          paths: [
            'public/'
          ]
          urlfunc:    'url',
          linenos:    true
        files:
          'public/css/main.css': 'assets/styl/main.styl'

    jade:
      client:
        options:
          amd: true
          namespace: false
          client: true
          compileDebug: false
          processName: ( filename ) ->
            path.basename( filename ).split( '.' )[0]
        files:
          'public/js/templates/search.js':        'assets/tpl/search.jade'
          'public/js/templates/search-item.js':   'assets/tpl/search-item.jade'

          'public/js/templates/gallery.js':       'assets/tpl/gallery.jade'
          'public/js/templates/gallery-item.js':  'assets/tpl/gallery-item.jade'

          'public/js/templates/setting.js':       'assets/tpl/setting.jade'

          'public/js/templates/footer.js':        'assets/tpl/footer.jade'
          'public/js/templates/imprint.js':       'assets/tpl/imprint.jade'
          'public/js/templates/login.js':         'assets/tpl/login.jade'
          'public/js/templates/error.js':         'assets/tpl/error.jade'
          'public/js/templates/skeleton.js':      'assets/tpl/skeleton.jade'

          'public/js/templates/ajax/.js':         'assets/tpl/ajax/login.jade'

    requirejs: 
      compile: 
        options:
          preserveLicenseComments: false
          generateSourceMaps: false
          baseUrl: 'public/js'
          name: 'main'
          mainConfigFile: 'public/js/main.js'
          out: 'public/js/optimized.js'

    shell:
      coverage:
        command:    './node_modules/coffee-coverage/bin/coffeecoverage --initfile .codecov.js --exclude node_modules,Gruntfile.coffee,.git,test,assets --path relative . .'

    watch:
      coffee:
        files:      ['src/**/*.coffee']
        tasks:      ['clean:server', 'coffee:server']
      client:
        files:      ['assets/styl/**/*.styl', 'assets/tpl/**/*.jade', 'assets/coffee/**/*.coffee']
        tasks:      ['stylus:assets', 'jade:client', 'coffee:client']
        options: 
          livereload: true



  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-stylus'
  grunt.loadNpmTasks 'grunt-contrib-jade'
  grunt.loadNpmTasks 'grunt-contrib-requirejs'
  grunt.loadNpmTasks 'grunt-mocha-cov'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-shell'

  grunt.registerTask 'build', [
    'clean:public', 'clean:server', 'coffee:server', 'coffee:client', 'stylus:assets', 'jade:client'
  ]

  grunt.registerTask 'test', [
    'mochacov:server'
  ]   

  grunt.registerTask 'travis', [
     'shell:coverage', 'mochacov:coverage', 'clean:coverage'
  ]

  grunt.registerTask 'dev', [
    'clean:public', 'clean:server', 'coffee:server', 'stylus:assets', 'watch'
  ]