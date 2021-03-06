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
		<script src="js/Animation.js"></script>
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

			var loader = new THREE.ColladaLoader();
			loader.options.convertUpAxis = true;
			loader.load( 'obj/stormtrooper/stormtrooper17.dae', function ( collada ) {

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
				//trooper.children[0].material = new THREE.MeshPhongMaterial( { map: trooper.children[0].material.map } );
				var animation = new THREE.Animation( trooper.children[0], trooper.children[0].geometry.animation );
						animation.play();*/

				dae.traverse( function ( child ) {

					if ( child instanceof THREE.SkinnedMesh ) {

						var animation = new THREE.Animation( child, child.geometry.animation );
						animation.play();

					}

				} );

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

				//particleLight = new THREE.Mesh( new THREE.SphereGeometry( 4, 8, 8 ), new THREE.MeshBasicMaterial( { color: 0xffffff } ) );
				//scene.add( particleLight );

				// Lights

				scene.add( new THREE.AmbientLight( 0xcccccc ) );

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

			var clock = new THREE.Clock();
			var totalTimer=0;

			function render() {

				var timer = Date.now() * 0.0005;

				//camera.position.x = Math.cos( timer ) * 10;
				//camera.position.y = 2;
				//camera.position.z = Math.sin( timer ) * 10;
				camera.position.x=7.5;
				camera.position.z=7.5;

				var delta=clock.getDelta();
				totalTimer+=delta;
				if (totalTimer>=10){
					totalTimer-=10;
					//dae.children[3].children[0].visible=!dae.children[3].children[0].visible;
				}
				//dae.rotation.y+=delta;

				camera.lookAt(scene.position);

				//particleLight.position.x = Math.sin( timer * 4 ) * 3009;
				//particleLight.position.y = Math.cos( timer * 5 ) * 4000;
				//particleLight.position.z = Math.cos( timer * 4 ) * 3009;

				THREE.AnimationHandler.update( delta/15 );

				renderer.render( scene, camera );

			}

		</script>
	</body>
</html>
