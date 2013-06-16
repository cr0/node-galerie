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

    simplemocha:
      server:
        options:
          reporter: 'spec'
        src:        ['test/**/*.coffee']

    watch:
      coffee:
        files:      ['**/*.coffee']
        tasks:      'coffee'


  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-simple-mocha'
  grunt.loadNpmTasks 'grunt-contrib-watch'

  grunt.registerTask 'build', [
    'clean:server', 'coffee:server'
  ]

  grunt.registerTask 'test', [
    'simplemocha:server'
  ]   

  grunt.registerTask 'server', [
    'coffee', 'watch:coffee'
  ]