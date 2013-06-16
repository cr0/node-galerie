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
      test:
        files: [
          expand:   true
          cwd:      'test/'
          src:      ['**/*.coffee']
          dest:     '.test'
          ext:      '.js'
        ]

    vows:
      server:
        options:
          reporter: 'spec'
        src:        ['.test/js/*.js']

    watch:
      coffee:
        files:      ['**/*.coffee']
        tasks:      'coffee'


  grunt.loadNpmTasks('grunt-contrib-clean');
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-vows'
  grunt.loadNpmTasks 'grunt-contrib-watch'

  grunt.registerTask 'build', [
    'clean:server', 'coffee:server'
  ]

  grunt.registerTask 'test', [
    'clean:test', 'coffee:test', 'vows:server', 'clean:test'
  ]   

  grunt.registerTask 'server', [
    'coffee', 'watch:coffee'
  ]