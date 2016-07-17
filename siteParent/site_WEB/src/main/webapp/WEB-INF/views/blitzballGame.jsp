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
			
			#selector{
				position:absolute;
				left:-5vmin;
				top:0vmin;
				width:5vmin;
				height:3.5vmin;
			}
			
			#actionMenu{
				font-size:3.5vmin;
				color: #ffffff;
				position:absolute;
				top:20vmin;
				width:16%;
				height:12vmin;
				left:24%;
				background-color:#6B238E;
				background-image: url("img/blitzball/cracks.png");
				border: 5px double white;
				line-height:4vmin;
				padding-left:5vmin;
				text-align:left;
				z-index:1000;
			}
			
			#allStats{
				font-size:3.5vmin;
				color: #ffffff;
				position:absolute;
				top:10vmin;
				width:40%;
				height:24vmin;
				left:55%;
				background-color:#6B238E;
				background-image: url("img/blitzball/cracks.png");
				border: 5px double white;
				line-height:4vmin;
				padding-left:5vmin;
				text-align:left;
				display:table;
				z-index:1000;
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
			
			#map { position: absolute; bottom:0; left: 80%; z-index:1000 }
		</style>
	</head>

	<body>
		<div id="container"></div>

		<div id="info">
			<a href="http://threejs.org" target="_blank">three.js</a> - webgl dynamic cube reflection demo -
			veyron by <a href="http://artist-3d.com/free_3d_models/dnm/model_disp.php?uid=1129" target="_blank">Troyano</a> -
			gallardo by <a href="http://artist-3d.com/free_3d_models/dnm/model_disp.php?uid=1711" target="_blank">machman_3d</a>
		</div>
		
		<div id="actionMenu">
			<div style="position:absolute; left:5vmin">
			<img id="selector" src="img/blitzball/arrow.png" />
				<div>
					<label id="menu1">Pass</label>
				</div>
				<div>
					<label id="menu2">Shoot</label>
				</div>
				<div>
					<label id="menu3">Dribble</label>
				</div>
				<div>
					<label id="menu4"></label>
				</div>
				<div>
					<label id="menu5"></label>
				</div>
				<div>
					<label id="menu6"></label>
				</div>
			</div>
		</div>
		
		<div id="allStats">
		<div id="playerStats" style="display:table-row;">
			<div style="display:table-cell; width:20%"><label id="playerName"></label></div>
			<div style="display:table-cell; width:10%"><label>HP:</label></div>
			<div style="display:table-cell; width:10%"><label id="playerHP"></label></div>
			<div style="display:table-cell; width:10%"><label>END:</label></div>
			<div style="display:table-cell; width:10%"><label id="playerEND"></label></div>
			<div style="display:table-cell; width:10%"><label>PAS:</label></div>
			<div style="display:table-cell; width:10%"><label id="playerPAS"></label></div>
			<div style="display:table-cell; width:10%"><label>SHT:</label></div>
			<div style="display:table-cell; width:10%"><label id="playerSHT"></label></div>
		</div>
		<div id="break1Stats" style="display:none;">
			<div style="display:table-cell"><label id="break1Name"></label></div>
			<div style="display:table-cell"><label>HP:</label></div>
			<div style="display:table-cell"><label id="break1HP"></label></div>
			<div style="display:table-cell"><label>ATK:</label></div>
			<div style="display:table-cell"><label id="break1ATK"></label></div>
			<div style="display:table-cell"><label>BLK:</label></div>
			<div style="display:table-cell"><label id="break1BLK"></label></div>
			<div style="display:table-cell"></div>
			<div style="display:table-cell"></div>
		</div>
		<div id="break2Stats" style="display:none;">
			<div style="display:table-cell"><label id="break2Name"></label></div>
			<div style="display:table-cell"><label>HP:</label></div>
			<div style="display:table-cell"><label id="break2HP"></label></div>
			<div style="display:table-cell"><label>ATK:</label></div>
			<div style="display:table-cell"><label id="break2ATK"></label></div>
			<div style="display:table-cell"><label>BLK:</label></div>
			<div style="display:table-cell"><label id="break2BLK"></label></div>
			<div style="display:table-cell"></div>
			<div style="display:table-cell"></div>
		</div>
		<div id="break3Stats" style="display:none;">
			<div style="display:table-cell"><label id="break3Name"></label></div>
			<div style="display:table-cell"><label>HP:</label></div>
			<div style="display:table-cell"><label id="break3HP"></label></div>
			<div style="display:table-cell"><label>ATK:</label></div>
			<div style="display:table-cell"><label id="break3ATK"></label></div>
			<div style="display:table-cell"><label>BLK:</label></div>
			<div style="display:table-cell"><label id="break3BLK"></label></div>
			<div style="display:table-cell"></div>
			<div style="display:table-cell"></div>
		</div>
		<div id="break4Stats" style="display:none;">
			<div style="display:table-cell"><label id="break4Name"></label></div>
			<div style="display:table-cell"><label>HP:</label></div>
			<div style="display:table-cell"><label id="break4HP"></label></div>
			<div style="display:table-cell"><label>ATK:</label></div>
			<div style="display:table-cell"><label id="break4ATK"></label></div>
			<div style="display:table-cell"><label>BLK:</label></div>
			<div style="display:table-cell"><label id="break4BLK"></label></div>
			<div style="display:table-cell"></div>
			<div style="display:table-cell"></div>
		</div>
		<div id="break5Stats" style="display:none;">
			<div style="display:table-cell"><label id="break5Name"></label></div>
			<div style="display:table-cell"><label>HP:</label></div>
			<div style="display:table-cell"><label id="break5HP"></label></div>
			<div style="display:table-cell"><label>ATK:</label></div>
			<div style="display:table-cell"><label id="break5ATK"></label></div>
			<div style="display:table-cell"><label>BLK:</label></div>
			<div style="display:table-cell"><label id="break5BLK"></label></div>
			<div style="display:table-cell"></div>
			<div style="display:table-cell"></div>
		</div>
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
		
		<script src="js/BBAnimation.js"></script>
		<script src="js/AnimationHandler.js"></script>
		<script src="js/KeyFrameAnimation.js"></script>
		<script src="js/ColladaLoader.js"></script>

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

		<script src="js/BBPlayer.js?version=1.01"></script>
		<script src="js/Detector.js"></script>
		<script src="js/stats.min.js"></script>

		<script>

			if ( ! Detector.webgl ) Detector.addGetWebGLMessage();

			var FOLLOW_CAMERA = false;
			var CAMERA_TARGET = 'faceoff';

			var SCREEN_WIDTH = window.innerWidth;
			var SCREEN_HEIGHT = window.innerHeight;

			var SHADOW_MAP_WIDTH = 1024, SHADOW_MAP_HEIGHT = 1024;

			var container, stats;

			var camera, cameraTarget, scene, renderer;
			var renderTarget;

			var spotLight, ambientLight;

			var cubeCamera;

			var clock;// = new THREE.Clock();

			var gameActive=false;
			var lastScoredTeam;
			var is3DMode=true;
			
			var controls = {
				moveForward: false,
				moveBackward: false,
				moveLeft: false,
				moveRight: false
			};

			var myLWControls = {
				moveForward: false,
				moveBackward: false,
				moveLeft: false,
				moveRight: false,
				restingPosition: new THREE.Vector3(2000, 0, -12000)
			};
			
			var myRWControls = {
				moveForward: false,
				moveBackward: false,
				moveLeft: false,
				moveRight: false,
				restingPosition: new THREE.Vector3(2000, 0, 12000)
			};
			
			var myMFControls = {
				moveForward: false,
				moveBackward: false,
				moveLeft: false,
				moveRight: false,
				restingPosition: new THREE.Vector3(6000, 0, 0)
			};
			
			var myLBControls = {
				moveForward: false,
				moveBackward: false,
				moveLeft: false,
				moveRight: false,
				restingPosition: new THREE.Vector3(12000, 0, -2000)
			};
			
			var myRBControls = {
				moveForward: false,
				moveBackward: false,
				moveLeft: false,
				moveRight: false,
				restingPosition: new THREE.Vector3(12000, 0, 2000)
			};
			
			var oppLWControls = {
				moveForward: false,
				moveBackward: false,
				moveLeft: false,
				moveRight: false,
				restingPosition: new THREE.Vector3(-2000, 0, 12000)
			};
			
			var oppRWControls = {
				moveForward: false,
				moveBackward: false,
				moveLeft: false,
				moveRight: false,
				restingPosition: new THREE.Vector3(-2000, 0, -12000)
			};
			
			var oppMFControls = {
				moveForward: false,
				moveBackward: false,
				moveLeft: false,
				moveRight: false,
				restingPosition: new THREE.Vector3(-6000, 0, 0)
			};
			
			var oppLBControls = {
				moveForward: false,
				moveBackward: false,
				moveLeft: false,
				moveRight: false,
				restingPosition: new THREE.Vector3(-12000, 0, 2000)
			};
			
			var oppRBControls = {
				moveForward: false,
				moveBackward: false,
				moveLeft: false,
				moveRight: false,
				restingPosition: new THREE.Vector3(-12000, 0, -2000)
			};

			var mlib;

			var gallardo, veyron, currentCar;
			var myTeamLW, myTeamRW, myTeamMF, myTeamLB, myTeamRB, myTeamGK;
			var oppTeamLW, oppTeamRW, oppTeamMF, oppTeamLB, oppTeamRB, oppTeamGK;
			var myTeam=[];
			var oppTeam=[];
			var ballLeftSide;

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

			var sphereRadius=24000;
			var ball;
			var goal1Loc=new THREE.Vector3( -20000, 0, 0 );
			var goal2Loc=new THREE.Vector3( 20000, 0, 0 );
			var ballTrajectory=null;
			var teamWithBall=1;
			var cameraOffset=new THREE.Vector3(0,0,5000);

			var currAction="main";
			var defendingPlayers = [];
			var techOptions=[];
			var targettedPlayer;

			//MINIMAP
			var mapCanvas;
			var mapContext;
			var ballPosition = new THREE.Vector3(0,0,0);
			
			init();
			animate();

			function shoot(){
				if (teamWithBall==1){
					ball.lookAt(goal1Loc);
					ballTrajectory=goal1Loc.clone().sub(currentCar.currentPosition);
					teamWithBall=2;
				} else{
					ball.lookAt(goal2Loc);
					ballTrajectory=goal2Loc.clone().sub(currentCar.currentPosition);
					teamWithBall=1;
				}
				ball.position.set(currentCar.currentPosition.x, currentCar.currentPosition.y, currentCar.currentPosition.z);
				CAMERA_TARGET='shotball';
			}
			var currAnimation="tread";
			var currStat;
			var ballMoveIteration;

			function pass(){
				currAction="animPass";
				currentPlayer.lookAt(targettedPlayer.currentPosition);
				if (targettedPlayer.currentPosition.x<currentPlayer.currentPosition.x){
					camera.position.x=currentPlayer.currentPosition.x-7;
				} else {
					camera.position.x=currentPlayer.currentPosition.x+7;
				}
				camera.position.y=0;
				camera.position.z=currentPlayer.currentPosition.z+7;
				cameraTarget.set(currentPlayer.currentPosition.x, 0, currentPlayer.currentPosition.z);
				currentPlayer.animatePass(animatePassBlock);
				currStat=currentCar.pass;
				//ballTrajectory=targettedPlayer.currentPosition.clone().sub(currentCar.currentPosition);
				//ballPosition.set(currentCar.currentPosition.x, currentCar.currentPosition.y, currentCar.currentPosition.z);
				//if (is3DMode){
					//ball.position=ballPosition;
				//} else {
					//currStat=currentCar.pass;
					//animatePassBlock();
				//}
				//currentCar=destination;
			}

			function passBlockInterim(){
				}

			function animatePassBlock(){
				if (defendingPlayers==null||defendingPlayers.length==0){
					currAaction="passedBall";
					ballMoveIteration=0;
				} else {
					currAction="blockPass";
					/*animatingPlayer=defendingPlayers[0];
					currStat = currStat-((.5+Math.random())*defendingPlayers[0].block);
					defendingPlayers.shift();
					setTimeout(animatePassBlock, '1500');*/
					animatingPlayer=defendingPlayers.shift();
					currStat = currStat-Math.round((.5+Math.random())*defendingPlayers[0].block);
					if (currStat>0){
						animatingPlayer.animateBlockFail(passBlockInterim);
					} else {
						animatingPlayer.animateGrabBall(resumeActiveGame)
					}
				}
			}

			function testPass(){
				if (currentCar==gallardo){
					pass(veyron);
				} else {
					pass(gallardo);
				}
			}

			function updateCurrentPlayer(player){
				if (currentCar!=null){
					currentCar.hasBall=false;
				}
				currentCar=player;
				document.getElementById('playerName').innerHTML=player.name;
				document.getElementById('playerHP').innerHTML=player.hp;
				document.getElementById('playerEND').innerHTML=player.endurance;
				document.getElementById('playerPAS').innerHTML=player.pass;
				document.getElementById('playerSHT').innerHTML=player.shot;
				document.getElementById('break1Stats').style.display='none';
				document.getElementById('break2Stats').style.display='none';
				document.getElementById('break3Stats').style.display='none';
				document.getElementById('break4Stats').style.display='none';
				document.getElementById('break5Stats').style.display='none';
				currentCar.hasBall=true;
			}

			function init(team1, team2) {

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

				//createScene();
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
				var shader = THREE.ShaderLib[ "cube" ];
				shader.uniforms[ "tCube" ].value = textureCube;

				var material = new THREE.ShaderMaterial( {

					fragmentShader: shader.fragmentShader,
					vertexShader: shader.vertexShader,
					uniforms: shader.uniforms,
					side: THREE.DoubleSide

				} ),
				 
				// LIGHTS

				//ambientLight = new THREE.AmbientLight( 0x555555 );
				ambientLight = new THREE.AmbientLight( 0xffffff );
				scene.add(ambientLight);

				/*spotLight = new THREE.SpotLight( 0xffffff, 1, 0, Math.PI/2, 1 );
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

				scene.add( spotLight );*/

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

				// STATS

				stats = new Stats();
				container.appendChild( stats.domElement );

				// CUBE CAMERA

				cubeCamera = new THREE.CubeCamera( 1, 100000, 128 );
				scene.add( cubeCamera );

				// MATERIALS

				if (is3DMode){
					var cubeTarget = cubeCamera.renderTarget;

					/*mlib = {

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
					*/
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
					scene.add( mesh );

					var ballGeometry = new THREE.SphereGeometry( sphereRadius/500, 8, 8 );
					var ballTexture = THREE.ImageUtils.loadTexture("img/blitzball/ball.png");
					ballTexture.wrapS = ballTexture.wrapT = THREE.ClampToEdgeWrapping;
					//ballTexture.repeat.set( 32, 32 );
					var ballMaterial = new THREE.MeshBasicMaterial( { map: ballTexture } );
					ball = new THREE.Mesh( ballGeometry, ballMaterial );
					scene.add(ball);
				}
				var myTeamJSON=JSON.parse('${myTeam}');
				var oppTeamJSON=JSON.parse('${myTeam}');
								
				// CARS - VEYRON
				myTeamLW = new THREE.BBPlayer(myTeamJSON.leftWing, new THREE.Vector3(3000, 0, -12000), is3DMode);
				myTeamRW = new THREE.BBPlayer(myTeamJSON.rightWing, new THREE.Vector3(3000, 0, 12000), is3DMode);
				myTeamMF = new THREE.BBPlayer(myTeamJSON.midfielder, new THREE.Vector3(7000, 0, 0), is3DMode);
				myTeamLB = new THREE.BBPlayer(myTeamJSON.leftBack, new THREE.Vector3(14000, 0, -4500), is3DMode);
				myTeamRB = new THREE.BBPlayer(myTeamJSON.rightBack, new THREE.Vector3(14000, 0, 4500), is3DMode);
				myTeamGK = new THREE.BBPlayer(myTeamJSON.keeper, new THREE.Vector3(19000, 0, 0), is3DMode);
				myTeam.push(myTeamLW);
				myTeam.push(myTeamRW);
				myTeam.push(myTeamMF);
				myTeam.push(myTeamLB);
				myTeam.push(myTeamRB);
				//myTeam.push(myTeamGK);
				oppTeamLW = new THREE.BBPlayer(oppTeamJSON.leftWing, new THREE.Vector3(-3000, 0, 12000), is3DMode);
				oppTeamRW = new THREE.BBPlayer(oppTeamJSON.rightWing, new THREE.Vector3(-3000, 0, -12000), is3DMode);
				oppTeamMF = new THREE.BBPlayer(oppTeamJSON.midfielder, new THREE.Vector3(-7000, 0, 0), is3DMode);
				oppTeamLB = new THREE.BBPlayer(oppTeamJSON.leftBack, new THREE.Vector3(-14000, 0, 4500), is3DMode);
				oppTeamRB = new THREE.BBPlayer(oppTeamJSON.rightBack, new THREE.Vector3(-14000, 0, -4500), is3DMode);
				oppTeamGK = new THREE.BBPlayer(oppTeamJSON.keeper, new THREE.Vector3(-19000, 0, 0), is3DMode);
				oppTeam.push(oppTeamLW);
				oppTeam.push(oppTeamRW);
				oppTeam.push(oppTeamMF);
				oppTeam.push(oppTeamLB);
				oppTeam.push(oppTeamRB);
				//oppTeam.push(oppTeamGK);

				if (is3DMode){
					myTeamLW.loadPlayer(function(){addPlayer(myTeamLW);});
					myTeamRW.loadPlayer(function(){addPlayer(myTeamRW);});
					myTeamMF.loadPlayer(function(){addPlayer(myTeamMF);});
					myTeamLB.loadPlayer(function(){addPlayer(myTeamLB);});
					myTeamRB.loadPlayer(function(){addPlayer(myTeamRB);});
					myTeamGK.loadPlayer(function(){addPlayer(myTeamGK);});
					oppTeamLW.loadPlayer(function(){addPlayer(oppTeamLW);});
					oppTeamRW.loadPlayer(function(){addPlayer(oppTeamRW);});
					oppTeamMF.loadPlayer(function(){addPlayer(oppTeamMF);});
					oppTeamLB.loadPlayer(function(){addPlayer(oppTeamLB);});
					oppTeamRB.loadPlayer(function(){addPlayer(oppTeamRB);});
					oppTeamGK.loadPlayer(function(){addPlayer(oppTeamGK);});
					/*myTeamLW.modelScale = 3;
					myTeamLW.backWheelOffset = 2;
					myTeamLW.callback = function( object ) {
						addCar( object, 2000, 0, -12000, 0 );
						setMaterialsVeyron( object );
					};
					//myTeamLW.loadPartsBinary( "js/veyron_body_bin.js", "js/veyron_wheel_bin.js" );
					myTeamRW.modelScale = 3;
					myTeamRW.backWheelOffset = 2;
					myTeamRW.callback = function( object ) {
						addCar( object, 2000, 0, 12000, 0 );
						setMaterialsVeyron( object );
					};
					//myTeamRW.loadPartsBinary( "js/veyron_body_bin.js", "js/veyron_wheel_bin.js" );
					myTeamMF.modelScale = 3;
					myTeamMF.backWheelOffset = 2;
					myTeamMF.callback = function( object ) {
						addCar( object, 6000, 0, 0, 0 );
						setMaterialsVeyron( object );
					};
					//myTeamMF.loadPartsBinary( "js/veyron_body_bin.js", "js/veyron_wheel_bin.js" );
					myTeamLB.modelScale = 3;
					myTeamLB.backWheelOffset = 2;
					myTeamLB.callback = function( object ) {
						addCar( object, 12000, 0, -2000, 0 );
						setMaterialsVeyron( object );
					};
					//myTeamLB.loadPartsBinary( "js/veyron_body_bin.js", "js/veyron_wheel_bin.js" );
					myTeamRB.modelScale = 3;
					myTeamRB.backWheelOffset = 2;
					myTeamRB.callback = function( object ) {
						addCar( object, 12000, 0, -2000, 0 );
						setMaterialsVeyron( object );
					};
					//myTeamRB.loadPartsBinary( "js/veyron_body_bin.js", "js/veyron_wheel_bin.js" );
					myTeamGK.modelScale = 3;
					myTeamGK.backWheelOffset = 2;
					myTeamGK.callback = function( object ) {
						addCar( object, 19000, 0, 0, 0 );
						setMaterialsVeyron( object );
					};
					//myTeamGK.loadPartsBinary( "js/veyron_body_bin.js", "js/veyron_wheel_bin.js" );

					// CARS - GALLARDO

					oppTeamLW.modelScale = 2;
					oppTeamLW.backWheelOffset = 45;
					oppTeamLW.callback = function( object ) {
						addCar( object, -2000, 0, -12000, 0 );
						setMaterialsGallardo( object );
					};
					//oppTeamLW.loadPartsBinary( "js/gallardo_body_bin.js", "js/gallardo_wheel_bin.js" );
					oppTeamRW.modelScale = 2;
					oppTeamRW.backWheelOffset = 45;
					oppTeamRW.callback = function( object ) {
						addCar( object, -2000, 0, 12000, 0 );
						setMaterialsGallardo( object );
					};
					//oppTeamRW.loadPartsBinary( "js/gallardo_body_bin.js", "js/gallardo_wheel_bin.js" );
					oppTeamMF.modelScale = 2;
					oppTeamMF.backWheelOffset = 45;
					oppTeamMF.callback = function( object ) {
						addCar( object, -6000, 0, 0, 0 );
						setMaterialsGallardo( object );
					};
					//oppTeamMF.loadPartsBinary( "js/gallardo_body_bin.js", "js/gallardo_wheel_bin.js" );
					oppTeamLB.modelScale = 2;
					oppTeamLB.backWheelOffset = 45;
					oppTeamLB.callback = function( object ) {
						addCar( object, -12000, 0, 2000, 0 );
						setMaterialsGallardo( object );
					};
					//oppTeamLB.loadPartsBinary( "js/gallardo_body_bin.js", "js/gallardo_wheel_bin.js" );
					oppTeamRB.modelScale = 2;
					oppTeamRB.backWheelOffset = 45;
					oppTeamRB.callback = function( object ) {
						addCar( object, -12000, 0, -2000, 0 );
						setMaterialsGallardo( object );
					};
					//oppTeamRB.loadPartsBinary( "js/gallardo_body_bin.js", "js/gallardo_wheel_bin.js" );
					oppTeamGK.modelScale = 2;
					oppTeamGK.backWheelOffset = 45;
					oppTeamGK.callback = function( object ) {
						addCar( object, -19000, 0, 0, 0 );
						setMaterialsGallardo( object );
					};
					//oppTeamGK.loadPartsBinary( "js/gallardo_body_bin.js", "js/gallardo_wheel_bin.js" );*/
				}
				//

				config[ "gallardo" ].model = oppTeamMF;
				config[ "veyron" ].model = myTeamMF;

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

				effectFXAA = new THREE.ShaderPass( THREE.FXAAShader );
				var effectVignette = new THREE.ShaderPass( THREE.VignetteShader );

				effectFXAA.uniforms[ 'resolution' ].value.set( 1 / SCREEN_WIDTH, 1 / SCREEN_HEIGHT );

				var bluriness = 2;

				effectVignette.uniforms[ "offset" ].value = 0.5;
				effectVignette.uniforms[ "darkness" ].value = 0.2;

				var renderModel = new THREE.RenderPass( scene, camera );

				effectVignette.renderToScreen = true;

				composer = new THREE.EffectComposer( renderer, renderTarget );

				composer.addPass( renderModel );

				composer.addPass( effectFXAA );

				composer.addPass( effectVignette );

				faceOff();
			}

			function faceOff(){
				if (lastScoredTeam==null){
					if (Math.random()<1){
						updateCurrentPlayer(myTeamMF);
						ballLeftSide=true;//opposite, so resting positions will be calculated
						teamWithBall=1;
					} else {
						updateCurrentPlayer(oppTeamMF);
						ballLeftSide=false;
						teamWithBall=2;
					}
				} else if (lastScoredTeam==1){
					updateCurrentPlayer(oppTeamMF);
					ballLeftSide=false;
					teamWithBall=2;
				} else {
					updateCurrentPlayer(myTeamMF);
					ballLeftSide=true;
					teamWithBall=1;
				}
				//gameActive=true;
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
			var loadedCount=0;
			function addPlayer(object){
				//object.root.position.set(object.currentPosition.x, object.currentPosition.y, object.currentPosition.z);
				//object.root.position=object.currentPosition;
				scene.add( object.dae );

				loadedCount++;
				if (loadedCount>=12){
					gameActive=true;
					clock = new THREE.Clock()
				}

				if (loadedCount==1){

					object.root.add( camera );

					camera.position.set( 350, 500, 2200 );
					//camera.position.set( 0, 3000, -500 );

					cameraTarget.z = 500;
					cameraTarget.y = 150;

					camera.lookAt( cameraTarget );
				}
			}

			function addCar( object, x, y, z, s ) {

				object.currentPosition.set( x, y, z );
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

					//camera.position.set( 2000, 0, 2000 );
					cameraOffset=new THREE.Vector3(0,0,5000);
					var newPosition=currentCar.currentPosition.clone().add(cameraOffset);
					camera.position.set(newPosition.x, newPosition.y, newPosition.z);
					cameraTarget.set( 0, 0, 0 );

					//spotLight.position.set( 0, 1800, 1500 );

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

				effectFXAA.uniforms[ 'resolution' ].value.set( 1 / SCREEN_WIDTH, 1 / SCREEN_HEIGHT );

			}

			//
			
			function downButtonPressed(){
				if (gameActive&&teamWithBall==1){
					controls.moveBackward = true;
				} else if (!gameActive&&teamWithBall==1){
					if (menuSelection>=MAXITEMS){
						menuSelection=1;
					} else {
						menuSelection++;
					}
					document.getElementById('selector').style.top=(menuSelection-1)*4+'vmin';
				}
			}
			
			function upButtonPressed(){
				if (gameActive&&teamWithBall==1){
					controls.moveForward = true;
				} else if (!gameActive&&teamWithBall==1){
					if (menuSelection<=1){
						menuSelection=MAXITEMS;
					} else {
						menuSelection--;
					}
					document.getElementById('selector').style.top=(menuSelection-1)*4+'vmin';
				}
			}

			function rightButtonPressed(){
				if (gameActive&&teamWithBall==1){
					controls.moveRight = true;
				}
			}

			function leftButtonPressed(){
				if (gameActive&&teamWithBall==1){
					controls.moveLeft = true;
				}
			}

			function clearMenu(){
				document.getElementById('menu1').innerHTML='';
				document.getElementById('menu2').innerHTML='';
				document.getElementById('menu3').innerHTML='';
				document.getElementById('menu4').innerHTML='';
				document.getElementById('menu5').innerHTML='';
				document.getElementById('menu3').style.display='none';
				document.getElementById('menu4').style.display='none';
				document.getElementById('menu5').style.display='none';
				menuSelection=1;
				document.getElementById('selector').style.top=(menuSelection-1)*4+'vmin';
			}

			function updateActiveNumbers(){
				var change=Math.round(currStat/5);
				currStat-=change;
				if (currAnimation=="shotBall"){
					document.getElementById('playerSHT').innerHTML=currStat;
				} else if (currAnimation=="passedBall"){
					document.getElementById('playerPAS').innerHTML=currStat;
				}
			}
			var team1Score=0;
			var team2Score=0;

			function onBallArrive(){
				if (currAnimation=="shotBall"){
					var keeper;
					if (teamWithBall==1){
						keeper=oppTeamGK;
					} else {
						keeper=myTeamGK;
					}
					var goalNum=Math.round(currStat-((.5+Math.random())*keeper.cat));
					if (teamWithBall==1){
						if (goalNum>0){
							team1Score++;
							lastScoredTeam=1;
							faceOff();
						} else {
							goalNum=0;
							teamWithBall=2;
							updateCurrentPlayer(oppTeam[Math.ceil(Math.random()*5)]);
							gameActive=true;
						}
					} else {
						if (goalNum>0){
							team2Score++;
							lastScoredTeam=2;
							faceOff();
						} else {
							goalNum=0;
							teamWithBall=1;
							updateCurrentPlayer(oppTeam[Math.ceil(Math.random()*5)]);
							gameActive=true;
						}
					}
				} else if (currAnimation=="passedBall"){
					if (currStat>0){
						currAnimation="none";
						updateCurrentPlayer(targettedPlayer);
						targettedPlayer=null;
						currStat=0;
						gameActive=true;
					} else {
						var currReceiver;
						var minDistance=50000;
						for (var i=0; i<myTeam.length; i++){
							if (myTeam[i]!=targettedPlayer){
								if (myTeam[i].currentPosition.distanceTo(targettedPlayer.currentPosition)<minDistance){
									currReceiver=myTeam[i];
									minDistance=myTeam[i].currentPosition.distanceTo(targettedPlayer.currentPosition);
								}
							}
						}
						for (var i=0; i<oppTeam.length; i++){
							if (oppTeam[i].currentPosition.distanceTo(targettedPlayer.currentPosition)<minDistance){
								currReceiver=oppTeam[i];
								minDistance=oppTeam[i].currentPosition.distanceTo(targettedPlayer.currentPosition);
							}
						}
						currAnimation="none";
						updateCurrentPlayer(currReceiver);
						targettedPlayer=null;
						currStat=0;
						if (teamWithBall==1){
							teamWithBall==2;
						} else {
							teamWithBall==1;
						}
						gameActive=true;
					}
				}
			}
			
			function showBreakMenu(){
				if (defendingPlayers!=null&&defendingPlayers.length>0){
					clearMenu();
					MAXITEMS=1;
					for (var i=0; i<defendingPlayers.length; i++){
						document.getElementById('menu'+(i+1)).style.display='';
						document.getElementById('menu'+(i+1)).innerHTML='Break to '+defendingPlayers[i].name;
						document.getElementById('break'+(i+1)+'Name').innerHTML=defendingPlayers[i].name;
						document.getElementById('break'+(i+1)+'HP').innerHTML=defendingPlayers[i].hp;
						document.getElementById('break'+(i+1)+'ATK').innerHTML=defendingPlayers[i].attack;
						document.getElementById('break'+(i+1)+'BLK').innerHTML=defendingPlayers[i].block;
						document.getElementById('break'+(i+1)+'Stats').style.display='table-row';
						MAXITEMS++;
					}
					document.getElementById('menu'+MAXITEMS).style.display='';
					document.getElementById('menu'+MAXITEMS).innerHTML='No Break';
					currAction="break";
					document.getElementById('actionMenu').style.height=(MAXITEMS*4)+'vmin';
					document.getElementById('actionMenu').style.display='';
				} else {
					showMainActionMenu();
				}
			}

			function showMainActionMenu(){
				clearMenu();
				document.getElementById('menu1').innerHTML='Pass';
				document.getElementById('menu2').innerHTML='Shoot';
				if (defendingPlayers.length>0){
					document.getElementById('menu3').style.display='none';
					MAXITEMS=2;
				} else {
					document.getElementById('menu3').style.display='';
					document.getElementById('menu3').innerHTML='Dribble';
					MAXITEMS=3;
				}
				currAction="main";
				document.getElementById('actionMenu').style.display='';
				document.getElementById('actionMenu').style.height=(MAXITEMS*4)+'vmin';
			}

			function animateBreak(numLeft){
				if (numLeft>0){
					if (defendingPlayers!=null&&defendingPlayers.length>=numLeft){
						console.log('invalid number of break attempts: ' + numLeft);
						showMainActionMenu();
					}
					var player=defendingPlayers.shift();
					var currEnd = Number(document.getElementById('playerEND').innerHTML);
					currEnd-=Math.round((.5+Math.random())*player.attack);
					if (currEnd<0){
						currEnd=0;
						document.getElementById('playerEND').innerHTML=currEnd;
						setTimeout(function(){
							if (teamWithBall==1){
								teamWithBall=2;
							} else {
								teamWithBall=1;
							}
							updateCurrentPlayer(player);
							gameActive=true;
							currAction="none";
						}, '1500');
					} else {
						document.getElementById('playerEND').innerHTML=currEnd;
						setTimeout(function(){
							animateBreak(numLeft-1);
						}, '1500');
					}
				} else {
					showMainActionMenu();
				}
			}
			
			function selectButtonPressed(){
				if (gameActive&&teamWithBall==1){
					controls.moveForward=false;
					controls.moveBackward=false;
					controls.moveLeft=false;
					controls.moveRight=false;
					defendingPlayers = [];
					for (var i=0; i<oppTeam.length; i++){
						if (oppTeam[i].currentPosition.distanceTo(currentCar.currentPosition)<1000){
							defendingPlayers.push(oppTeam[i]);
						}
					}
					defendingPlayers.sort(function(a,b) {return (b.attack > a.attack) ? 1 : ((a.attack > b.attack) ? -1 : 0);});
					gameActive=false;
					showBreakMenu();
				} else if (!gameActive&&currAction=="break"){
					if (menuSelection==MAXITEMS){
						showMainActionMenu();
					} else {
						animateBreak(menuSelection);
					}
				} else if (!gameActive&&currAction=="main"){
					if (menuSelection==1){
						techOptions=[];
						for (var i=0; i<currentCar.techs.length; i++){
							if (currentCar.techs[i].techType=="pass"){
								techOptions.push(currentCar.techs[i]);
							}
						}
						document.getElementById('actionMenu').style.height=((techOptions+2)*4)+"vmin";
						for (var i=0; i<techOptions.length; i++){
							document.getElementById('menu'+(i+2)).style.display='';
							document.getElementById('menu'+(i+2)).innerHTML=techOptions[i].techName;
						}
						document.getElementById('menu1').innerHTML='Normal Pass';
						document.getElementById('menu'+(techOptions.length+2)).innerHTML='Back';
						currAction="pass";
					} else if (menuSelection==2){
						techOptions=[];
						for (var i=0; i<currentCar.techs.length; i++){
							if (currentCar.techs[i].techType=="shot"){
								techOptions.push(currentCar.techs[i]);
							}
						}
						document.getElementById('actionMenu').style.height=((techOptions+2)*4)+"vmin";
						for (var i=0; i<techOptions.length; i++){
							document.getElementById('menu'+(i+2)).style.display='';
							document.getElementById('menu'+(i+2)).innerHTML=techOptions[i].techName;
						}
						document.getElementById('menu1').innerHTML='Normal Shot';
						document.getElementById('menu'+(techOptions.length+2)).innerHTML='Back';
						currAction="shoot";
					} else if (menuSelection==3){
						document.getElementById('actionMenu').style.display='none';
						currAction="none";
						updateCurrentPlayer(currentCar);
						gameActive=true;
					}
				} else if (!gameActive&&currAction=="pass"){
					if (menuSelection==MAXITEMS){
						showMainActionMenu();
					} else {
						if (menuSelection>1){
							selectedTech=techOptions[menuSelection-1];
						}
						var j=0;
						for (var i=0; i<myTeam.length; i++){
							if (myTeam[i]!=currentCar){
								j++;
								document.getElementById('menu'+j).style.display='';
								document.getElementById('menu'+j).innerHTML=myTeam[i].name;
							}
						}
						MAXITEMS=4;
						document.getElementById('actionMenu').style.height=(MAXITEMS*4)+'vmin';
						currAction="targetting";
					}
				} else if (!gameActive&&currAction=="targetting"){
					var j=0;
					for (var i=0; i<myTeam.length; i++){
						if (myTeam[i]!=currentCar){
							j++;
							if (j==menuSelection){
								targettedPlayer=myTeam[i];
								break;
							}
						}
					}
					pass();
				} else if (!gameActive&&currAction=="shoot"){
					if (menuSelection==MAXITEMS){
						showMainActionMenu();
					} else {
						if (menuSelection>1){
							selectedTech=techOptions[menuSelection-1];
						}
						shoot();
					}
				}
			}

			function onKeyDown (event) {
				//if (gameActive&&teamWithBall==1){
					if (event.keyCode==40){
						event.preventDefault();
						downButtonPressed();
					} else if (event.keyCode==38){
						event.preventDefault();
						upButtonPressed();
					} else if (event.keyCode==37){
						event.preventDefault();
						leftButtonPressed();
					} else if (event.keyCode==39){
						event.preventDefault();
						rightButtonPressed();
					} else if (event.keyCode==90){
						event.preventDefault();
						selectButtonPressed();
					} else if (event.keyCode==88){
						event.preventDefault();
						cancelButtonPressed();
					} else if (event.keyCode==87){
						event.preventDefault();
						
					}
					switch(event.keyCode) {
						case 49: /*1*/	setCurrentCar( "gallardo", "center" ); break;
						case 50: /*2*/	setCurrentCar( "veyron", "center" ); break;
						case 51: /*3*/	setCurrentCar( "gallardo", "front" ); break;
						case 52: /*4*/	setCurrentCar( "veyron", "front" ); break;
						case 53: /*5*/	setCurrentCar( "gallardo", "back" ); break;
						case 54: /*6*/	setCurrentCar( "veyron", "back" ); break;

						case 78: /*N*/   testPass(); break;

						case 66: /*B*/   shoot(); break;
						
					}
				//}
			}

			function onKeyUp (event) {
				if (gameActive&&teamWithBall==1){
					switch(event.keyCode) {
						case 38: /*up*/controls.moveForward = false; break;
						case 40: /*down*/controls.moveBackward = false; break;
						case 37: /*left*/controls.moveLeft = false; break;
						case 39: /*right*/controls.moveRight = false; break;
					}
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

			function updateAIControls(){
				if (gameActive&&teamWithBall==2){//AI has ball
					if (currentCar.position.x<0){
						if (Math.random()<.05){
							
						}
					}
					if (currentCar==oppTeamLW){
						controls.moveRight=true;
					}
				}
			}

			function updateMinimap(){
				//reset canvas
				mapContext.beginPath();
				mapContext.arc(mapCanvas.width/2, mapCanvas.width/2, mapCanvas.width/2, 0, 2 * Math.PI, false);
				mapContext.closePath();
				mapContext.fillStyle = 'blue';
				mapContext.fill();

				//yellow team
				for (var i=0; i<myTeam.length; i++){
					var rot=myTeam[i].currentRotation+Math.PI;
					var x1=mapCanvas.width*(20000+myTeam[i].currentPosition.x)/40000-Math.cos(rot)*mapCanvas.width/10;
					var y1=mapCanvas.width*(20000+myTeam[i].currentPosition.z)/40000-Math.sin(rot)*mapCanvas.width/10;
					var x2=x1+Math.cos(rot-Math.PI/12)*(mapCanvas.width/10);
					var y2=y1+Math.sin(rot-Math.PI/12)*(mapCanvas.width/10);
					var x3=x1+Math.cos(rot+Math.PI/12)*(mapCanvas.width/10);
					var y3=y1+Math.sin(rot+Math.PI/12)*(mapCanvas.width/10);
					mapContext.beginPath();
					mapContext.moveTo(x1, mapCanvas.width-y1);
					mapContext.lineTo(x2, mapCanvas.width-y2);
					mapContext.lineTo(x3, mapCanvas.width-y3);
					mapContext.lineTo(x1, mapCanvas.width-y1);
					mapContext.closePath();
					mapContext.stroke();
					mapContext.fillStyle = "#FFCC00";
					mapContext.fill();
				}

				//red team
				for (var i=0; i<oppTeam.length; i++){
					var rot=oppTeam[i].currentRotation+Math.PI;
					var x1=mapCanvas.width*(20000+oppTeam[i].currentPosition.x)/40000-Math.cos(rot)*mapCanvas.width/10;
					var y1=mapCanvas.width*(20000+oppTeam[i].currentPosition.z)/40000-Math.sin(rot)*mapCanvas.width/10;
					var x2=x1+Math.cos(rot-Math.PI/12)*(mapCanvas.width/10);
					var y2=y1+Math.sin(rot-Math.PI/12)*(mapCanvas.width/10);
					var x3=x1+Math.cos(rot+Math.PI/12)*(mapCanvas.width/10);
					var y3=y1+Math.sin(rot+Math.PI/12)*(mapCanvas.width/10);
					mapContext.beginPath();
					mapContext.moveTo(x1, mapCanvas.width-y1);
					mapContext.lineTo(x2, mapCanvas.width-y2);
					mapContext.lineTo(x3, mapCanvas.width-y3);
					mapContext.lineTo(x1, mapCanvas.width-y1);
					mapContext.closePath();
					//mapContext.arc(mapCanvas.width*(20000+oppTeam[i].currentPosition.x)/40000, mapCanvas.width*(20000+oppTeam[i].currentPosition.z)/40000, mapCanvas.width/40, 0, 2 * Math.PI, false);
					mapContext.stroke();
					mapContext.fillStyle = "#FF0000";
					mapContext.fill();
				}

				if (currAnimation=="passedBall"||currAnimation=="shotBall"){
					mapContext.beginPath();
					mapContext.arc(mapCanvas.width*(20000+ballPosition.x)/40000, mapCanvas.width*(20000-ballPosition.z)/40000, mapCanvas.width/50, 0, 2 * Math.PI, false);
					mapContext.closePath();
					mapContext.fillStyle = 'white';
					mapContext.fill();
				}
			}

			function computeRestingPositions(){
				if (!ballLeftSide&&currentCar.currentPosition.x<0){
					ballLeftSide=true;
					myTeamLW.restingPosition.x=-12000;
					myTeamLW.restingPosition.z=-2000;
					myTeamRW.restingPosition.x=-12000;
					myTeamRW.restingPosition.z=2000;
					myTeamMF.restingPosition.x=-6000;
					myTeamMF.restingPosition.z=0;
					myTeamLB.restingPosition.x=2000;
					myTeamLB.restingPosition.z=-2000;
					myTeamRB.restingPosition.x=2000;
					myTeamRB.restingPosition.z=2000;
					oppTeamLW.restingPosition.x=-2000;
					oppTeamLW.restingPosition.z=-2000;
					oppTeamRW.restingPosition.x=-2000;
					oppTeamRW.restingPosition.z=2000;
					oppTeamMF.restingPosition.x=-6000;
					oppTeamMF.restingPosition.z=0;
					oppTeamLB.restingPosition.x=-12000;
					oppTeamLB.restingPosition.z=2000;
					oppTeamRB.restingPosition.x=-12000;
					oppTeamRB.restingPosition.z=-2000;
				} else if (ballLeftSide&&currentCar.currentPosition.x>0){
					ballLeftSide=false;
					myTeamLW.restingPosition.x=12000;
					myTeamLW.restingPosition.z=2000;
					myTeamRW.restingPosition.x=12000;
					myTeamRW.restingPosition.z=-2000;
					myTeamMF.restingPosition.x=6000;
					myTeamMF.restingPosition.z=0;
					myTeamLB.restingPosition.x=-2000;
					myTeamLB.restingPosition.z=2000;
					myTeamRB.restingPosition.x=-2000;
					myTeamRB.restingPosition.z=-2000;
					oppTeamLW.restingPosition.x=2000;
					oppTeamLW.restingPosition.z=-2000;
					oppTeamRW.restingPosition.x=2000;
					oppTeamRW.restingPosition.z=2000;
					oppTeamMF.restingPosition.x=6000;
					oppTeamMF.restingPosition.z=0;
					oppTeamLB.restingPosition.x=12000;
					oppTeamLB.restingPosition.z=-2000;
					oppTeamRB.restingPosition.x=12000;
					oppTeamRB.restingPosition.z=2000;
				}
				if (teamWithBall==1){
					if (oppTeamLW.currentPosition.distanceTo(currentCar.currentPosition)<6000){
						oppTeamLW.restingPosition.x=currentCar.currentPosition.clone().x;
						oppTeamLW.restingPosition.z=currentCar.currentPosition.clone().z;
					}
					if (oppTeamRW.currentPosition.distanceTo(currentCar.currentPosition)<6000){
						oppTeamRW.restingPosition.x=currentCar.currentPosition.clone().x;
						oppTeamRW.restingPosition.z=currentCar.currentPosition.clone().z;
					}
					if (oppTeamMF.currentPosition.distanceTo(currentCar.currentPosition)<6000){
						oppTeamMF.restingPosition.x=currentCar.currentPosition.clone().x;
						oppTeamMF.restingPosition.z=currentCar.currentPosition.clone().z;
					}
					if (oppTeamLB.currentPosition.distanceTo(currentCar.currentPosition)<6000){
						oppTeamLB.restingPosition.x=currentCar.currentPosition.clone().x;
						oppTeamLB.restingPosition.z=currentCar.currentPosition.clone().z;
					}
					if (oppTeamRB.currentPosition.distanceTo(currentCar.currentPosition)<6000){
						oppTeamRB.restingPosition.x=currentCar.currentPosition.clone().x;
						oppTeamRB.restingPosition.z=currentCar.currentPosition.clone().z;
					}
				} else if (teamWithBall==2){
					if (myTeamLW.currentPosition.distanceTo(currentCar.currentPosition)<6000){
						myTeamLW.restingPosition.x=currentCar.currentPosition.clone().x;
						myTeamLW.restingPosition.z=currentCar.currentPosition.clone().z;
					}
					if (myTeamRW.currentPosition.distanceTo(currentCar.currentPosition)<6000){
						myTeamRW.restingPosition.x=currentCar.currentPosition.clone().x;
						myTeamRW.restingPosition.z=currentCar.currentPosition.clone().z;
					}
					if (myTeamMF.currentPosition.distanceTo(currentCar.currentPosition)<6000){
						myTeamMF.restingPosition.x=currentCar.currentPosition.clone().x;
						myTeamMF.restingPosition.z=currentCar.currentPosition.clone().z;
					}
					if (myTeamLB.currentPosition.distanceTo(currentCar.currentPosition)<6000){
						myTeamLB.restingPosition.x=currentCar.currentPosition.clone().x;
						myTeamLB.restingPosition.z=currentCar.currentPosition.clone().z;
					}
					if (myTeamRB.currentPosition.distanceTo(currentCar.currentPosition)<6000){
						myTeamRB.restingPosition.x=currentCar.currentPosition.clone().x;
						myTeamRB.restingPosition.z=currentCar.currentPosition.clone().z;
					}
				}
			}


			function render() {
				if (clock!=null){//otherwise game hasn't fully loaded yet
				var delta = clock.getDelta();
				if (gameActive){
					computeRestingPositions();

					for (var i=0; i<myTeam.length; i++){
						myTeam[i].updatePlayer(delta, controls);
					}
					for (var i=0; i<oppTeam.length; i++){
						oppTeam[i].updatePlayer(delta, controls);
					}
				} else {
					if (ballTrajectory!=null){
						var maxBallMove=5000*delta;
						var lengthLeft=ballTrajectory.length();
						if (maxBallMove>=lengthLeft){
							ballPosition.addVectors(ballPosition, ballTrajectory);
							if (is3DMode){
								ball.position.addVectors(ball.position, ballTrajectory);
							}
							ballMoveIteration+=ballTrajectory.length();
							ballTrajectory=null;
							if (ballMoveIteration>=5000){
								updateActiveNumbers();
							}
							ballMoveIteration=0;
							onBallArrive();
						} else {
							var scale = maxBallMove/lengthLeft;
							var mv = ballTrajectory.clone().multiplyScalar(scale);
							ballMoveIteration+=mv.length();
							if (ballMoveIteration>=5000){
								updateActiveNumbers();
								ballMoveIteration=ballMoveIteration-5000;
							}
							ballPosition.addVectors(ballPosition, mv);
							if (is3DMode){
								ball.position.addVectors(ball.position, mv);
							}
							ballTrajectory.sub(mv);
						}
					}
				}

				if (is3DMode){
					if (ballTrajectory!=null){
						var maxBallMove=5000*delta;
						var lengthLeft=ballTrajectory.length();
						if (maxBallMove>=lengthLeft){
							ball.position.addVectors(ball.position, ballTrajectory);
							ballTrajectory=null;
							if (CAMERA_TARGET=='shotball'){
								
							}
						} else {
							var scale = maxBallMove/lengthLeft;
							var mv = ballTrajectory.clone().multiplyScalar(scale);
							ball.position.addVectors(ball.position, mv);
							ballTrajectory.sub(mv);
						}
					}
				}

				/*for (var i=0; i<myTeam.length; i++){
					if ( myTeam[i].loaded ) {
						myTeam[i].bodyMaterials[ 1 ] = mlib[ "Chrome" ];
						myTeam[i].bodyMaterials[ 2 ] = mlib[ "Chrome" ];
						myTeam[i].wheelMaterials[ 0 ] = mlib[ "Chrome" ];
					}
					//myTeam[i].updateCarModel( delta, controlsVeyron );
				}

				for (var i=0; i<oppTeam.length; i++){
					if ( oppTeam[i].loaded ) {
						oppTeam[i].wheelMaterials[ 0 ] = mlib[ "Chrome" ];
					}
					//oppTeam[i].updateCarModel( delta, controlsGallardo );
				}
				myTeamLW.updateCarModel(delta, myLWControls);
				myTeamRW.updateCarModel(delta, myRWControls);
				myTeamMF.updateCarModel(delta, myMFControls);
				myTeamLB.updateCarModel(delta, myLBControls);
				myTeamRB.updateCarModel(delta, myRBControls);
				oppTeamLW.updateCarModel(delta, oppLWControls);
				oppTeamRW.updateCarModel(delta, oppRWControls);
				oppTeamMF.updateCarModel(delta, oppMFControls);
				oppTeamLB.updateCarModel(delta, oppLBControls);
				oppTeamRB.updateCarModel(delta, oppRBControls);*/

				// update car model

				// update camera

				if ( ! FOLLOW_CAMERA ) {

					cameraTarget.x = currentCar.currentPosition.x;
					cameraTarget.z = currentCar.currentPosition.z;

					cameraOffset.setX((0-currentCar.currentPosition.x)/2);
					var cameraPos=currentCar.currentPosition.clone().add(cameraOffset);
					camera.position.set(cameraPos.x, cameraPos.y, cameraPos.z);

				} else {

					//spotLight.position.x = currentCar.currentPosition.x - 500;
					//spotLight.position.z = currentCar.currentPosition.z - 500;


				}

				// update shadows

				//spotLight.target.position.x = currentCar.currentPosition.x;
				//spotLight.target.position.z = currentCar.currentPosition.z;

				// render cube map

				var updateCubemap = true;

				if ( updateCubemap ) {

					for (var i=0; i<oppTeam.length; i++){
						oppTeam[i].setVisible( false );
					}
					for (var i=0; i<myTeam.length; i++){
						myTeam[i].setVisible( false );
					}

					cubeCamera.position.copy( currentCar.currentPosition );
					var cameraPos=camera.position.x;
					var cameraCubePos=cubeCamera.position.x;

					renderer.autoClear = true;
					cubeCamera.updateCubeMap( renderer, scene );

					for (var i=0; i<oppTeam.length; i++){
						oppTeam[i].setVisible( true );
					}
					for (var i=0; i<myTeam.length; i++){
						myTeam[i].setVisible( true );
					}

				}

				// render scene

				renderer.autoClear = false;
				cameraTarget = myTeamLW.currentPosition.clone();

				camera.lookAt( cameraTarget );

				renderer.setRenderTarget( null );

				renderer.clear();
				composer.render( 0.1 );

				updateMinimap();
				}
			}

		</script>

	</body>
</html>
