module.exports = (grunt) ->
  grunt.initConfig
    pkg: grunt.file.readJSON 'package.json'

    coffee:
      server:
        options:
          sourceMap: true
        files: [
          expand:   true
          flatten:  true
          cwd:      'src/'
          src:      ['**/*.coffee']
          dest:     'app'
          ext:      '.js'
        ]

    watch:
      coffee:
        files: ['**/*.coffee']
        tasks: 'coffee'


  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-watch'

  grunt.registerTask 'build', [
    'coffee'
  ]  

  grunt.registerTask 'server', [
    'coffee', 'watch:coffee'
  ]