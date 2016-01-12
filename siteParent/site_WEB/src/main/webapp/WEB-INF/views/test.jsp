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

		<script src="js/ColladaLoader.js?version=1.00"></script>
		<script src="js/BBPlayer2.js?version=1.00"></script>

		<script src="js/Detector.js"></script>
		<script src="js/stats.min.js"></script>

		<script>

			if ( ! Detector.webgl ) Detector.addGetWebGLMessage();

			var container, stats;

			var camera, scene, renderer, objects;
			var particleLight;
			var dae;
			var cameraTarget = new THREE.Vector3(0,0,0);
			var cameraControls = {
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

			var sphereRadius=100;

			var myTeam = [];
			var myTeamLW = new THREE.BBPlayer(null, new THREE.Vector3(20, 0, 50), true);
			myTeamLW.loadPlayer(function(){addPlayer(myTeamLW);});
			myTeam.push(myTeamLW);
			var myTeamRW = new THREE.BBPlayer(null, new THREE.Vector3(20, 0, -50), true);
			myTeamRW.loadPlayer(function(){addPlayer(myTeamRW);});
			myTeam.push(myTeamRW);
			var myTeamMF = new THREE.BBPlayer(null, new THREE.Vector3(40, 0, 0), true);
			myTeamMF.loadPlayer(function(){addPlayer(myTeamMF);});
			myTeam.push(myTeamMF);
			var myTeamLB = new THREE.BBPlayer(null, new THREE.Vector3(60, 0, 20), true);
			myTeamLB.loadPlayer(function(){addPlayer(myTeamLB);});
			myTeam.push(myTeamLB);
			var myTeamRB = new THREE.BBPlayer(null, new THREE.Vector3(60, 0, -20), true);
			myTeamRB.loadPlayer(function(){addPlayer(myTeamRB);});
			myTeam.push(myTeamRB);
			var myTeamGK = new THREE.BBPlayer(null, new THREE.Vector3(95, 0, 0), true);
			myTeamGK.loadPlayer(function(){addPlayer(myTeamGK);});

			var oppTeam = [];
			var oppTeamLW = new THREE.BBPlayer(null, new THREE.Vector3(-20, 0, -50), true);
			oppTeamLW.loadPlayer(function(){addPlayer(oppTeamLW);});
			oppTeam.push(oppTeamLW);
			var oppTeamRW = new THREE.BBPlayer(null, new THREE.Vector3(20, 0, 50), true);
			oppTeamRW.loadPlayer(function(){addPlayer(oppTeamRW);});
			oppTeam.push(oppTeamRW);
			var oppTeamMF = new THREE.BBPlayer(null, new THREE.Vector3(-40, 0, 0), true);
			oppTeamMF.loadPlayer(function(){addPlayer(oppTeamMF);});
			oppTeam.push(oppTeamMF);
			var oppTeamLB = new THREE.BBPlayer(null, new THREE.Vector3(-60, 0, -20), true);
			oppTeamLB.loadPlayer(function(){addPlayer(oppTeamLB);});
			oppTeam.push(oppTeamLB);
			var oppTeamRB = new THREE.BBPlayer(null, new THREE.Vector3(-60, 0, 20), true);
			oppTeamRB.loadPlayer(function(){addPlayer(oppTeamRB);});
			oppTeam.push(oppTeamRB);
			var oppTeamGK = new THREE.BBPlayer(null, new THREE.Vector3(-95, 0, 0), true);
			oppTeamGK.loadPlayer(function(){addPlayer(oppTeamGK);});

			var allPlayers=[];
			for (var i=0; i<myTeam.length; i++){
				allPlayers.push(myTeam[i]);
			}
			allPlayers.push(myTeamGK);
			for (var i=0; i<oppTeam.length; i++){
				allPlayers.push(oppTeam[i]);
			}
			allPlayers.push(oppTeamGK);

			var clock = null;
			var loadedCount=0;
			
			function addPlayer(bbPlayer){
				//dae = bbPlayer.root;
				loadedCount++;
				if (loadedCount>=12){
					init();
				}
			}
			
			function init() {

				container = document.createElement( 'div' );
				document.body.appendChild( container );

				camera = new THREE.PerspectiveCamera( 45, window.innerWidth / window.innerHeight, 1, 2000 );
				camera.position.set( 0, 2, 30 );

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
				for (var i=0; i<allPlayers.length; i++){
					scene.add(allPlayers[i].root);
				}
				//scene.add( dae );

				//skybox
				var cubeMap = new THREE.CubeTexture( [] );
				cubeMap.format = THREE.RGBFormat;

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

					startGame();
				}, 
				function ( xhr ) {
					if ( xhr.lengthComputable ) {
						var percentComplete = xhr.loaded / xhr.total * 100;
						console.log('Downloading skybox:' + Math.round(percentComplete, 2) + '%' );
					}
				}, 
				function ( xhr ) {
					console.log('failed to load skybox');
				});

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
					new THREE.BoxGeometry( sphereRadius*3, sphereRadius*3, sphereRadius*3 ),
					skyBoxMaterial
				);

				scene.add( skyBox );
				
				//sphere
				var sphereTexture = THREE.ImageUtils.loadTexture('img/blitzball/water.jpg');//TODO real texture
				var sphereMaterial = new THREE.MeshLambertMaterial( { color: 0xffffff, map: sphereTexture,  side:THREE.BackSide, opacity:0.5, transparent:true } );
				var sphereGeometry = new THREE.SphereGeometry( sphereRadius, 64, 64 );
				var sphereMesh = new THREE.Mesh( sphereGeometry, sphereMaterial );
				scene.add( sphereMesh );

				// Lights
				scene.add( new THREE.AmbientLight( 0xffffff ) );

				renderer = new THREE.WebGLRenderer();
				renderer.setPixelRatio( window.devicePixelRatio );
				renderer.setSize( window.innerWidth, window.innerHeight );
				container.appendChild( renderer.domElement );

				stats = new Stats();
				stats.domElement.style.position = 'absolute';
				stats.domElement.style.top = '0px';
				container.appendChild( stats.domElement );

				window.addEventListener( 'resize', onWindowResize, false );
				window.addEventListener('keydown', onKeyDown, true);
				window.addEventListener('keyup', onKeyUp, true);
			}

			function startGame(){
				cameraTarget.set(scene.position.x, scene.position.y, scene.position.z);

				clock=new THREE.Clock();
				for (var i=0; i<allPlayers.length; i++){
					allPlayers[i].animation.playTreadAnimation();
				}
				animate();
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
				case 87: /*w*/	cameraControls.moveForward=true; break;
				case 83: /*s*/cameraControls.moveBackward = true; break;
				case 65: /*a*/cameraControls.moveLeft = true; break;
				case 68: /*d*/cameraControls.moveRight = true; break;
				case 81: /*q*/	cameraControls.moveUp=true; break;
				case 69: /*e*/	cameraControls.moveDown=true; break;
				
				case 38: /*up*/event.preventDefault(); trooperControls.moveForward = true; break;
				case 40: /*down*/event.preventDefault(); trooperControls.moveBackward = true; break;
				case 37: /*left*/event.preventDefault(); trooperControls.moveLeft = true; break;
				case 39: /*right*/event.preventDefault(); trooperControls.moveRight = true; break;
				}
			}

			function onKeyUp(event){
				switch(event.keyCode) {
				case 87: /*w*/	cameraControls.moveForward=false; break;
				case 83: /*s*/cameraControls.moveBackward = false; break;
				case 65: /*a*/cameraControls.moveLeft = false; break;
				case 68: /*d*/cameraControls.moveRight = false; break;
				case 81: /*q*/	cameraControls.moveUp=false; break;
				case 69: /*e*/	cameraControls.moveDown=false; break;
				
				case 38: /*up*/event.preventDefault(); trooperControls.moveForward = false; break;
				case 40: /*down*/event.preventDefault(); trooperControls.moveBackward = false; break;
				case 37: /*left*/event.preventDefault(); trooperControls.moveLeft = false; break;
				case 39: /*right*/event.preventDefault(); trooperControls.moveRight = false; break;
				}
			}

			function render() {

				//var timer = Date.now() * 0.0005;
				var delta = clock.getDelta()*3;

				if (cameraControls.moveForward){
					camera.position.z -= delta;
				} else if (cameraControls.moveBackward){
					camera.position.z += delta;
				}
				if (cameraControls.moveLeft){
					camera.position.x -= delta;
				} else if (cameraControls.moveRight){
					camera.position.x += delta;
				}
				if (cameraControls.lookLeft){
					cameraTarget.x -= delta;
				} else if (cameraControls.lookRight){
					cameraTarget.x += delta;
				}
				if (cameraControls.moveUp){
					cameraTarget.y += delta;
				} else if (cameraControls.moveDown){
					cameraTarget.y -= delta;
				}
				//camera.position.x = Math.cos( timer ) * 10;
				camera.position.y = 2;
				//camera.position.z = Math.sin( timer ) * 10;
				
				if (trooperControls.moveForward||trooperControls.moveBackward||trooperControls.moveLeft||trooperControls.moveRight){
					cameraTarget.set(myTeamLW.root.position.x, myTeamLW.root.position.y, myTeamLW.root.position.z);
				}
				camera.lookAt(cameraTarget);
				//camera.lookAt( scene.position );

				//particleLight.position.x = Math.sin( timer * 4 ) * 3009;
				//particleLight.position.y = Math.cos( timer * 5 ) * 4000;
				//particleLight.position.z = Math.cos( timer * 4 ) * 3009;

				myTeamLW.hasBall=true;
				for (var i=0; i<allPlayers.length; i++){
					allPlayers[i].updatePlayer(delta/30, trooperControls);
				}
				//THREE.AnimationHandler.update( delta/30 );

				renderer.render( scene, camera );

			}

		</script>
	</body>
</html>
