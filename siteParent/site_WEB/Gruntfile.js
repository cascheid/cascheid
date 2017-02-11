module.exports = function(grunt) {
	'use strict';
	
	grunt.initConfig({
		pkg: grunt.file.readJSON('package.json'),
		paths: {
			root: 'src/main/webapp/WEB-INF/',
			node: 'node_modules/',
			js: 'src/main/webapp/WEB-INF/js/',
			build: 'src/main/webapp/build/',
			temp: 'src/main/webapp/build/temp/'
		},
		clean: {
			build: ['<%= paths.build %>'],
			temp: ['<%= paths.temp %>']
		},
		sass: {
			options: {
				sourcemap: 'false'
			},
			dist: {
				files: {
					'<%= paths.build %>cascheid.css': '<%= paths.root %>sass/build.scss'
				}
			}
		},
		cssmin: {
			minify: {
				files: { 
					'<%= paths.build %>cascheid.min.css':['<%= paths.build %>cascheid.css']
				}
			}
		},
		concat: {
			vendorcss: {
				src: ['<%= paths.node %>bootstrap/dist/css/bootstrap.min.css', '<%= paths.node %>angular-bootstrap-toggle/dist/angular-bootstrap-toggle.min.css'],
				dest: '<%= paths.build %>vendor.css'
			},
			vendorjs: {
				src: ['<%= paths.node %>jquery/dist/jquery.min.js', '<%= paths.node %>angular/angular.min.js', 
				      '<%= paths.node %>angular-ui-bootstrap/dist/ui-bootstrap.js', '<%= paths.node %>angular-ui-bootstrap/dist/ui-bootstrap-tpls.js', 
				      '<%= paths.node %>bootstrap/dist/js/bootstrap.min.js', '<%= paths.node %>angular-bootstrap-toggle/dist/angular-bootstrap-toggle.min.js',
				      '<%= paths.node %>angular-animate/angular-animate.min.js', '<%= paths.node %>angular-ui-router/release/angular-ui-router.min.js'],
				dest: '<%= paths.build %>vendor.js'
			}
		},
		uglify : {
			cascheid : {
				src : ['<%= paths.js %>index.app.js', '<%= paths.js %>index/*.js', '<%= paths.js %>common/*.js'],
				dest : '<%= paths.build %>cascheid.min.js'
			}
		},
		copy: {
			fonts: {
				files: [{
					expand: true,
			        cwd: '<%= paths.node %>/bootstrap/dist/fonts/',
			        src: '*',
			        dest: '<%= paths.build %>fonts/'
				}]
			}
		},
		watch: {
			styles: {
				files: ['<%= paths.root %>sass/{,*/}*.scss'],
				tasks: ['sass', 'cssmin']
			}
		}
	});
	
	require('load-grunt-tasks')(grunt);
	
	grunt.registerTask('build', ['clean:build', 'sass', 'cssmin', 'concat', 'uglify', 'copy', 'clean:temp']);
}