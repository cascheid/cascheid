if ( ! Detector.webgl ) Detector.addGetWebGLMessage();

			var container;

			var camera, scene, renderer;
			var cameraCube, sceneCube;

			var mesh, zmesh, lightMesh, geometry;
			var spheres = [];

			var directionalLight, pointLight;

			var mouseX = 0, mouseY = 0;

			var windowHalfX = window.innerWidth / 2;
			var windowHalfY = window.innerHeight / 2;
			var playerObject;

			//document.addEventListener( 'mousemove', onDocumentMouseMove, false );

			init();
			animate();

			function init() {

				container = document.createElement( 'div' );
				document.body.appendChild( container );

				camera = new THREE.PerspectiveCamera( 60, window.innerWidth / window.innerHeight, 1, 100000 );
				camera.position.z = 3200;

				cameraCube = new THREE.PerspectiveCamera( 60, window.innerWidth / window.innerHeight, 1, 100000 );

				scene = new THREE.Scene();
				sceneCube = new THREE.Scene();


				var ambient = new THREE.AmbientLight( 0xffffff );
				scene.add( ambient );

				var geometry = new THREE.SphereGeometry( 50, 16, 8 );

				var path = "img/blitzball/";
				var format = '.jpg';
				var urls = [
						path + 'water_xflip' + format, path + 'water_xflip' + format,
						path + 'water_yflip' + format, path + 'water_yflip' + format,
						path + 'water' + format, path + 'water' + format
					];


				var textureCube = THREE.ImageUtils.loadTextureCube( urls );
				textureCube.format = THREE.RGBFormat;

				var shader = THREE.FresnelShader;
				var uniforms = THREE.UniformsUtils.clone( shader.uniforms );

				uniforms[ "tCube" ].value = textureCube;

				var parameters = { fragmentShader: shader.fragmentShader, vertexShader: shader.vertexShader, uniforms: uniforms };
				var material = new THREE.ShaderMaterial( parameters );

				for ( var i = 0; i < 200; i ++ ) {

					var mesh = new THREE.Mesh( geometry, material );

					mesh.position.x = Math.random() * 10000 - 5000;
					mesh.position.y = Math.random() * 10000 - 5000;
					mesh.position.z = (Math.random()/2) * 10000 - 5000;

					mesh.scale.x = mesh.scale.y = mesh.scale.z = Math.random() * 3 + 1;

					scene.add( mesh );

					spheres.push( mesh );

				}

				scene.matrixAutoUpdate = false;

				// Skybox

				var shader = THREE.ShaderLib[ "cube" ];
				shader.uniforms[ "tCube" ].value = textureCube;

				var material = new THREE.ShaderMaterial( {

					fragmentShader: shader.fragmentShader,
					vertexShader: shader.vertexShader,
					uniforms: shader.uniforms,
					side: THREE.BackSide

				} ),

				mesh = new THREE.Mesh( new THREE.BoxGeometry( 100000, 100000, 100000 ), material );
				sceneCube.add( mesh );

				//

				renderer = new THREE.WebGLRenderer( { antialias: false } );
				renderer.setPixelRatio( window.devicePixelRatio );
				renderer.setSize( window.innerWidth, window.innerHeight );
				renderer.autoClear = false;
				container.appendChild( renderer.domElement );

				//

				window.addEventListener( 'resize', onWindowResize, false );

			}

			function onWindowResize() {

				windowHalfX = window.innerWidth / 2;
				windowHalfY = window.innerHeight / 2;

				camera.aspect = window.innerWidth / window.innerHeight;
				camera.updateProjectionMatrix();

				cameraCube.aspect = window.innerWidth / window.innerHeight;
				cameraCube.updateProjectionMatrix();

				renderer.setSize( window.innerWidth, window.innerHeight );

			}

			function onDocumentMouseMove( event ) {

				mouseX = ( event.clientX - windowHalfX ) * 10;
				mouseY = ( event.clientY - windowHalfY ) * 10;

			}
			//

			function animate() {

				requestAnimationFrame( animate );

				render();

			}
			
			var lastTimer= 0.0001 * Date.now();;

			function render() {

				var timer = 0.0001 * Date.now();

				camera.position.x += ( mouseX - camera.position.x ) * .05;
				camera.position.y += ( - mouseY - camera.position.y ) * .05;

				camera.lookAt( scene.position );

				cameraCube.rotation.copy( camera.rotation );

				for ( var i = 0, il = spheres.length; i < il; i ++ ) {

					var sphere = spheres[ i ];

					//sphere.position.x = 5000 * Math.cos( timer + i );
					sphere.position.y = 5000 * ((timer + i * 1.1 )%2)-5000;

				}
				
				if (playerObject!=null){
					playerObject.rotation.y=playerObject.rotation.y+((timer-lastTimer)*Math.PI);
				}

				renderer.clear();
				renderer.render( sceneCube, cameraCube );
				renderer.render( scene, camera );

				lastTimer=timer;
			}

			
			function loadPlayer(model){
				
				var onProgress = function ( xhr ) {
					if ( xhr.lengthComputable ) {
						var percentComplete = xhr.loaded / xhr.total * 100;
						console.log( Math.round(percentComplete, 2) + '% downloaded' );
					}
				};

				var onError = function ( xhr ) {
					console.log('failed to load '+model);
				};


				THREE.Loader.Handlers.add( /\.dds$/i, new THREE.DDSLoader() );
				
				var loader = new THREE.OBJMTLLoader();
				loader.load( 'img/blitzball/male02.obj', 'img/blitzball/male02_dds.mtl', function ( object ) {

					object.position.y = -800;
					object.position.x = -1000;
					object.scale.x=8;
					object.scale.y=8;
					object.scale.z=8;
					object.position.z = 1500;
					scene.add( object );
					
					playerObject=object;

				}, onProgress, onError );

				//

				/*renderer = new THREE.WebGLRenderer();
				renderer.setPixelRatio( window.devicePixelRatio );
				renderer.setSize( window.innerWidth, window.innerHeight );
				container.appendChild( renderer.domElement );*/
			}
			
			function unloadPlayer(){
				scene.remove(playerObject);
				if (playerObject.geometry) {
					playerObject.geometry.dispose();
                }

                if (playerObject.material) {
                    /*if (obj.material instanceof THREE.MeshFaceMaterial) {
                        $.each(obj.material.materials, function(idx, obj) {
                            obj.dispose();
                        });
                    } else {*/
                	playerObject.material.dispose();
                    //}
                }

                if (playerObject.dispose) {
                	playerObject.dispose();
                }
                playerObject=null;
			}