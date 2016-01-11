<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
	<head>
		<title>three.js webgl - collada</title>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0">
		<style>
			body {
				font-family: Monospace;
				background-color: #000000;
				margin: 0px;
				overflow: hidden;
			}

			#info {
				color: #fff;
				position: absolute;
				top: 10px;
				width: 100%;
				text-align: center;
				z-index: 100;
				display:block;

			}

			a { color: skyblue }
		</style>
	</head>
	<body>
		<div id="info">
			<a href="http://threejs.org" target="_blank">three.js</a> -
			monster by <a href="http://www.3drt.com/downloads.htm" target="_blank">3drt</a>
		</div>

		<script src="js/three73.js?version=1.00"></script>
		<script src="js/BBAnimation.js"></script>
		<script src="js/AnimationHandler.js"></script>
		<script src="js/KeyFrameAnimation.js"></script>
		<script src="js/TGALoader.js"></script>

		<script src="js/ColladaLoader.js?version=1.00"></script>

		<script src="js/Detector.js"></script>
		<script src="js/stats.min.js"></script>

		<script>

			if ( ! Detector.webgl ) Detector.addGetWebGLMessage();

			var container, stats;

			var camera, scene, renderer, objects;
			var particleLight;
			var dae;
			var cameraTarget = new THREE.Vector3(0,0,0);
			var controls = {
					moveForward: false,
					moveBackward: false,
					moveLeft: false,
					moveRight: false,
					moveUp: false,
					moveDown: false
			};

			var trooperControls = {
				moveForward: false,
				moveBackward:false,
				moveLeft: false,
				moveRight:false
			}

			var loader = new THREE.ColladaLoader();
			loader.options.convertUpAxis = true;
			loader.load( 'obj/stormtrooper/stormtrooper.dae', function ( collada ) {

				dae = collada.scene;
				var trooper = dae.children[1];
				trooper.children[0].material.reflectivity=0;
				trooper.children[0].material.shininess=0;
				trooper.children[0].material.side=THREE.DoubleSide;
				//trooper.children[0].material.combine=THREE.MixOperation;
				//trooper.children[0].material.refractionRatio=0;
				/*var path = "img/blitzball/";
				var format = '.jpg';
				var urls = [
						path + 'px' + format, path + 'nx' + format,
						path + 'py' + format, path + 'ny' + format,
						path + 'pz' + format, path + 'nz' + format
					];
				var reflectionCube = THREE.ImageUtils.loadTextureCube( urls );
				//var cubeMaterial3 = new THREE.MeshPhongMaterial( { color: 0x000000, specular:0xaa0000, envMap: reflectionCube, combine: THREE.MixOperation, reflectivity: 0.25 } );
				trooper.children[0].material.envMap =reflectionCube;//cubeMaterial3;
				//trooper.children[0].material.color.setHex(0xffffff);// =THREE.Color(0x000000);
				//trooper.children[0].material.specular.setHex(0xffffff);//=THREE.Color(0xaa0000);
				trooper.children[0].material.emissive.setHex(0xffffff);//=THREE.Color(0xaa0000);
				trooper.children[0].material.reflectivity=0.75;
				//trooper.children[0].material.refractionRatio=0;
				trooper.children[0].combine=THREE.MixOperation;
				//trooper.children[0].material = new THREE.MeshPhongMaterial( { map: trooper.children[0].material.map } );*/
				var animation = new THREE.BBAnimation( trooper.children[0], trooper.children[0].geometry.animation );
				animation.playTreadAnimation();

				/*dae.traverse( function ( child ) {

					if ( child instanceof THREE.SkinnedMesh ) {

						var animation = new THREE.Animation( child, child.geometry.animation );
						animation.play();

					}

				} );*/

				dae.scale.x = dae.scale.y = dae.scale.z = 2;
				dae.updateMatrix();

				init();
				animate();

			} );

			function init() {

				container = document.createElement( 'div' );
				document.body.appendChild( container );

				camera = new THREE.PerspectiveCamera( 45, window.innerWidth / window.innerHeight, 1, 2000 );
				camera.position.set( 0, 2, 10 );

				scene = new THREE.Scene();

				// Grid

				var size = 14, step = 1;

				var geometry = new THREE.Geometry();
				var material = new THREE.LineBasicMaterial( { color: 0x303030 } );

				for ( var i = - size; i <= size; i += step ) {

					geometry.vertices.push( new THREE.Vector3( - size, - 0.04, i ) );
					geometry.vertices.push( new THREE.Vector3(   size, - 0.04, i ) );

					geometry.vertices.push( new THREE.Vector3( i, - 0.04, - size ) );
					geometry.vertices.push( new THREE.Vector3( i, - 0.04,   size ) );

				}

				var line = new THREE.LineSegments( geometry, material );
				scene.add( line );

				// Add the COLLADA

				scene.add( dae );

				//skybox
				var cubeMap = new THREE.CubeTexture( [] );
				cubeMap.format = THREE.RGBFormat;

				var onProgress = function ( xhr ) {
					if ( xhr.lengthComputable ) {
						var percentComplete = xhr.loaded / xhr.total * 100;
						console.log( Math.round(percentComplete, 2) + '% downloaded' );
					}
				};

				var onError = function ( xhr ) {
					console.log('failed to load ');
				};

				var loader = new THREE.ImageLoader();
				loader.load( 'img/blitzball/skybox.jpg', function ( image ) {

					var getSide = function ( x, y ) {

						var size = 512;

						var canvas = document.createElement( 'canvas' );
						canvas.width = size;
						canvas.height = size;

						var context = canvas.getContext( '2d' );
						context.drawImage( image, - x * size, - y * size );

						return canvas;

					};

					cubeMap.images[ 0 ] = getSide( 2, 1 ); // px
					cubeMap.images[ 1 ] = getSide( 0, 1 ); // nx
					cubeMap.images[ 2 ] = getSide( 1, 0 ); // py
					cubeMap.images[ 3 ] = getSide( 1, 2 ); // ny
					cubeMap.images[ 4 ] = getSide( 1, 1 ); // pz
					cubeMap.images[ 5 ] = getSide( 3, 1 ); // nz
					cubeMap.needsUpdate = true;

				}, onProgress, onError   );

				var cubeShader = THREE.ShaderLib[ 'cube' ];
				cubeShader.uniforms[ 'tCube' ].value = cubeMap;

				var skyBoxMaterial = new THREE.ShaderMaterial( {
					fragmentShader: cubeShader.fragmentShader,
					vertexShader: cubeShader.vertexShader,
					uniforms: cubeShader.uniforms,
					depthWrite: false,
					side: THREE.BackSide
				} );

				var skyBox = new THREE.Mesh(
					new THREE.BoxGeometry( 100, 100, 100 ),
					skyBoxMaterial
				);

				scene.add( skyBox );
				
				//sphere
				var sphereRadius=40;
				var urls = [
			                    'img/blitzball/water_xflip.jpg',
			                    'img/blitzball/water_xflip.jpg',
			                    'img/blitzball/water_yflip.jpg',
			                    'img/blitzball/water_yflip.jpg',
			                    'img/blitzball/water.jpg',
			                    'img/blitzball/water.jpg'
			                  ];
	  		    var textureCube = THREE.ImageUtils.loadTextureCube(urls);//, THREE.CubeRefractionMapping, onCubeLoad, onCubeError);
				textureCube.format = THREE.RGBFormat;
				//var sphereMaterial = new THREE.MeshLambertMaterial( { color: 0x00acc8, envMap: cubeMap, refractionRatio: 0.75, side:THREE.DoubleSide } );

				var sphereTexture = THREE.ImageUtils.loadTexture('img/blitzball/water.jpg');
				var sphereMaterial = new THREE.MeshLambertMaterial( { color: 0xffffff, map: sphereTexture,  side:THREE.DoubleSide, opacity:0.5, transparent:true } );

				//var sphereMaterial = new THREE.LineBasicMaterial({color: 0x00acc8, side:THREE.DoubleSide, opacity:0.5, transparent:true});
				var sphereGeometry = new THREE.SphereGeometry( sphereRadius, 64, 64 );

				var mesh = new THREE.Mesh( sphereGeometry, sphereMaterial );
				scene.add( mesh );

				//particleLight = new THREE.Mesh( new THREE.SphereGeometry( 4, 8, 8 ), new THREE.MeshBasicMaterial( { color: 0xffffff } ) );
				//scene.add( particleLight );

				// Lights

				scene.add( new THREE.AmbientLight( 0xffffff ) );

				//var directionalLight = new THREE.DirectionalLight(/*Math.random() * 0xffffff*/0xeeeeee );
				//directionalLight.position.x = Math.random() - 0.5;
				//directionalLight.position.y = Math.random() - 0.5;
				//directionalLight.position.z = Math.random() - 0.5;
				//directionalLight.position.normalize();
				//scene.add( directionalLight );

				//var pointLight = new THREE.PointLight( 0xffffff, 4 );
				//particleLight.add( pointLight );

				renderer = new THREE.WebGLRenderer();
				renderer.setPixelRatio( window.devicePixelRatio );
				renderer.setSize( window.innerWidth, window.innerHeight );
				container.appendChild( renderer.domElement );

				stats = new Stats();
				stats.domElement.style.position = 'absolute';
				stats.domElement.style.top = '0px';
				container.appendChild( stats.domElement );

				//

				window.addEventListener( 'resize', onWindowResize, false );
				window.addEventListener('keydown', onKeyDown, true);
				window.addEventListener('keyup', onKeyUp, true);

				cameraTarget.set(scene.position.x, scene.position.y, scene.position.z);

			}

			function onWindowResize() {

				camera.aspect = window.innerWidth / window.innerHeight;
				camera.updateProjectionMatrix();

				renderer.setSize( window.innerWidth, window.innerHeight );

			}

			//

			function animate() {

				requestAnimationFrame( animate );

				render();
				stats.update();

			}

			function onKeyDown(event){
				switch(event.keyCode) {
				case 87: /*w*/	controls.moveForward=true; break;
				case 83: /*s*/controls.moveBackward = true; break;
				case 65: /*a*/controls.moveLeft = true; break;
				case 68: /*d*/controls.moveRight = true; break;
				case 81: /*q*/	controls.moveUp=true; break;
				case 69: /*e*/	controls.moveDown=true; break;
				
				case 38: /*up*/trooperControls.moveForward = true; break;
				case 40: /*down*/trooperControls.moveBackward = true; break;
				case 37: /*left*/trooperControls.moveLeft = true; break;
				case 39: /*right*/trooperControls.moveRight = true; break;
				}
			}

			function onKeyUp(event){
				switch(event.keyCode) {
				case 87: /*w*/	controls.moveForward=false; break;
				case 83: /*s*/controls.moveBackward = false; break;
				case 65: /*a*/controls.moveLeft = false; break;
				case 68: /*d*/controls.moveRight = false; break;
				case 81: /*q*/	controls.moveUp=false; break;
				case 69: /*e*/	controls.moveDown=false; break;
				
				case 38: /*up*/trooperControls.moveForward = false; break;
				case 40: /*down*/trooperControls.moveBackward = false; break;
				case 37: /*left*/trooperControls.moveLeft = false; break;
				case 39: /*right*/trooperControls.moveRight = false; break;
				}
			}

			var clock = new THREE.Clock();

			function render() {

				//var timer = Date.now() * 0.0005;
				var delta = clock.getDelta()*3;

				if (controls.moveForward){
					camera.position.z -= delta;
				} else if (controls.moveBackward){
					camera.position.z += delta;
				}
				if (controls.moveLeft){
					camera.position.x -= delta;
				} else if (controls.moveRight){
					camera.position.x += delta;
				}
				if (controls.lookLeft){
					cameraTarget.x -= delta;
				} else if (controls.lookRight){
					cameraTarget.x += delta;
				}
				if (controls.moveUp){
					cameraTarget.y += delta;
				} else if (controls.moveDown){
					cameraTarget.y -= delta;
				}
				//camera.position.x = Math.cos( timer ) * 10;
				camera.position.y = 2;
				//camera.position.z = Math.sin( timer ) * 10;

				if (trooperControls.moveForward){
					dae.position.z-=delta;
				} else if (trooperControls.moveBackward){
					dae.position.z+=delta;
				}
				if (trooperControls.moveLeft){
					dae.position.x-=delta;
				} else if (trooperControls.moveRight){
					dae.position.x+=delta;
				}
				if (trooperControls.moveForward||trooperControls.moveBackward||trooperControls.moveLeft||trooperControls.moveRight){
					cameraTarget.set(dae.position.x, dae.position.y, dae.position.z);
				}
				camera.lookAt(cameraTarget);
				//camera.lookAt( scene.position );

				//particleLight.position.x = Math.sin( timer * 4 ) * 3009;
				//particleLight.position.y = Math.cos( timer * 5 ) * 4000;
				//particleLight.position.z = Math.cos( timer * 4 ) * 3009;

				THREE.AnimationHandler.update( delta/30 );

				renderer.render( scene, camera );

			}

		</script>
	</body>
</html>
