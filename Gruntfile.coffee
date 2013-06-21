module.exports = (grunt) ->
  grunt.initConfig
    pkg: grunt.file.readJSON 'package.json'

    clean:
      server:
        src:        ['app']
      coverage:
        src:        ['src/**/*.js']
      public:
        src:        ['public/css/*', 'public/js/*']

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
        files:        'test/**/*.coffee'
        compilers:    ['coffee:coffee-script']

    stylus:
      assets:
        options:
          linenos:    true
        files:
          'public/css/main.css': 'assets/styl/*.styl'

    shell:
      coverage:
        command:    './node_modules/coffee-coverage/bin/coffeecoverage --initfile .codecov.js --exclude node_modules,Gruntfile.coffee,.git,test,assets --path relative . .'

    watch:
      coffee:
        files:      ['src/**/*.coffee']
        tasks:      ['clean:server', 'coffee:server']
      stylus:
        files:      ['assets/styl/*.styl']
        tasks:      ['stylus:assets']



  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-stylus'
  grunt.loadNpmTasks 'grunt-mocha-cov'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-shell'

  grunt.registerTask 'build', [
    'clean:public', 'clean:server', 'coffee:server', 'stylus:assets'
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