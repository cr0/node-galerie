if (typeof _$jscoverage === 'undefined') _$jscoverage = {};
if ((typeof global !== 'undefined') && (typeof global._$jscoverage === 'undefined')) {
    global._$jscoverage = _$jscoverage
} else if ((typeof window !== 'undefined') && (typeof window._$jscoverage === 'undefined')) {
    window._$jscoverage = _$jscoverage
}
if (! _$jscoverage["Gruntfile.coffee"]) {
    _$jscoverage["Gruntfile.coffee"] = [];
    _$jscoverage["Gruntfile.coffee"][1] = 0;
    _$jscoverage["Gruntfile.coffee"][2] = 0;
    _$jscoverage["Gruntfile.coffee"][44] = 0;
    _$jscoverage["Gruntfile.coffee"][45] = 0;
    _$jscoverage["Gruntfile.coffee"][46] = 0;
    _$jscoverage["Gruntfile.coffee"][47] = 0;
    _$jscoverage["Gruntfile.coffee"][49] = 0;
    _$jscoverage["Gruntfile.coffee"][53] = 0;
    _$jscoverage["Gruntfile.coffee"][57] = 0;
    _$jscoverage["Gruntfile.coffee"][61] = 0;
}

_$jscoverage["Gruntfile.coffee"].source = ["module.exports = (grunt) ->", "  grunt.initConfig", "    pkg: grunt.file.readJSON 'package.json'", "", "    clean:", "      server:", "        src:        ['app']", "      test:", "        src:        ['.test']", "", "    coffee:", "      server:", "        options:", "          sourceMap: true", "        files: [", "          expand:   true", "          cwd:      'src/'", "          src:      ['**/*.coffee']", "          dest:     'app'", "          ext:      '.js'", "        ]", "", "    mochacov:", "      coverage:", "        options:", "          require:        ['.codecov.js']", "          coveralls:", "            serviceName:  'travis-ci'", "      server:", "        options:", "          reporter:   'spec'", "          growl:      true", "      options:", "        recursive:    true", "        files:        'test/**/*.coffee'", "        compilers:    ['coffee:coffee-script']", "", "    watch:", "      coffee:", "        files:      ['**/*Test.coffee']", "        tasks:      'coffee'", "", "", "  grunt.loadNpmTasks 'grunt-contrib-clean'", "  grunt.loadNpmTasks 'grunt-contrib-coffee'", "  grunt.loadNpmTasks 'grunt-mocha-cov'", "  grunt.loadNpmTasks 'grunt-contrib-watch'", "", "  grunt.registerTask 'build', [", "    'clean:server', 'coffee:server'", "  ]", "", "  grunt.registerTask 'test', [", "    'mochacov:server'", "  ]   ", "", "  grunt.registerTask 'travis', [", "     'clean:test', 'mochacov:coverage', 'clean:test'", "  ]", "", "  grunt.registerTask 'server', [", "    'coffee', 'watch:coffee'", "  ]"];

(function() {
  _$jscoverage["Gruntfile.coffee"][1]++;

  module.exports = function(grunt) {
    _$jscoverage["Gruntfile.coffee"][2]++;
    grunt.initConfig({
      pkg: grunt.file.readJSON('package.json'),
      clean: {
        server: {
          src: ['app']
        },
        test: {
          src: ['.test']
        }
      },
      coffee: {
        server: {
          options: {
            sourceMap: true
          },
          files: [
            {
              expand: true,
              cwd: 'src/',
              src: ['**/*.coffee'],
              dest: 'app',
              ext: '.js'
            }
          ]
        }
      },
      mochacov: {
        coverage: {
          options: {
            require: ['.codecov.js'],
            coveralls: {
              serviceName: 'travis-ci'
            }
          }
        },
        server: {
          options: {
            reporter: 'spec',
            growl: true
          }
        },
        options: {
          recursive: true,
          files: 'test/**/*.coffee',
          compilers: ['coffee:coffee-script']
        }
      },
      watch: {
        coffee: {
          files: ['**/*Test.coffee'],
          tasks: 'coffee'
        }
      }
    });
    _$jscoverage["Gruntfile.coffee"][44]++;
    grunt.loadNpmTasks('grunt-contrib-clean');
    _$jscoverage["Gruntfile.coffee"][45]++;
    grunt.loadNpmTasks('grunt-contrib-coffee');
    _$jscoverage["Gruntfile.coffee"][46]++;
    grunt.loadNpmTasks('grunt-mocha-cov');
    _$jscoverage["Gruntfile.coffee"][47]++;
    grunt.loadNpmTasks('grunt-contrib-watch');
    _$jscoverage["Gruntfile.coffee"][49]++;
    grunt.registerTask('build', ['clean:server', 'coffee:server']);
    _$jscoverage["Gruntfile.coffee"][53]++;
    grunt.registerTask('test', ['mochacov:server']);
    _$jscoverage["Gruntfile.coffee"][57]++;
    grunt.registerTask('travis', ['clean:test', 'mochacov:coverage', 'clean:test']);
    _$jscoverage["Gruntfile.coffee"][61]++;
    return grunt.registerTask('server', ['coffee', 'watch:coffee']);
  };

}).call(this);
