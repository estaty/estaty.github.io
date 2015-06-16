module.exports = (grunt)->

  SRC_COFFEE_DIR     = 'app'
  TARGET_JS_DIR      = 'js'
  TARGET_JS_MAPS_DIR = "#{TARGET_JS_DIR}/maps"

  SRC_CSS_DIR        = 'css'

  INDEX_HTML         = 'index.html'

  GRUNTFILE          = 'Gruntfile.coffee'

  CERTS_DIR          = 'node_modules/grunt-contrib-connect/tasks/certs/'

  grunt.initConfig

    clean:
      js:
        src: TARGET_JS_DIR

    coffeelint:
      app: "#{SRC_COFFEE_DIR}/**/*.coffee"
      Gruntfile: [GRUNTFILE]

    coffee:
      app:
        expand: true
        flatten: false
        cwd: SRC_COFFEE_DIR
        src: '**/*.coffee'
        dest: TARGET_JS_DIR
        ext: '.js'
        options:
          sourceMap: true
          sourceMapDir: TARGET_JS_MAPS_DIR

    connect:
      server:
        options:
          protocol: 'https'
          port: 8000
          livereload: 35729
          hostname: 'localhost'
          open: true

    watch:
      coffee:
        cwd: SRC_COFFEE_DIR
        files: '**/*.coffee'
        tasks: ['buildcoffee']
        options:
          livereload:
            key: grunt.file.read CERTS_DIR + 'server.key'
            cert: grunt.file.read CERTS_DIR + 'server.crt'

      Gruntfile:
        files: GRUNTFILE
        tasks: ['coffeelint:Gruntfile']

      assets:
        files: [
          "#{TARGET_JS_DIR}/**/*.js"
          "#{SRC_CSS_DIR}/**/*.css"
          INDEX_HTML
        ]
        tasks: ['noop']
        options:
          livereload: true

  grunt.loadNpmTasks('grunt-contrib-clean')
  grunt.loadNpmTasks('grunt-coffeelint')
  grunt.loadNpmTasks('grunt-contrib-coffee')
  grunt.loadNpmTasks('grunt-contrib-connect')
  grunt.loadNpmTasks('grunt-contrib-watch')

  grunt.registerTask('buildcoffee', ['coffeelint:app','coffee'])
  grunt.registerTask('build', ['coffeelint::Gruntfile', 'buildcoffee'])
  grunt.registerTask('watcher', ['connect', 'watch'])
  grunt.registerTask('dist', ['build'])

  grunt.registerTask('noop', [])

  grunt.registerTask('default', ['clean','build', 'watcher'])
