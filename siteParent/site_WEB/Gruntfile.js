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
					'<%= paths.build %>cascheid.css':['<%= paths.build %>cascheid.css']
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
				      '<%= paths.node %>bootstrap/dist/js/bootstrap.min.js', '<%= paths.node %>angular-bootstrap-toggle/dist/angular-bootstrap-toggle.min.js'],
				dest: '<%= paths.build %>vendor.js'
			},
			js: {
				src: ['<%= paths.js %>rain.js','<%= paths.js %>mist.js'],
				dest: '<%= paths.build %>cascheid.js'
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
	
	grunt.registerTask('build', ['clean:build', 'sass', 'cssmin', 'concat', 'clean:temp']);
}