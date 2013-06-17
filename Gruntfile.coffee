module.exports = (grunt) ->
  grunt.initConfig
    pkg: grunt.file.readJSON 'package.json'

    clean:
      server:
        src:        ['app']
      test:
        src:        ['.test']

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
          files:          ['.test/**/*.js']
          require:        ['.codecov.js']
          coveralls:
            serviceName:  'travis-ci'
      server:
        options:
          reporter:   'spec'
          growl:      true
          files:      'test/**/*.coffee'
          compilers:  ['coffee:coffee-script']
      options:
        recursive:  true

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
    'mochacov:server'
  ]   

  grunt.registerTask 'travis', [
     'clean:test', 'mochacov:coverage', 'clean:test'
  ]

  grunt.registerTask 'server', [
    'coffee', 'watch:coffee'
  ]