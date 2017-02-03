module.exports = function(grunt) {
	'use strict';
	
	grunt.initConfig({
		pkg: grunt.file.readJSON('package.json'),
		paths: {
			root: 'src/main/webapp/',
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
				sourcemap: 'none'
			},
			lib: {
				files: {
					'<%= paths.build %>cascheid.css': '<%= paths.root %>sass/base.scss'
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
		}
	});
	
	require('load-grunt-tasks')(grunt);
	
	grunt.registerTask('build', ['clean:build', 'concat', 'clean:temp']);
}