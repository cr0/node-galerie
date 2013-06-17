module.exports = (grunt) ->
  grunt.initConfig
    pkg: grunt.file.readJSON 'package.json'

    clean:
      server:
        src:        ['app']

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
          coveralls:
            serviceName: 'travis-ci'
      test:
        options:
          reporter: 'spec'
          growl:    true
      options:
        recursive:  true
        compilers:  ['coffee:coffee-script']
        files:      'test/**/*.coffee'

    watch:
      coffee:
        files:      ['**/*.coffee']
        tasks:      'coffee'


  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-mocha-cov'
  grunt.loadNpmTasks 'grunt-contrib-watch'

  grunt.registerTask 'build', [
    'clean:server', 'coffee:server'
  ]

  grunt.registerTask 'test', [
    'mochacov:test'
  ]   

  grunt.registerTask 'travis', [
    'mochacov:coverage'
  ]

  grunt.registerTask 'server', [
    'coffee', 'watch:coffee'
  ]