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
		
		<div id="actionMenu" style="display:none">
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
		
		<div style="position: absolute; bottom:0; left: 80%; z-index:1000">
			<canvas id="minimapCanvas"></canvas>
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

			var controls = {
				moveForward: false,
				moveBackward:false,
				moveLeft: false,
				moveRight:false
			}

			var sphereRadius=100;
			var currAnimation="none";
			var currAction="none";
			var gameActive=false;
			var teamWithBall=1;

			var menuSelection=1;
			var MAXITEMS=3;

			var goal1Loc=new THREE.Vector3(100, 0, 0);
			var goal2Loc=new THREE.Vector3(-100, 0, 0);

			var myTeam = [];
			var myTeamLW = new THREE.BBPlayer(null, new THREE.Vector3(20, 0, 50), triggerBreak);
			myTeamLW.loadPlayer(function(){addPlayer(myTeamLW);});
			myTeam.push(myTeamLW);
			var myTeamRW = new THREE.BBPlayer(null, new THREE.Vector3(20, 0, -50), triggerBreak);
			myTeamRW.loadPlayer(function(){addPlayer(myTeamRW);});
			myTeam.push(myTeamRW);
			var myTeamMF = new THREE.BBPlayer(null, new THREE.Vector3(40, 0, 0), triggerBreak);
			myTeamMF.loadPlayer(function(){addPlayer(myTeamMF);});
			myTeam.push(myTeamMF);
			var myTeamLB = new THREE.BBPlayer(null, new THREE.Vector3(60, 0, 20), triggerBreak);
			myTeamLB.loadPlayer(function(){addPlayer(myTeamLB);});
			myTeam.push(myTeamLB);
			var myTeamRB = new THREE.BBPlayer(null, new THREE.Vector3(60, 0, -20), triggerBreak);
			myTeamRB.loadPlayer(function(){addPlayer(myTeamRB);});
			myTeam.push(myTeamRB);
			var myTeamGK = new THREE.BBPlayer(null, new THREE.Vector3(95, 0, 0), triggerBreak);
			myTeamGK.loadPlayer(function(){addPlayer(myTeamGK);});

			var oppTeam = [];
			var oppTeamLW = new THREE.BBPlayer(null, new THREE.Vector3(-20, 0, -50), triggerBreak);
			oppTeamLW.loadPlayer(function(){addPlayer(oppTeamLW);});
			oppTeam.push(oppTeamLW);
			var oppTeamRW = new THREE.BBPlayer(null, new THREE.Vector3(-20, 0, 50), triggerBreak);
			oppTeamRW.loadPlayer(function(){addPlayer(oppTeamRW);});
			oppTeam.push(oppTeamRW);
			var oppTeamMF = new THREE.BBPlayer(null, new THREE.Vector3(-40, 0, 0), triggerBreak);
			oppTeamMF.loadPlayer(function(){addPlayer(oppTeamMF);});
			oppTeam.push(oppTeamMF);
			var oppTeamLB = new THREE.BBPlayer(null, new THREE.Vector3(-60, 0, -20), triggerBreak);
			oppTeamLB.loadPlayer(function(){addPlayer(oppTeamLB);});
			oppTeam.push(oppTeamLB);
			var oppTeamRB = new THREE.BBPlayer(null, new THREE.Vector3(-60, 0, 20), triggerBreak);
			oppTeamRB.loadPlayer(function(){addPlayer(oppTeamRB);});
			oppTeam.push(oppTeamRB);
			var oppTeamGK = new THREE.BBPlayer(null, new THREE.Vector3(-95, 0, 0), triggerBreak);
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

			var currentPlayer=null;

			var clock = null;
			var loadedCount=0;

			var minimapCanvas;
			var minimapContext;

			var cameraZoom=null;
			var zoomLeft=0;
			var inMenu=false;
			
			function addPlayer(bbPlayer){
				//dae = bbPlayer.root;
				loadedCount++;
				if (loadedCount>=12){
					init();
				}
			}

			function pause(){
				gameActive=false;
				for (var i=0; i<allPlayers.length; i++){
					allPlayers[i].gameActive=false;
				}
			}

			function unpause(){
				gameActive=true;
				for (var i=0; i<allPlayers.length; i++){
					allPlayers[i].gameActive=true;
				}
			}
			
			function init() {

				container = document.createElement( 'div' );
				document.body.appendChild( container );

				camera = new THREE.PerspectiveCamera( 45, window.innerWidth / window.innerHeight, 1, 2000 );
				camera.position.set( 0, 0, 30 );

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

				//minimap
				minimapCanvas = document.getElementById('minimapCanvas');
				minimapContext = minimapCanvas.getContext('2d');
				minimapCanvas.height=window.innerWidth*.2;
				minimapCanvas.width=window.innerWidth*.2;

				minimapContext.rect(0,0,minimapCanvas.width,minimapCanvas.width);
				minimapContext.fillStyle="grey";
				minimapContext.fill();
				minimapContext.beginPath();
				minimapContext.arc(minimapCanvas.width/2, minimapCanvas.width/2, minimapCanvas.width/2, 0, 2 * Math.PI, false);
				minimapContext.closePath();
				minimapContext.fillStyle = 'blue';
				minimapContext.fill();

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
				var sphereGeometry = new THREE.SphereGeometry( sphereRadius*1.1, 64, 64 );
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
					allPlayers[i].gameActive=true;
				}
				updateCurrentPlayer(myTeamLW);
				teamWithBall=1;
				gameActive=true;
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
				updateMinimap();

			}

			function onKeyDown(event){
				//dev
				if (!event.keyCode==123){
					event.preventDefault();
				}
				switch(event.keyCode) {
				case 87: /*w*/	cameraControls.moveForward=true; break;
				case 83: /*s*/cameraControls.moveBackward = true; break;
				case 65: /*a*/cameraControls.moveLeft = true; break;
				case 68: /*d*/cameraControls.moveRight = true; break;
				case 81: /*q*/	cameraControls.moveUp=true; break;
				case 69: /*e*/	cameraControls.moveDown=true; break;
				
				case 38: /*up*/ upButtonPressed(); break;
				case 40: /*down*/ downButtonPressed(); break;
				case 37: /*left*/ leftButtonPressed(); break;
				case 39: /*right*/ rightButtonPressed(); break;

				case 32: /*spacebar*/ if (gameActive){gameActive=false;} else {gameActive=true;} break;

				case 90: /*z*/ selectButtonPressed(); break;
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
				
				case 38: /*up*/event.preventDefault(); controls.moveForward = false; break;
				case 40: /*down*/event.preventDefault(); controls.moveBackward = false; break;
				case 37: /*left*/event.preventDefault(); controls.moveLeft = false; break;
				case 39: /*right*/event.preventDefault(); controls.moveRight = false; break;
				}
			}
			
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

			function triggerBreak(){
				controls.moveForward=false;
				controls.moveBackward=false;
				controls.moveLeft=false;
				controls.moveRight=false;
				defendingPlayers = [];
				if (teamWithBall==1){
					for (var i=0; i<oppTeam.length; i++){
						if (oppTeam[i].testEncounter(currentPlayer.currentPosition, defendingPlayers.length)){
							defendingPlayers.push(oppTeam[i]);
						}
					}
				} else {
					for (var i=0; i<myTeam.length; i++){
						if (myTeam[i].testEncounter(currentPlayer.currentPosition, defendingPlayers.length)){
							defendingPlayers.push(myTeam[i]);
						}
					}
				}
				defendingPlayers.sort(function(a,b) {return (b.attack > a.attack) ? 1 : ((a.attack > b.attack) ? -1 : 0);});
				if (defendingPlayers.length>0){
					if (teamWithBall==1){
						var distToGoal=goal2Loc.clone().sub(currentPlayer.currentPosition).length();
						if (distToGoal<11){
							currentPlayer.chasingPosition = currentPlayer.currentPosition.clone();
							while (distToGoal<11){
								currentPlayer.chasingPosition.x += 1;
								distToGoal=goal2Loc.clone().sub(currentPlayer.chasingPosition).length();
							}
							cameraTarget=currentPlayer.chasingPosition.clone();
						}
						//currentPlayer.root.lookAt(goal2Loc);
						//currentPlayer.currentRotation==currentPlayer.root.rotation.y;
					} else if (teamWithBall==2){
						var distToGoal=goal1Loc.clone().sub(currentPlayer.currentPosition).length();
						if (distToGoal<11){
							currentPlayer.chasingPosition = currentPlayer.currentPosition.clone();
							while (distToGoal<11){
								currentPlayer.chasingPosition.x -= 1;
								distToGoal=goal2Loc.clone().sub(currentPlayer.chasingPosition).length();
							}
							cameraTarget=currentPlayer.chasingPosition.clone();
						}
						//currentPlayer.root.lookAt(goal1Loc);
						//currentPlayer.currentRotation==currentPlayer.root.rotation.y;
					}
					var odd=(defendingPlayers.length%2==1);
					var baseX=currentPlayer.currentPosition.x;
					var baseZ=currentPlayer.currentPosition.z;
					if (currentPlayer.chasingPosition!=null){
						baseX=currentPlayer.chasingPosition.x;
						basey=currentPlayer.chasingPosition.z;
					}

					var rotToGoal;
					if (teamWithBall==1){
						rotToGoal=Math.atan2(-1*(goal2Loc.z-baseZ), goal2Loc.x-baseX);
					} else {
						rotToGoal=Math.atan2(-1*(goal1Loc.z-baseZ), goal1Loc.x-baseX);
					}
					
					for (var i=0; i<defendingPlayers.length; i++){
						var baseRot=0;
						//if (teamWithBall==1){
							//baseRot=Math.PI;
						//}
						if (i==0){
							if (!odd){
								baseRot+=Math.PI/16;
							}
						} else if (i==1){
							if (odd){
								baseRot+=Math.PI/6;
							} else {
								baseRot-=Math.PI/12;
							}
						} else if (i==2){
							if (odd){
								baseRot-=Math.PI/6;
							} else {
								baseRot+=Math.PI/4;
							}
						} else if (i==3){
							if (odd){
								baseRot+=Math.PI/3;
							} else {
								baseRot-=Math.PI/4;
							}
						} else if (i==4){
							if (odd){
								baseRot-=Math.PI/3;
							}
						}
						defendingPlayers[i].chasingPosition=new THREE.Vector3(baseX+10*Math.cos(baseRot+rotToGoal), 0, baseZ-10*Math.sin(baseRot+rotToGoal));
					}
				}
				cameraZoom = cameraTarget.clone().sub(camera.position);
				cameraZoom.multiplyScalar((cameraZoom.length()-15)/cameraZoom.length());
				zoomLeft=0.5;
				inMenu=true;
				pause();
				showBreakMenu();
			}
			
			function selectButtonPressed(){
				if (gameActive&&teamWithBall==1){
					triggerBreak();
				} else if (!gameActive&&currAction=="break"){
					if (menuSelection==MAXITEMS){
						showMainActionMenu();
					} else {
						animateBreak(menuSelection);
					}
				} else if (!gameActive&&currAction=="main"){
					if (menuSelection==1){
						techOptions=[];
						for (var i=0; i<currentPlayer.techs.length; i++){
							if (currentPlayer.techs[i].techType=="pass"){
								techOptions.push(currentPlayer.techs[i]);
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
						for (var i=0; i<currentPlayer.techs.length; i++){
							if (currentPlayer.techs[i].techType=="shot"){
								techOptions.push(currentPlayer.techs[i]);
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
						updateCurrentPlayer(currentPlayer);
						unpause();
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
							if (myTeam[i]!=currentPlayer){
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
						if (myTeam[i]!=currentPlayer){
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

			function cancelButtonPressed(){
				if (!gameActive){
					menuSelection=MAXITEMS;
					document.getElementById('selector').style.top=(menuSelection-1)*4+'vmin';
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

			function resumeActiveGame(){
				unpause();
			}

			var breakingPlayer;

			function onBreakResult(numLeft){
				var currEnd = Number(document.getElementById('playerEND').innerHTML);
				currEnd-=Math.round((.5+Math.random())*player.attack);
				if (currEnd<0){
					currEnd=0;
					document.getElementById('playerEND').innerHTML=currEnd;
					if (teamWithBall==1){
						teamWithBall=2;
					} else {
						teamWithBall=1;
					}
					currentPlayer.lostBall(resumeActiveGame);
					updateCurrentPlayer(breakingPlayer);
				} else {
					currentPlayer.continueBreak(animateBreak(numLeft));
				}
			}

			function updateMinimap(){
				//reset canvas
				minimapContext.rect(0,0,minimapCanvas.width,minimapCanvas.width);
				minimapContext.fillStyle="grey";
				minimapContext.fill();
				minimapContext.beginPath();
				minimapContext.arc(minimapCanvas.width/2, minimapCanvas.width/2, minimapCanvas.width/2, 0, 2 * Math.PI, false);
				minimapContext.closePath();
				minimapContext.fillStyle = 'blue';
				minimapContext.fill();

				//yellow team
				for (var i=0; i<myTeam.length; i++){
					var rot=myTeam[i].currentRotation+Math.PI;
					var x1=minimapCanvas.width*(110+myTeam[i].currentPosition.x)/220-Math.cos(rot)*minimapCanvas.width/12;
					var y1=minimapCanvas.width*(110-myTeam[i].currentPosition.z)/220-Math.sin(rot)*minimapCanvas.width/12;
					var x2=x1+Math.cos(rot-Math.PI/12)*(minimapCanvas.width/12);
					var y2=y1+Math.sin(rot-Math.PI/12)*(minimapCanvas.width/12);
					var x3=x1+Math.cos(rot+Math.PI/12)*(minimapCanvas.width/12);
					var y3=y1+Math.sin(rot+Math.PI/12)*(minimapCanvas.width/12);
					minimapContext.beginPath();
					minimapContext.moveTo(x1, minimapCanvas.width-y1);
					minimapContext.lineTo(x2, minimapCanvas.width-y2);
					minimapContext.lineTo(x3, minimapCanvas.width-y3);
					minimapContext.lineTo(x1, minimapCanvas.width-y1);
					minimapContext.closePath();
					minimapContext.stroke();
					minimapContext.fillStyle = "#FFCC00";
					minimapContext.fill();
				}

				//red team
				for (var i=0; i<oppTeam.length; i++){
					var rot=oppTeam[i].currentRotation+Math.PI;
					var x1=minimapCanvas.width*(110+oppTeam[i].currentPosition.x)/220-Math.cos(rot)*minimapCanvas.width/12;
					var y1=minimapCanvas.width*(110-oppTeam[i].currentPosition.z)/220-Math.sin(rot)*minimapCanvas.width/12;
					var x2=x1+Math.cos(rot-Math.PI/12)*(minimapCanvas.width/12);
					var y2=y1+Math.sin(rot-Math.PI/12)*(minimapCanvas.width/12);
					var x3=x1+Math.cos(rot+Math.PI/12)*(minimapCanvas.width/12);
					var y3=y1+Math.sin(rot+Math.PI/12)*(minimapCanvas.width/12);
					minimapContext.beginPath();
					minimapContext.moveTo(x1, minimapCanvas.width-y1);
					minimapContext.lineTo(x2, minimapCanvas.width-y2);
					minimapContext.lineTo(x3, minimapCanvas.width-y3);
					minimapContext.lineTo(x1, minimapCanvas.width-y1);
					minimapContext.closePath();
					//minimapContext.arc(minimapCanvas.width*(100+oppTeam[i].currentPosition.x)/200, minimapCanvas.width*(100+oppTeam[i].currentPosition.z)/200, minimapCanvas.width/40, 0, 2 * Math.PI, false);
					minimapContext.stroke();
					minimapContext.fillStyle = "#FF0000";
					minimapContext.fill();
				}

				//dev
				minimapContext.beginPath();
				minimapContext.arc(minimapCanvas.width*(110+camera.position.x)/220, minimapCanvas.width*(110+camera.position.z)/220, minimapCanvas.width/50, 0, 2 * Math.PI, false);
				minimapContext.closePath();
				minimapContext.fillStyle = 'white';
				minimapContext.fill();

				if (currAnimation=="passedBall"||currAnimation=="shotBall"){
					minimapContext.beginPath();
					minimapContext.arc(minimapCanvas.width*(100+ballPosition.x)/200, minimapCanvas.width*(100-ballPosition.z)/200, minimapCanvas.width/50, 0, 2 * Math.PI, false);
					minimapContext.closePath();
					minimapContext.fillStyle = 'white';
					minimapContext.fill();
				}
			}

			function animateBreak(numLeft){
				if (numLeft>0){
					if (defendingPlayers!=null&&defendingPlayers.length>=numLeft){
						console.log('invalid number of break attempts: ' + numLeft);
						showMainActionMenu();
					}
					breakingPlayer=defendingPlayers.shift();
					currentPlayer.animateEndure(onBreakResult(numLeft-1));
					breakingPlayer.animateTackle(currentPlayer.position);
				} else {
					showMainActionMenu();
				}
			}

			function updateCurrentPlayer(player){
				if (currentPlayer!=null){
					currentPlayer.hasBall=false;
				}
				currentPlayer=player;
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
				currentPlayer.hasBall=true;
			}

			function triggerBallMove(){
				if (currAction=="passing"){
					ballTrajectory=targettedPlayer.currentPosition.clone().sub(currentPlayer.currentPosition);
					ballPosition.set(currentCar.currentPosition.x, currentCar.currentPosition.y, currentCar.currentPosition.z);
					if (is3DMode){
						ball.position=ballPosition;
					} else {
						animatePassBlock();
					}
				}
			}

			function animatePassBlock(){
				if (defendingPlayers==null||defendingPlayers.length==0){
					currAnimation="passedBall";
					ballMoveIteration=0;
					currAction="passing";
					triggerBallMove();
				} else {
					currAnimation="block";
					animatingPlayer=defendingPlayers[0];
					//TODO this should happen in the middle of animation
					currStat = currStat-((.5+Math.random())*defendingPlayers[0].block);
					defendingPlayers.shift();
					setTimeout(animatePassBlock, '1500');
				}
			}

			function pass(){
				currentPlayer.lookAt(targettedPlayer);
				currentPlayer.animatePass(animatePassBlock);
				currStat=currentPlayer.pass;
				//currentCar=destination;
			}

			var rotTimer=0;
			function render() {

				//var timer = Date.now() * 0.0005;
				var delta = clock.getDelta();

				if (cameraZoom!=null){
					if (delta>=zoomLeft){
						camera.position.addVectors(camera.position, cameraZoom);
						if (currentPlayer.chasingPosition!=null){
							currentPlayer.zoomChase(1);
							currentPlayer.chasingPosition=null;
						}
						if (teamWithBall==1){
							currentPlayer.lookAt(goal2Loc);
							//currentPlayer.currentRotation=currentPlayer.root.rotation.y;
						} else {
							currentPlayer.lookAt(goal1Loc);
							//currentPlayer.currentRotation=currentPlayer.root.rotation.y;
						}
						if (defendingPlayers.length>0){
							for (var i=0; i<defendingPlayers.length; i++){
								defendingPlayers[i].zoomChase(1);
								defendingPlayers[i].chasingPosition=null;
								defendingPlayers[i].lookAt(currentPlayer.currentPosition);
							}
						}

						rotTimer=Math.atan2(-1*(camera.position.z-cameraTarget.z), camera.position.x-cameraTarget.x);
						cameraZoom=null;
						zoomLeft=0;
						//rotTimer=0;
					} else {
						var curMove = cameraZoom.clone().multiplyScalar(delta/zoomLeft);
						camera.position.addVectors(camera.position, curMove);
						cameraZoom=cameraZoom.sub(curMove);
						if (currentPlayer.chasingPosition!=null){
							currentPlayer.zoomChase(delta/zoomLeft);
						}

						if (defendingPlayers.length>0){
							for (var i=0; i<defendingPlayers.length; i++){
								defendingPlayers[i].zoomChase(delta/zoomLeft);
							}
						}
						zoomLeft-=delta;
					}
					
				} else if (!gameActive&&inMenu){
					camera.position.x = cameraTarget.x+Math.cos( rotTimer ) * 15;
					camera.position.y = 0;
					camera.position.z = cameraTarget.z-Math.sin( rotTimer ) * 15;
					rotTimer += delta/5;
				}

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
				camera.position.y = 0;
				//camera.position.z = Math.sin( timer ) * 10;
				
				if (controls.moveForward||controls.moveBackward||controls.moveLeft||controls.moveRight){
					cameraTarget.set(myTeamLW.root.position.x, myTeamLW.root.position.y, myTeamLW.root.position.z);
				}
				camera.lookAt(cameraTarget);
				//camera.lookAt( scene.position );

				//particleLight.position.x = Math.sin( timer * 4 ) * 3009;
				//particleLight.position.y = Math.cos( timer * 5 ) * 4000;
				//particleLight.position.z = Math.cos( timer * 4 ) * 3009;

				myTeamLW.hasBall=true;
				for (var i=0; i<allPlayers.length; i++){
					allPlayers[i].updatePlayer(delta/10, controls);
				}
				//THREE.AnimationHandler.update( delta/30 );

				renderer.render( scene, camera );

			}

		</script>
	</body>
</html>
