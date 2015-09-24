<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE HTML>
<html lang="en">
	<head>
		<title>Blitzball!</title>
		<meta charset="utf-8">
		<style>
			body {
				background: #000;
				color: #333;
				padding: 0;
				margin: 0;
				overflow: hidden;
				font-family: georgia;
				font-size:1em;
				text-align: center;
			}
			a { color: white }

			#info { position: absolute; top: 10px; width: 100%; }
			#container { position: absolute; top: 0px; }
			#footer { position: absolute; bottom: 10px; width: 100%; }

			.h { color: skyblue }
			.c { display: inline; margin-left: 1em }

			#stats { position: absolute; top:0; left: 0 }
			#stats #fps { background: transparent !important }
			#stats #fps #fpsText { color: #888 !important }
			#stats #fps #fpsGraph { display: none }
			
			#map { position: absolute; top:0; left: 80%; z-index:1000 }
		</style>
	</head>

	<body>
		<div id="container"></div>

		<div id="info">
			<a href="http://threejs.org" target="_blank">three.js</a> - webgl dynamic cube reflection demo -
			veyron by <a href="http://artist-3d.com/free_3d_models/dnm/model_disp.php?uid=1129" target="_blank">Troyano</a> -
			gallardo by <a href="http://artist-3d.com/free_3d_models/dnm/model_disp.php?uid=1711" target="_blank">machman_3d</a>
		</div>
		
		<div id="map">
			<canvas id="mapCanvas"></canvas>
		</div>
		<div id="footer">
			cars control: <span class="h">WASD</span> / <span class="h">arrows</span>

			<div class="c">cameras: <span class="h">1</span> / <span class="h">2</span> / <span class="h">3</span> / <span class="h">4</span>
			/ <span class="h">5</span> / <span class="h">6</span>
			</div>

			<div class="c">
			day / night: <span class="h">n</span>
			</div>

			<div class="c">
			motion blur: <span class="h">b</span>
			</div>
		</div>

		<script src="js/three.js"></script>

		<script src="js/BinaryLoader.js"></script>

		<script src="js/shaders/BleachBypassShader.js"></script>
		<script src="js/shaders/BlendShader.js"></script>
		<script src="js/shaders/ConvolutionShader.js"></script>
		<script src="js/shaders/CopyShader.js"></script>
		<script src="js/shaders/FXAAShader.js"></script>
		<script src="js/shaders/HorizontalTiltShiftShader.js"></script>
		<script src="js/shaders/VerticalTiltShiftShader.js"></script>
		<script src="js/shaders/TriangleBlurShader.js"></script>
		<script src="js/shaders/VignetteShader.js"></script>

		<script src="js/postprocessing/EffectComposer.js"></script>
		<script src="js/postprocessing/RenderPass.js"></script>
		<script src="js/postprocessing/BloomPass.js"></script>
		<script src="js/postprocessing/ShaderPass.js"></script>
		<script src="js/postprocessing/MaskPass.js"></script>
		<script src="js/postprocessing/SavePass.js"></script>

		<script src="js/Car.js"></script>
		<script src="js/Detector.js"></script>
		<script src="js/stats.min.js"></script>

		<script>

			if ( ! Detector.webgl ) Detector.addGetWebGLMessage();

			var FOLLOW_CAMERA = false;

			var SCREEN_WIDTH = window.innerWidth;
			var SCREEN_HEIGHT = window.innerHeight;

			var SHADOW_MAP_WIDTH = 1024, SHADOW_MAP_HEIGHT = 1024;

			var container, stats;

			var camera, cameraTarget, scene, renderer;
			var renderTarget;

			var spotLight, ambientLight;

			var cubeCamera;

			var clock = new THREE.Clock();

			var controlsGallardo = {

				moveForward: false,
				moveBackward: false,
				moveLeft: false,
				moveRight: false

			};

			var controlsVeyron = {

				moveForward: false,
				moveBackward: false,
				moveLeft: false,
				moveRight: false

			};

			var mlib;

			var gallardo, veyron, currentCar;

			var effectDirt, hblur, vblur, effectBloom, effectKeep, effectBlend, effectFXAA;

			var config = {
				"veyron"	: { r: 0.5,	 model: null, backCam: new THREE.Vector3( 550, 100, -1000 ) },
				"gallardo"	: { r: 0.35, model: null, backCam: new THREE.Vector3( 550,   0, -1500 ) }
			};

			var flareA, flareB;
			var sprites = [];

			var ground, groundBasic;

			var blur = false;

			var v = 0.9, vdir = 1;

			var sphereRadius=30000;
			var ball;
			var goal1Loc=new THREE.Vector3( -20000, 400, -300 );
			var goal2Loc=new THREE.Vector3( 20000, 400, 300 );
			var ballTrajectory=null;
			var teamWithBall=1;

			//MINIMAP
			var mapCanvas;
			var mapContext;
			
			init();
			animate();

			function shoot(){
				if (teamWithBall==1){
					ball.lookAt(goal1Loc);
					ballTrajectory=goal1Loc.clone().sub(currentCar.root.position);
					teamWithBall=2;
				} else{
					ball.lookAt(goal2Loc);
					ballTrajectory=goal2Loc.clone().sub(currentCar.root.position);
					teamWithBall=1;
				}
				ball.position.set(currentCar.root.position.x, currentCar.root.position.y, currentCar.root.position.z);
			}

			function pass(destination){
				ballTrajectory=destination.root.position.clone().sub(currentCar.root.position);
				ball.position.set(currentCar.root.position.x, currentCar.root.position.y, currentCar.root.position.z);
				//currentCar=destination;
			}

			function testPass(){
				if (currentCar==gallardo){
					pass(veyron);
				} else {
					pass(gallardo);
				}
			}

			function init() {

				mapCanvas = document.getElementById('mapCanvas');
				mapContext = mapCanvas.getContext('2d');
				mapCanvas.height=window.innerWidth*.2;
				mapCanvas.width=window.innerWidth*.2;

				mapContext.rect(0,0,mapCanvas.width,mapCanvas.width);
				mapContext.fillStyle="grey";
				mapContext.fill();
				mapContext.beginPath();
				mapContext.arc(mapCanvas.width/2, mapCanvas.width/2, mapCanvas.width/2, 0, 2 * Math.PI, false);
				mapContext.closePath();
				mapContext.fillStyle = 'blue';
				mapContext.fill();
			      
				container = document.getElementById( 'container' );

				camera = new THREE.PerspectiveCamera( 18, SCREEN_WIDTH / SCREEN_HEIGHT, 1, 100000 );
				camera.position.set( 3000, 0, 3000 );

				cameraTarget = new THREE.Vector3();

				scene = new THREE.Scene();
				//scene.fog = new THREE.Fog( 0xffffff, 20000, 100000 );
				//scene.fog = new THREE.Fog( 0xffffff, 3000, 10000 );
				//scene.fog.color.setHSL( 0.51, 0.6, 0.6 );

				//createScene();
		        var urls = [
		                    'img/blitzball/water_xflip.jpg',
		                    'img/blitzball/water_xflip.jpg',
		                    'img/blitzball/water_yflip.jpg',
		                    'img/blitzball/water_yflip.jpg',
		                    'img/blitzball/water.jpg',
		                    'img/blitzball/water.jpg'
		                  ];
		        /*var urls = [
		                    'img/blitzball/cubepos-x.jpg',
		                    'img/blitzball/cubeneg-x.jpg',
		                    'img/blitzball/cubepos-y.jpg',
		                    'img/blitzball/cubeneg-y.jpg',
		                    'img/blitzball/cubepos-z.jpg',
		                    'img/blitzball/cubeneg-z.jpg'
		                  ];
		                  
		        var urls = [
		  		                    'img/blitzball/px.jpg',
		  		                    'img/blitzball/nx.jpg',
		  		                    'img/blitzball/py.jpg',
		  		                    'img/blitzball/ny.jpg',
		  		                    'img/blitzball/pz.jpg',
		  		                    'img/blitzball/nz.jpg'
		  		                  ];*/
  		        var textureCube = THREE.ImageUtils.loadTextureCube(urls);//, THREE.CubeRefractionMapping, onCubeLoad, onCubeError);
				textureCube.format = THREE.RGBFormat;
				var shader = THREE.ShaderLib[ "cube" ];
				shader.uniforms[ "tCube" ].value = textureCube;

				var material = new THREE.ShaderMaterial( {

					fragmentShader: shader.fragmentShader,
					vertexShader: shader.vertexShader,
					uniforms: shader.uniforms,
					side: THREE.DoubleSide

				} ),
				 
				//var texture = THREE.ImageUtils.loadTexture('crate.gif');
		        //var material = new THREE.MeshBasicMaterial({map: texture}),
				//mesh = new THREE.Mesh( new THREE.BoxGeometry( 50000, 50000, 50000 ), material );

				//scene.add( mesh );
				// LIGHTS

				//ambientLight = new THREE.AmbientLight( 0x555555 );
				ambientLight = new THREE.AmbientLight( 0xffffff );
				scene.add(ambientLight);

				spotLight = new THREE.SpotLight( 0xffffff, 1, 0, Math.PI/2, 1 );
				spotLight.position.set( 0, 1800, 1500 );
				spotLight.target.position.set( 0, 0, 0 );
				spotLight.castShadow = true;

				spotLight.shadowCameraNear = 100;
				spotLight.shadowCameraFar = camera.far;
				spotLight.shadowCameraFov = 50;

				spotLight.shadowBias = -0.00125;
				spotLight.shadowDarkness = 0.5;
				spotLight.shadowMapWidth = SHADOW_MAP_WIDTH;
				spotLight.shadowMapHeight = SHADOW_MAP_HEIGHT;

				scene.add( spotLight );

				directionalLight2 = new THREE.PointLight( 0xff9900, 0.25 );
				directionalLight2.position.set( 0.5, -1, 0.5 );
				//directionalLight2.position.normalize();
				//scene.add( directionalLight2 );

				// RENDERER

				renderer = new THREE.WebGLRenderer( { antialias: false } );
				//renderer.setClearColor( scene.fog.color );
				renderer.setClearColor(0xffffff);
				renderer.setPixelRatio( window.devicePixelRatio );
				renderer.setSize( SCREEN_WIDTH, SCREEN_HEIGHT );
				container.appendChild( renderer.domElement );

				// SHADOW

				//renderer.shadowMap.cullFace = THREE.CullFaceBack;
				//renderer.shadowMap.enabled = true;

				// STATS

				stats = new Stats();
				container.appendChild( stats.domElement );

				// CUBE CAMERA

				cubeCamera = new THREE.CubeCamera( 1, 100000, 128 );
				scene.add( cubeCamera );

				// MATERIALS

				var cubeTarget = cubeCamera.renderTarget;

				mlib = {

					body: [],

					"Chrome": new THREE.MeshLambertMaterial( { color: 0xffffff, envMap: cubeTarget  } ),

					"Dark chrome": new THREE.MeshLambertMaterial( { color: 0x444444, envMap: cubeTarget } ),

					"Black rough": new THREE.MeshLambertMaterial( { color: 0x050505, } ),

					"Dark glass": new THREE.MeshLambertMaterial( { color: 0x101020, envMap: cubeTarget, opacity: 0.5, transparent: true } ),
					"Orange glass": new THREE.MeshLambertMaterial( { color: 0xffbb00, opacity: 0.5, transparent: true } ),
					"Red glass": new THREE.MeshLambertMaterial( { color: 0xff0000, opacity: 0.5, transparent: true } ),

					"Black metal": new THREE.MeshLambertMaterial( { color: 0x222222, envMap: cubeTarget, combine: THREE.MultiplyOperation } ),
					"Orange metal": new THREE.MeshLambertMaterial( { color: 0xff6600, envMap: cubeTarget, combine: THREE.MultiplyOperation } )

				};

				mlib.body.push( [ "Orange", new THREE.MeshLambertMaterial( { color: 0x883300, envMap: cubeTarget, combine: THREE.MixOperation, reflectivity: 0.1 } ) ] );
				mlib.body.push( [ "Blue", new THREE.MeshLambertMaterial( { color: 0x113355, envMap: cubeTarget, combine: THREE.MixOperation, reflectivity: 0.1 } ) ] );
				mlib.body.push( [ "Red", new THREE.MeshLambertMaterial( { color: 0x660000, envMap: cubeTarget, combine: THREE.MixOperation, reflectivity: 0.1 } ) ] );
				mlib.body.push( [ "Black", new THREE.MeshLambertMaterial( { color: 0x000000, envMap: cubeTarget, combine: THREE.MixOperation, reflectivity: 0.2 } ) ] );
				mlib.body.push( [ "White", new THREE.MeshLambertMaterial( { color: 0xffffff, envMap: cubeTarget, combine: THREE.MixOperation, reflectivity: 0.2 } ) ] );

				mlib.body.push( [ "Carmine", new THREE.MeshPhongMaterial( { color: 0x770000, specular: 0xffaaaa, envMap: cubeTarget, combine: THREE.MultiplyOperation } ) ] );
				mlib.body.push( [ "Gold", new THREE.MeshPhongMaterial( { color: 0xaa9944, specular: 0xbbaa99, shininess: 50, envMap: cubeTarget, combine: THREE.MultiplyOperation } ) ] );
				mlib.body.push( [ "Bronze", new THREE.MeshPhongMaterial( { color: 0x150505, specular: 0xee6600, shininess: 10, envMap: cubeTarget, combine: THREE.MixOperation, reflectivity: 0.2 } ) ] );
				mlib.body.push( [ "Chrome", new THREE.MeshPhongMaterial( { color: 0xffffff, specular: 0xffffff, envMap: cubeTarget, combine: THREE.MultiplyOperation } ) ] );

				// FLARES

				//flareA = THREE.ImageUtils.loadTexture( "textures/lensflare2.jpg" );
				//flareB = THREE.ImageUtils.loadTexture( "textures/lensflare0.png" );

				//STADIUM
				//var sphereMaterial = new THREE.MeshLambertMaterial( { color: 0xffee00, envMap: textureCube, refractionRatio: 0.95, side:THREE.DoubleSide } );
				var sphereMaterial = new THREE.MeshLambertMaterial( { color: 0xffffff, envMap: textureCube, refractionRatio: 0.95, side:THREE.DoubleSide } );
				var sphereGeometry = new THREE.SphereGeometry( sphereRadius, 64, 64 );

				var netGeomtry=new THREE.TorusGeometry( sphereRadius/50, sphereRadius/1000, 16, 32 );//THREE.TorusGeometry(sphereGeometry/10, sphereGeometry/100, 8, 8, Math.PI * 2);

				var netMaterial = new THREE.MeshBasicMaterial( { color: 0xffffff } );
				var goal1 = new THREE.Mesh( netGeomtry, netMaterial );
				var goal2 = new THREE.Mesh( netGeomtry, netMaterial );
				goal1.position.x=20000;
				goal1.rotation.y=Math.PI/2;
				goal2.position.x=-20000;
				goal2.rotation.y=Math.PI/2;
				scene.add(goal1);
				scene.add(goal2);

				var clothTexture = THREE.ImageUtils.loadTexture( 'img/blitzball/net_pattern.png' );
				clothTexture.wrapS = clothTexture.wrapT = THREE.RepeatWrapping;
				clothTexture.anisotropy = 16;

				var clothMaterial = new THREE.MeshPhongMaterial( {
					specular: 0x030303,
					emissive: 0x111111,
					map: clothTexture,
					side: THREE.DoubleSide,
					alphaTest: 0.5
				} );

				// cloth geometry
				var clothGeometry = new THREE.CircleGeometry( sphereRadius/50, 16 );
				//clothGeometry.dynamic = true;

				// cloth mesh
				var net1 = new THREE.Mesh( clothGeometry, clothMaterial );
				var net2 = new THREE.Mesh( clothGeometry, clothMaterial );
				net1.position.x=20001;
				//object.castShadow = true;
				net1.rotation.y=Math.PI/2;
				scene.add(net1);
				net2.position.x=-20001;
				//object.castShadow = true;
				net2.rotation.y=Math.PI/2;
				scene.add(net2);
				
				var mesh = new THREE.Mesh( sphereGeometry, sphereMaterial );
				//mesh.position.x = - 900;
				//mesh.position.z = - 100;
				//mewsh.scale.x = mesh.scale.y = mesh.scale.z = 15;
				scene.add( mesh );

				var ballGeometry = new THREE.SphereGeometry( sphereRadius/500, 8, 8 );
				var ballTexture = THREE.ImageUtils.loadTexture("img/blitzball/ball.png");
				ballTexture.wrapS = ballTexture.wrapT = THREE.ClampToEdgeWrapping;
				//ballTexture.repeat.set( 32, 32 );
				var ballMaterial = new THREE.MeshBasicMaterial( { map: ballTexture } );
				ball = new THREE.Mesh( ballGeometry, ballMaterial );
				scene.add(ball);
				
				// CARS - VEYRON

				veyron = new THREE.Car();

				veyron.modelScale = 3;
				veyron.backWheelOffset = 2;

				veyron.callback = function( object ) {

					addCar( object, -300, -215, 0, 0 );
					setMaterialsVeyron( object );

					/*var sa = 2, sb = 5;

					var params  = {

						"a" : { map: flareA, color: 0xffffff, blending: THREE.AdditiveBlending },
						"b" : { map: flareB, color: 0xffffff, blending: THREE.AdditiveBlending },

						"ar" : { map: flareA, color: 0xff0000, blending: THREE.AdditiveBlending },
						"br" : { map: flareB, color: 0xff0000, blending: THREE.AdditiveBlending }

					};

					var flares = [
						// front
						[ "a", sa, [ 47, 38, 120 ] ], [ "a", sa, [ 40, 38, 120 ] ], [ "a", sa, [ 32, 38, 122 ] ],
						[ "b", sb, [ 47, 38, 120 ] ], [ "b", sb, [ 40, 38, 120 ] ], [ "b", sb, [ 32, 38, 122 ] ],
						[ "a", sa, [ -47, 38, 120 ] ], [ "a", sa, [ -40, 38, 120 ] ], [ "a", sa, [ -32, 38, 122 ] ],
						[ "b", sb, [ -47, 38, 120 ] ], [ "b", sb, [ -40, 38, 120 ] ], [ "b", sb, [ -32, 38, 122 ] ],
						// back
						[ "ar", sa, [ 22, 50, -123 ] ], [ "ar", sa, [ 32, 49, -123 ] ],
						[ "br", sb, [ 22, 50, -123 ] ], [ "br", sb, [ 32, 49, -123 ] ],
						[ "ar", sa, [ -22, 50, -123 ] ], [ "ar", sa, [ -32, 49, -123 ] ],
						[ "br", sb, [ -22, 50, -123 ] ], [ "br", sb, [ -32, 49, -123 ] ],
					];

					for ( var i = 0; i < flares.length; i ++ ) {

						var p = params[ flares[ i ][ 0 ] ];

						var s = flares[ i ][ 1 ];

						var x = flares[ i ][ 2 ][ 0 ];
						var y = flares[ i ][ 2 ][ 1 ];
						var z = flares[ i ][ 2 ][ 2 ];

						var material = new THREE.SpriteMaterial( p );
						var sprite = new THREE.Sprite( material );

						var spriteWidth = 128;
						var spriteHeight = 128;

						sprite.scale.set( s * spriteWidth, s * spriteHeight, s );
						sprite.position.set( x, y, z );

						object.bodyMesh.add( sprite );

						sprites.push( sprite );

					}*/

				};

				veyron.loadPartsBinary( "js/veyron_body_bin.js", "js/veyron_wheel_bin.js" );

				// CARS - GALLARDO

				gallardo = new THREE.Car();

				gallardo.modelScale = 2;
				gallardo.backWheelOffset = 45;

				gallardo.callback = function( object ) {

					addCar( object, 300, -110, 0, -110 );
					setMaterialsGallardo( object );

					/*var sa = 2, sb = 5;

					var params  = {

						"a" : { map: flareA, useScreenCoordinates: false, color: 0xffffff, blending: THREE.AdditiveBlending },
						"b" : { map: flareB, useScreenCoordinates: false, color: 0xffffff, blending: THREE.AdditiveBlending },

						"ar" : { map: flareA, useScreenCoordinates: false, color: 0xff0000, blending: THREE.AdditiveBlending },
						"br" : { map: flareB, useScreenCoordinates: false, color: 0xff0000, blending: THREE.AdditiveBlending }

					};

					var flares = [
						// front
						[ "a", sa, [ 70, 10, 160 ] ], [ "a", sa, [ 66, -1, 175 ] ], [ "a", sa, [ 66, -1, 165 ] ],
						[ "b", sb, [ 70, 10, 160 ] ], [ "b", sb, [ 66, -1, 175 ] ], [ "b", sb, [ 66, -1, 165 ] ],
						[ "a", sa, [ -70, 10, 160 ] ], [ "a", sa, [ -66, -1, 175 ] ], [ "a", sa, [ -66, -1, 165 ] ],
						[ "b", sb, [ -70, 10, 160 ] ], [ "b", sb, [ -66, -1, 175 ] ], [ "b", sb, [ -66, -1, 165 ] ],
						// back
						[ "ar", sa, [ 61, 19, -185 ] ], [ "ar", sa, [ 55, 19, -185 ] ],
						[ "br", sb, [ 61, 19, -185 ] ], [ "br", sb, [ 55, 19, -185 ] ],
						[ "ar", sa, [ -61, 19, -185 ] ], [ "ar", sa, [ -55, 19, -185 ] ],
						[ "br", sb, [ -61, 19, -185 ] ], [ "br", sb, [ -55, 19, -185 ] ],
					];


					for ( var i = 0; i < flares.length; i ++ ) {

						var p = params[ flares[ i ][ 0 ] ];

						var s = flares[ i ][ 1 ];

						var x = flares[ i ][ 2 ][ 0 ];
						var y = flares[ i ][ 2 ][ 1 ];
						var z = flares[ i ][ 2 ][ 2 ];

						var material = new THREE.SpriteMaterial( p );
						var sprite = new THREE.Sprite( material );

						var spriteWidth = 128;
						var spriteHeight = 128;

						sprite.scale.set( s * spriteWidth, s * spriteHeight, s );
						sprite.position.set( x, y, z );

						object.bodyMesh.add( sprite );

						sprites.push( sprite );

					}*/

				};

				gallardo.loadPartsBinary( "js/gallardo_body_bin.js", "js/gallardo_wheel_bin.js" );

				//

				config[ "gallardo" ].model = gallardo;
				config[ "veyron" ].model = veyron;

				currentCar = gallardo;

				// EVENTS

				document.addEventListener( 'keydown', onKeyDown, false );
				document.addEventListener( 'keyup', onKeyUp, false );

				window.addEventListener( 'resize', onWindowResize, false );

				// POSTPROCESSING

				renderer.autoClear = false;

				var renderTargetParameters = {
					minFilter: THREE.LinearFilter,
					magFilter: THREE.LinearFilter,
					format: THREE.RGBFormat,
					stencilBuffer: false
				};
				renderTarget = new THREE.WebGLRenderTarget( SCREEN_WIDTH, SCREEN_HEIGHT, renderTargetParameters );

				//effectSave = new THREE.SavePass( new THREE.WebGLRenderTarget( SCREEN_WIDTH, SCREEN_HEIGHT, renderTargetParameters ) );

				//effectBlend = new THREE.ShaderPass( THREE.BlendShader, "tDiffuse1" );

				effectFXAA = new THREE.ShaderPass( THREE.FXAAShader );
				var effectVignette = new THREE.ShaderPass( THREE.VignetteShader );
				//var effectBleach = new THREE.ShaderPass( THREE.BleachBypassShader );
				//effectBloom = new THREE.BloomPass( 0.75 );

				effectFXAA.uniforms[ 'resolution' ].value.set( 1 / SCREEN_WIDTH, 1 / SCREEN_HEIGHT );

				// tilt shift

				//hblur = new THREE.ShaderPass( THREE.HorizontalTiltShiftShader );
				//vblur = new THREE.ShaderPass( THREE.VerticalTiltShiftShader );

				var bluriness = 2;

				//hblur.uniforms[ 'h' ].value = bluriness / SCREEN_WIDTH;
				//vblur.uniforms[ 'v' ].value = bluriness / SCREEN_HEIGHT;

				if ( FOLLOW_CAMERA ) {

					if ( currentCar == gallardo ) {

						//hblur.uniforms[ 'r' ].value = vblur.uniforms[ 'r' ].value = rMap[ "gallardo" ];

					} else if ( currentCar == veyron ) {

						//hblur.uniforms[ 'r' ].value = vblur.uniforms[ 'r' ].value = rMap[ "veyron" ];

					}

				} else {

					//hblur.uniforms[ 'r' ].value = vblur.uniforms[ 'r' ].value = 0.35;

				}

				effectVignette.uniforms[ "offset" ].value = 0.5;
				effectVignette.uniforms[ "darkness" ].value = 0.2;

				// motion blur

				//effectBlend.uniforms[ 'tDiffuse2' ].value = effectSave.renderTarget;
				//effectBlend.uniforms[ 'mixRatio' ].value = 0.65;

				var renderModel = new THREE.RenderPass( scene, camera );

				effectVignette.renderToScreen = true;

				composer = new THREE.EffectComposer( renderer, renderTarget );

				composer.addPass( renderModel );

				composer.addPass( effectFXAA );

				//composer.addPass( effectBlend );
				//composer.addPass( effectSave );

				//composer.addPass( effectBloom );
				//composer.addPass( effectBleach );

				//composer.addPass( hblur );
				//composer.addPass( vblur );

				composer.addPass( effectVignette );

			}

			//

			function setSpritesOpacity( opacity ) {

				for ( var i = 0; i < sprites.length; i ++ ) {

					sprites[ i ].material.opacity = opacity;

				}

			}

			//


			function createScene() {

				// GROUND

				var texture = THREE.ImageUtils.loadTexture( "textures/cube/Park3Med/ny.jpg" );
				texture.wrapS = texture.wrapT = THREE.RepeatWrapping;
				texture.repeat.set( 50, 50 );

				groundBasic = new THREE.MeshBasicMaterial( { color: 0xffffff, map: texture } );
				groundBasic.color.setHSL( 0.1, 0.9, 0.7 );

				ground = new THREE.Mesh( new THREE.PlaneBufferGeometry( 50000, 50000 ), groundBasic );
				ground.position.y = - 215;
				ground.rotation.x = - Math.PI / 2;
				scene.add( ground );

				ground.castShadow = false;
				ground.receiveShadow = true;

				// OBJECTS

				var cylinderGeometry = new THREE.CylinderGeometry( 2, 50, 1000, 32 );
				var sphereGeometry = new THREE.SphereGeometry( 100, 32, 16 );

				var sy1 = -500 + 38;
				var sy2 = -88;

				addObject( cylinderGeometry, 0xff0000, 1500, 250, 0, sy1 );
				addObject( cylinderGeometry, 0xffaa00, -1500, 250, 0, sy1 );
				addObject( cylinderGeometry, 0x00ff00, 0, 250, 1500, sy1 );
				addObject( cylinderGeometry, 0x00ffaa, 0, 250, -1500, sy1 );

				addObject( sphereGeometry, 0xff0000, 1500, -125, 200, sy2 );
				addObject( sphereGeometry, 0xffaa00, -1500, -125, 200, sy2 );
				addObject( sphereGeometry, 0x00ff00, 200, -125, 1500, sy2 );
				addObject( sphereGeometry, 0x00ffaa, 200, -125, -1500, sy2 );

			}

			//

			var canvas = document.createElement( 'canvas' );
			canvas.width = 128;
			canvas.height = 128;

			var context = canvas.getContext( '2d' );
			var gradient = context.createRadialGradient( canvas.width / 2, canvas.height / 2, 0, canvas.width / 2, canvas.height / 2, canvas.width / 2 );
			gradient.addColorStop( 0.1, 'rgba(0,0,0,1)' );
			gradient.addColorStop( 1, 'rgba(0,0,0,0)' );

			context.fillStyle = gradient;
			context.fillRect( 0, 0, canvas.width, canvas.height );

			//

			var shadowTexture = new THREE.CanvasTexture( canvas );

			var shadowPlane = new THREE.PlaneBufferGeometry( 400, 400 );
			var shadowMaterial = new THREE.MeshBasicMaterial( {

				opacity: 0.35, transparent: true, map: shadowTexture,
				polygonOffset: false, polygonOffsetFactor: -0.5, polygonOffsetUnits: 1

			} );

			function addObject( geometry, color, x, y, z, sy ) {

				var object = new THREE.Mesh( geometry, new THREE.MeshLambertMaterial( { color: color } ) );
				object.position.set( x, y, z );
				object.castShadow = true;
				object.receiveShadow = true;
				scene.add( object );

				var shadow = new THREE.Mesh( shadowPlane, shadowMaterial );
				shadow.position.y = sy;
				shadow.rotation.x = - Math.PI / 2;
				object.add( shadow );

			}

			//

			function generateDropShadowTexture( object, width, height, bluriness ) {

				var renderTargetParameters = {
					minFilter: THREE.LinearMipmapLinearFilter,
					magFilter: THREE.LinearFilter,
					format: THREE.RGBAFormat,
					stencilBuffer: false
				};
				var shadowTarget = new THREE.WebGLRenderTarget( width, height, renderTargetParameters );

				var shadowMaterial = new THREE.MeshBasicMaterial( { color: 0x000000 } );
				var shadowGeometry = object.geometry.clone();

				var shadowObject = new THREE.Mesh( shadowGeometry, shadowMaterial );

				var shadowScene = new THREE.Scene();
				shadowScene.add( shadowObject );

				shadowObject.geometry.computeBoundingBox();

				var bb = shadowObject.geometry.boundingBox;

				var dimensions = new THREE.Vector3();
				dimensions.subVectors( bb.max, bb.min );

				var margin = 0.15,

				width  = dimensions.z,
				height = dimensions.x,
				depth  = dimensions.y,

				left   = bb.min.z - margin * width,
				right  = bb.max.z + margin * width,

				top    = bb.max.x + margin * height,
				bottom = bb.min.x - margin * height,

				near = bb.max.y + margin * depth,
				far  = bb.min.y - margin * depth;

				var topCamera = new THREE.OrthographicCamera( left, right, top, bottom, near, far );
				topCamera.position.y = bb.max.y;
				topCamera.lookAt( shadowScene.position );

				shadowScene.add( topCamera );

				var renderShadow = new THREE.RenderPass( shadowScene, topCamera );

				var blurShader = THREE.TriangleBlurShader;
				var effectBlurX = new THREE.ShaderPass( blurShader, 'texture' );
				var effectBlurY = new THREE.ShaderPass( blurShader, 'texture' );

				renderShadow.clearColor = new THREE.Color( 0x000000 );
				renderShadow.clearAlpha = 0;

				var blurAmountX = bluriness / width;
				var blurAmountY = bluriness / height;

				effectBlurX.uniforms[ 'delta' ].value = new THREE.Vector2( blurAmountX, 0 );
				effectBlurY.uniforms[ 'delta' ].value = new THREE.Vector2( 0, blurAmountY );

				var shadowComposer = new THREE.EffectComposer( renderer, shadowTarget );

				shadowComposer.addPass( renderShadow );
				shadowComposer.addPass( effectBlurX );
				shadowComposer.addPass( effectBlurY );

				renderer.clear();
				shadowComposer.render( 0.1 );

				return shadowTarget;

			}

			//

			function addCar( object, x, y, z, s ) {

				object.root.position.set( x, y, z );
				scene.add( object.root );

				object.enableShadows( true );

				if ( FOLLOW_CAMERA && object == currentCar ) {

					object.root.add( camera );

					camera.position.set( 350, 500, 2200 );
					//camera.position.set( 0, 3000, -500 );

					cameraTarget.z = 500;
					cameraTarget.y = 150;

					camera.lookAt( cameraTarget );

				}

				var shadowTexture = generateDropShadowTexture( object.bodyMesh, 64, 32, 15 );

				object.bodyMesh.geometry.computeBoundingBox();
				var bb = object.bodyMesh.geometry.boundingBox;

				var ss = object.modelScale * 1.1;
				var shadowWidth  =        ss * ( bb.max.z - bb.min.z );
				var shadowHeight = 1.25 * ss * ( bb.max.x - bb.min.x );

				var shadowPlane = new THREE.PlaneBufferGeometry( shadowWidth, shadowHeight );
				var shadowMaterial = new THREE.MeshBasicMaterial( {
					color: 0xffffff, opacity: 0.5, transparent: true, map: shadowTexture,
					polygonOffset: false, polygonOffsetFactor: -0.5, polygonOffsetUnits: 1
				} );

				var shadow = new THREE.Mesh( shadowPlane, shadowMaterial );
				shadow.position.y = s + 10;
				shadow.rotation.x = - Math.PI / 2;
				shadow.rotation.z = Math.PI / 2;

				object.root.add( shadow );

			}

			//

			function setCurrentCar( car, cameraType ) {

				var oldCar = currentCar;

				currentCar = config[ car ].model;

				if ( cameraType == "front" || cameraType == "back" ) {

					//hblur.uniforms[ 'r' ].value = vblur.uniforms[ 'r' ].value = config[ car ].r;

					FOLLOW_CAMERA = true;

					oldCar.root.remove( camera );
					currentCar.root.add( camera );

					if ( cameraType == "front" ) {

						camera.position.set( 350, 500, 2200 );

					} else if ( cameraType == "back" ) {

						camera.position.copy( config[ car ].backCam );

					}

					cameraTarget.set( 0, 150, 500 );

				} else {

					FOLLOW_CAMERA = false;

					oldCar.root.remove( camera );

					camera.position.set( 2000, 0, 2000 );
					cameraTarget.set( 0, 0, 0 );

					spotLight.position.set( 0, 1800, 1500 );

					//hblur.uniforms[ 'r' ].value = vblur.uniforms[ 'r' ].value = 0.35;

				}

			}

			//

			function onWindowResize( event ) {

				SCREEN_WIDTH = window.innerWidth;
				SCREEN_HEIGHT = window.innerHeight;

				camera.aspect = SCREEN_WIDTH / SCREEN_HEIGHT;
				camera.updateProjectionMatrix();

				renderer.setSize( SCREEN_WIDTH, SCREEN_HEIGHT );
				composer.setSize( SCREEN_WIDTH, SCREEN_HEIGHT );

				//hblur.uniforms[ 'h' ].value = 10.75 / SCREEN_WIDTH;
				//vblur.uniforms[ 'v' ].value = 10.75 / SCREEN_HEIGHT;

				effectFXAA.uniforms[ 'resolution' ].value.set( 1 / SCREEN_WIDTH, 1 / SCREEN_HEIGHT );

			}

			//

			function onKeyDown ( event ) {

				switch( event.keyCode ) {

					case 38: /*up*/	controlsGallardo.moveForward = true; break;
					case 87: /*W*/ 	controlsVeyron.moveForward = true; break;

					case 40: /*down*/controlsGallardo.moveBackward = true; break;
					case 83: /*S*/ 	 controlsVeyron.moveBackward = true; break;

					case 37: /*left*/controlsGallardo.moveLeft = true; break;
					case 65: /*A*/   controlsVeyron.moveLeft = true; break;

					case 39: /*right*/controlsGallardo.moveRight = true; break;
					case 68: /*D*/    controlsVeyron.moveRight = true; break;

					case 49: /*1*/	setCurrentCar( "gallardo", "center" ); break;
					case 50: /*2*/	setCurrentCar( "veyron", "center" ); break;
					case 51: /*3*/	setCurrentCar( "gallardo", "front" ); break;
					case 52: /*4*/	setCurrentCar( "veyron", "front" ); break;
					case 53: /*5*/	setCurrentCar( "gallardo", "back" ); break;
					case 54: /*6*/	setCurrentCar( "veyron", "back" ); break;

					case 78: /*N*/   testPass(); break;

					case 66: /*B*/   shoot(); break;

				}

			}

			function onKeyUp ( event ) {

				switch( event.keyCode ) {

					case 38: /*up*/controlsGallardo.moveForward = false; break;
					case 87: /*W*/ controlsVeyron.moveForward = false; break;

					case 40: /*down*/controlsGallardo.moveBackward = false; break;
					case 83: /*S*/ 	 controlsVeyron.moveBackward = false; break;

					case 37: /*left*/controlsGallardo.moveLeft = false; break;
					case 65: /*A*/ 	 controlsVeyron.moveLeft = false; break;

					case 39: /*right*/controlsGallardo.moveRight = false; break;
					case 68: /*D*/ 	  controlsVeyron.moveRight = false; break;

				}

			}


			//

			function setMaterialsGallardo( car ) {

				// BODY

				var materials = car.bodyMaterials;

				materials[ 0 ] = mlib.body[ 0 ][ 1 ]; 		// body
				materials[ 1 ] = mlib[ "Dark chrome" ]; 	// front under lights, back

				// WHEELS

				materials = car.wheelMaterials;

				materials[ 0 ] = mlib[ "Chrome" ];			// insides
				materials[ 1 ] = mlib[ "Black rough" ];	// tire

			}

			function setMaterialsVeyron( car ) {

				// 0 - top, front center, back sides
				// 1 - front sides
				// 2 - engine
				// 3 - small chrome things
				// 4 - backlights
				// 5 - back signals
				// 6 - bottom, interior
				// 7 - windshield

				// BODY

				var materials = car.bodyMaterials;

				materials[ 0 ] = mlib[ "Black metal" ];	// top, front center, back sides
				materials[ 1 ] = mlib[ "Chrome" ];			// front sides
				materials[ 2 ] = mlib[ "Chrome" ];			// engine
				materials[ 3 ] = mlib[ "Dark chrome" ];	// small chrome things
				materials[ 4 ] = mlib[ "Red glass" ];		// backlights
				materials[ 5 ] = mlib[ "Orange glass" ];	// back signals
				materials[ 6 ] = mlib[ "Black rough" ];	// bottom, interior
				materials[ 7 ] = mlib[ "Dark glass" ];		// windshield

				// WHEELS

				materials = car.wheelMaterials;

				materials[ 0 ] = mlib[ "Chrome" ];			// insides
				materials[ 1 ] = mlib[ "Black rough" ];	// tire

			}

			//

			function animate() {

				requestAnimationFrame( animate );

				render();
				stats.update();

			}

			function updateMinimap(){
				//reset canvas
				mapContext.beginPath();
				mapContext.arc(mapCanvas.width/2, mapCanvas.width/2, mapCanvas.width/2, 0, 2 * Math.PI, false);
				mapContext.closePath();
				mapContext.fillStyle = 'blue';
				mapContext.fill();

				//yellow team
				var rot=veyron.root.rotation.y+Math.PI/2;
				var x1=mapCanvas.width*(20000+veyron.root.position.x)/40000-Math.cos(rot)*mapCanvas.width/10;
				var y1=mapCanvas.width*(20000-veyron.root.position.z)/40000-Math.sin(rot)*mapCanvas.width/10;
				var x2=x1+Math.cos(rot-Math.PI/16)*(mapCanvas.width/10);
				var y2=y1+Math.sin(rot-Math.PI/16)*(mapCanvas.width/10);
				var x3=x1+Math.cos(rot+Math.PI/16)*(mapCanvas.width/10);
				var y3=y1+Math.sin(rot+Math.PI/16)*(mapCanvas.width/10);
				mapContext.beginPath();
				mapContext.moveTo(x1, mapCanvas.width-y1);
				mapContext.lineTo(x2, mapCanvas.width-y2);
				mapContext.lineTo(x3, mapCanvas.width-y3);
				mapContext.lineTo(x1, mapCanvas.width-y1);
				mapContext.closePath();
				mapContext.stroke();
				mapContext.fillStyle = "#FFCC00";
				mapContext.fill();


				//red team
				var rot=gallardo.root.rotation.y+Math.PI/2;
				var x1=mapCanvas.width*(20000+gallardo.root.position.x)/40000-Math.cos(rot)*mapCanvas.width/10;
				var y1=mapCanvas.width*(20000-gallardo.root.position.z)/40000-Math.sin(rot)*mapCanvas.width/10;
				var x2=x1+Math.cos(rot-Math.PI/16)*(mapCanvas.width/10);
				var y2=y1+Math.sin(rot-Math.PI/16)*(mapCanvas.width/10);
				var x3=x1+Math.cos(rot+Math.PI/16)*(mapCanvas.width/10);
				var y3=y1+Math.sin(rot+Math.PI/16)*(mapCanvas.width/10);
				mapContext.beginPath();
				mapContext.moveTo(x1, mapCanvas.width-y1);
				mapContext.lineTo(x2, mapCanvas.width-y2);
				mapContext.lineTo(x3, mapCanvas.width-y3);
				mapContext.lineTo(x1, mapCanvas.width-y1);
				mapContext.closePath();
				mapContext.stroke();
				mapContext.fillStyle = "#FF0000";
				mapContext.fill();
			}

			function render() {

				var delta = clock.getDelta();

				if (ballTrajectory!=null){
					var maxBallMove=5000*delta;
					var lengthLeft=ballTrajectory.length();
					if (maxBallMove>=lengthLeft){
						ball.position.addVectors(ball.position, ballTrajectory);
						ballTrajectory=null;
					} else {
						var scale = maxBallMove/lengthLeft;
						var mv = ballTrajectory.clone().multiplyScalar(scale);
						ball.position.addVectors(ball.position, mv);
						ballTrajectory.sub(mv);
					}
				}

				// day / night

				v = THREE.Math.clamp( v + 0.5 * delta * vdir, 0.1, 0.9 );
				//scene.fog.color.setHSL( 0.51, 0.5, v * 0.75 );

				//renderer.setClearColor( scene.fog.color );

				var vnorm = ( v - 0.05 ) / ( 0.9 - 0.05 );

				if ( vnorm < 0.3 ) {

					setSpritesOpacity( 1 - v / 0.3 );

				} else {

					setSpritesOpacity( 0 );

				}

				if ( veyron.loaded ) {

					veyron.bodyMaterials[ 1 ] = mlib[ "Chrome" ];
					veyron.bodyMaterials[ 2 ] = mlib[ "Chrome" ];

					veyron.wheelMaterials[ 0 ] = mlib[ "Chrome" ];

				}

				if ( gallardo.loaded ) {

					gallardo.wheelMaterials[ 0 ] = mlib[ "Chrome" ];

				}

				//effectBloom.copyUniforms[ "opacity" ].value = THREE.Math.mapLinear( vnorm, 0, 1, 1, 0.75 );

				//ambientLight.color.setHSL( 0, 0, THREE.Math.mapLinear( vnorm, 0, 1, 0.1, 0.3 ) );
				//groundBasic.color.setHSL( 0.1, 0.5, THREE.Math.mapLinear( vnorm, 0, 1, 0.4, 0.65 ) );

				// blur

				if ( blur ) {

					//effectSave.enabled = true;
					//effectBlend.enabled = true;

				} else {

					//effectSave.enabled = false;
					//effectBlend.enabled = false;

				}

				// update car model

				veyron.updateCarModel( delta, controlsVeyron );
				gallardo.updateCarModel( delta, controlsGallardo );

				// update camera

				if ( ! FOLLOW_CAMERA ) {

					cameraTarget.x = currentCar.root.position.x;
					cameraTarget.z = currentCar.root.position.z;

				} else {

					spotLight.position.x = currentCar.root.position.x - 500;
					spotLight.position.z = currentCar.root.position.z - 500;


				}

				// update shadows

				spotLight.target.position.x = currentCar.root.position.x;
				spotLight.target.position.z = currentCar.root.position.z;

				// render cube map

				var updateCubemap = true;

				if ( updateCubemap ) {

					veyron.setVisible( false );
					gallardo.setVisible( false );

					cubeCamera.position.copy( currentCar.root.position );

					renderer.autoClear = true;
					cubeCamera.updateCubeMap( renderer, scene );

					veyron.setVisible( true );
					gallardo.setVisible( true );

				}

				// render scene

				renderer.autoClear = false;
				//renderer.shadowMap.enabled = true;

				camera.lookAt( cameraTarget );

				renderer.setRenderTarget( null );

				renderer.clear();
				composer.render( 0.1 );

				//renderer.shadowMap.enabled = false;

				updateMinimap();
			}

		</script>

	</body>
</html>
