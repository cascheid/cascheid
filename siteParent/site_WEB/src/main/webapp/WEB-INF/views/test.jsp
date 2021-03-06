<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
	<head>
		<title>Blitzball!</title>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0">
	<script src="js/BBNavMenu.js?version=0.1"></script>
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
				color: #ffffff;
				position:absolute;
				top:10vmin;
				width:35%;
				height:24vmin;
				left:65%;
				padding-left:5vmin;
				text-align:left;
				display:table;
				z-index:1000;
				font-size:1vw;
				line-height:2.5vw;
			}
			
			#backup{
				background-color:#6B238E;
				background-image: url("img/blitzball/cracks.png");
				border: 5px double white;
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
			
			#overlay{
				background:none transparent;
				font-family: "Trebuchet MS", Verdana, sans-serif;
				font-weight: bold;
				font-style:italic;
				font-size: 5vmin;
				text-align:center;
				position:absolute;
				left:40%;
				top:40%;
				width:20%;
				color:gold;
			}
			
			.statHolder {
				background:rgba(0,0,255,0.5);
    			border-radius: 1vmin;
			}
			
			.num {
				background:rgba(0,0,255,0.5);
				color:#FFFF66; 
				font-size:2vw;
				text-align:right;
				display:table-cell;
			}
			
			.stat {
				background:rgba(0,0,255,0.5);
				color: #87CEFA; 
				font-size:1vw;
				text-align:left;
				display:table-cell;
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
		<div id="playerStats" style="display:table-row; visibility:hidden">
			<div style="color:#FFFF66; text-align:right; padding-right:0.5vw; display:table-cell; width:20%;"><label id="playerName"></label></div>
			<div class="num" style="width:15%; border-top-left-radius: 1vw; border-bottom-left-radius: 1vw;"><label id="playerHP"></label></div>
			<div class="stat" style="width:7%"><label>HP</label></div>
			<div class="num" style="width:7%"><label id="playerEND"></label></div>
			<div class="stat" style="width:7%"><label>END</label></div>
			<div class="num" style="width:7%"><label id="playerPAS"></label></div>
			<div class="stat" style="width:7%"><label>PAS</label></div>
			<div class="num" style="width:7%"><label id="playerSHT"></label></div>
			<div class="stat" style="width:23%"><label>SHT</label></div>
		</div>
		<div id="break1Stats" style="visibility:hidden; display:table-row;">
			<div style="color:#FFFF66; text-align:right; padding-right:0.5vw; display:table-cell; width:20%;"><label id="break1Name"></label></div>
			<div class="num" style="width:15%; border-top-left-radius: 1vw; border-bottom-left-radius: 1vw;"><label id="break1HP"></label></div>
			<div class="stat" style="width:7%"><label>HP</label></div>
			<div class="num" style="width:7%"><label id="break1ATK"></label></div>
			<div class="stat" style="width:7%"><label id="break1ATKLabel">ATK</label></div>
			<div class="num" style="width:7%"><label id="break1BLK"></label></div>
			<div class="stat" style="width:7%"><label id="break1BLKLabel">BLK</label></div>
			<div class="num" style="width:7%"><label id="break1EXT"></label></div>
			<div class="stat" style="width:23%"><label id="break1EXTLabel"></label></div>
		</div>
		<div id="break2Stats" style="visibility:hidden; display:table-row;">
			<div style="color:#FFFF66; text-align:right; padding-right:0.5vw; display:table-cell; width:20%;"><label id="break2Name"></label></div>
			<div class="num" style="width:15%; border-top-left-radius: 1vw; border-bottom-left-radius: 1vw;"><label id="break2HP"></label></div>
			<div class="stat" style="width:7%"><label>HP</label></div>
			<div class="num" style="width:7%"><label id="break2ATK"></label></div>
			<div class="stat" style="width:7%"><label id="break2ATKLabel">ATK</label></div>
			<div class="num" style="width:7%"><label id="break2BLK"></label></div>
			<div class="stat" style="width:7%"><label id="break2BLKLabel">BLK</label></div>
			<div class="num" style="width:7%"><label id="break2EXT"></label></div>
			<div class="stat" style="width:23%"><label id="break2EXTLabel"></label></div>
		</div>
		<div id="break3Stats" style="visibility:hidden; display:table-row;">
			<div style="color:#FFFF66; text-align:right; padding-right:0.5vw; display:table-cell; width:20%;"><label id="break3Name"></label></div>
			<div class="num" style="width:15%; border-top-left-radius: 1vw; border-bottom-left-radius: 1vw;"><label id="break3HP"></label></div>
			<div class="stat" style="width:7%"><label>HP</label></div>
			<div class="num" style="width:7%"><label id="break3ATK"></label></div>
			<div class="stat" style="width:7%"><label id="break3ATKLabel">ATK</label></div>
			<div class="num" style="width:7%"><label id="break3BLK"></label></div>
			<div class="stat" style="width:7%"><label id="break3BLKLabel">BLK</label></div>
			<div class="num" style="width:7%"><label id="break3EXT"></label></div>
			<div class="stat" style="width:23%"><label id="break3EXTLabel"></label></div>
		</div>
		<div id="break4Stats" style="visibility:hidden; display:table-row;">
			<div style="color:#FFFF66; text-align:right; padding-right:0.5vw; display:table-cell; width:20%;"><label id="break4Name"></label></div>
			<div class="num" style="width:15%; border-top-left-radius: 1vw; border-bottom-left-radius: 1vw;"><label id="break4HP"></label></div>
			<div class="stat" style="width:7%"><label>HP</label></div>
			<div class="num" style="width:7%"><label id="break4ATK"></label></div>
			<div class="stat" style="width:7%"><label id="break4ATKLabel">ATK</label></div>
			<div class="num" style="width:7%"><label id="break4BLK"></label></div>
			<div class="stat" style="width:7%"><label id="break4BLKLabel">BLK</label></div>
			<div class="num" style="width:7%"><label id="break4EXT"></label></div>
			<div class="stat" style="width:23%"><label id="break4EXTLabel"></label></div>
		</div>
		<div id="break5Stats" style="visibility:hidden; display:table-row;">
			<div style="color:#FFFF66; text-align:right; padding-right:0.5vw; display:table-cell; width:20%;"><label id="break5Name"></label></div>
			<div class="num" style="width:15%; border-top-left-radius: 1vw; border-bottom-left-radius: 1vw;"><label id="break5HP"></label></div>
			<div class="stat" style="width:7%"><label>HP</label></div>
			<div class="num" style="width:7%"><label id="break5ATK"></label></div>
			<div class="stat" style="width:7%"><label id="break5ATKLabel">ATK</label></div>
			<div class="num" style="width:7%"><label id="break5BLK"></label></div>
			<div class="stat" style="width:7%"><label id="break5BLKLabel">BLK</label></div>
			<div class="num" style="width:7%"><label id="break5EXT"></label></div>
			<div class="stat" style="width:23%"><label id="break5EXTLabel"></label></div>
		</div>
		<div id="break6Stats" style="visibility:hidden; display:table-row;">
			<div style="color:#FFFF66; text-align:right; padding-right:0.5vw; display:table-cell; width:20%;"><label id="break6Name"></label></div>
			<div class="num" style="width:15%; border-top-left-radius: 1vw; border-bottom-left-radius: 1vw;"><label id="break6HP"></label></div>
			<div class="stat" style="width:7%"><label>HP</label></div>
			<div class="num" style="width:7%"><label id="break6ATK"></label></div>
			<div class="stat" style="width:7%"><label id="break6ATKLabel">ATK</label></div>
			<div class="num" style="width:7%"><label id="break6BLK"></label></div>
			<div class="stat" style="width:7%"><label id="break6BLKLabel">BLK</label></div>
			<div class="num" style="width:7%"><label id="break6EXT"></label></div>
			<div class="stat" style="width:23%"><label id="break6EXTLabel"></label></div>
		</div>
		</div>
		
		<div id="infoText" style="color:white; text-align:left; font-size:4vmin; position:absolute; top:20vmin; left:20vmin"></div>
		
		<div id="techCopy" style="color:#FFFFFF; text-align:left; font-size:4vmin; position:absolute; top:80vmin; left:20vmin; display:none">techcopy</div>
		
		<div id="overlay" style="display:none">Blitzoff!</div>
		
		<div style="position: absolute; bottom:6vw; left: 80%; z-index:1000">
			<canvas id="minimapCanvas"></canvas>
		</div>
		
		<div id="bottomDisplay" style="display:table; position: absolute; bottom:0vw; left: 70%; z-index:1000; width:30%; visibility:hidden">
			<div id="timeRow" style="display:table-row;">
				<div class="num" style="color:#FFFF00; width:29%; border-top-left-radius: 1vw; border-bottom-left-radius: 1vw;">TIME</div>
				<div class="num" style="width:20%;"><label id="minuteLabel">00</label></div>
				<div class="num" style="width:2%;"><label>:</label></div>
				<div class="num" style="width:20%; text-align:left;"><label id="secondLabel">00</label></div>
				<div class="num" style="width:29%;"></div>
			</div>
			<div id="scoreRow" style="display:table-row;">
				<div class="num" style="text-align:center; color:#FFFF00; width:29%; border-top-left-radius: 1vw; border-bottom-left-radius: 1vw;">
					<img id="team2Logo" src="" width="0" height="0" />
				</div>
				<div class="num" style="width:20%; text-align:left"><label id="team2Score" style="padding-left:0.5vw;">0</label></div>
				<div class="num" style="width:2%;"></div>
				<div class="num" style="width:20%;text-align:right; "><label id="team1Score" style="padding-left:0.5vw;">0</label></div>
				<div class="num" style="width:29%; text-align:center; ">
					<img id="team1Logo" src="" width="0" height="0" />
				</div>
			</div>
		</div>
		
		<form:form id="gameInfoForm" action="blitzballIntermission" commandName="blitzballGameInfo">
			<form:hidden id="formTeam1Score" path="team1Score"/>
			<form:hidden id="formTeam2Score" path="team2Score"/>
			<form:hidden id="halvesComplete" path="halvesComplete"/>
    		<c:forEach var="playerStatLine" items="${blitzballGameInfo.playerStatistics}" varStatus="status">
        		<form:hidden path="playerStatistics[${status.index}].goals" name="goals" id="goals${playerStatLine.playerID}" value="" />
        		<form:hidden path="playerStatistics[${status.index}].shots" name="shots" id="shots${playerStatLine.playerID}" value="" />
        		<form:hidden path="playerStatistics[${status.index}].assists" name="assists" id="assists${playerStatLine.playerID}" value="" />
        		<form:hidden path="playerStatistics[${status.index}].goalsAgainst" name="goalsAgainst" id="goalsAgainst${playerStatLine.playerID}" value="" />
        		<form:hidden path="playerStatistics[${status.index}].shotsAgainst" name="shotsAgainst" id="shotsAgainst${playerStatLine.playerID}" value="" />
        		<form:hidden path="playerStatistics[${status.index}].tackles" name="tackles" id="tackles${playerStatLine.playerID}" value="" />
        		<form:hidden path="playerStatistics[${status.index}].blocks" name="blocks" id="blocks${playerStatLine.playerID}" value="" />
        		<form:hidden path="playerStatistics[${status.index}].breaks" name="breaks" id="breaks${playerStatLine.playerID}" value="" />
        		<form:hidden path="playerStatistics[${status.index}].turnovers" name="turnovers" id="turnovers${playerStatLine.playerID}" value="" />
    		</c:forEach>
		</form:form>

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
			var timerActive=false;
			var teamWithBall=1;
			var multiplayer=false;

			var trackTimer=0;
			var triggerTimer=0;
			var rotTimer=0;
			var gameTimer=0;
			var selectedTech=null;
			var techOptions=[];

			var menuSelection=1;
			var MAXITEMS=3;
			var navMenu = new BBNavMenu('selector', MAXITEMS, 1);

			var goal1Loc=new THREE.Vector3(100, 3, -4);
			var goal2Loc=new THREE.Vector3(-100, 3, 4);


			var blitzball=null;
			var goal1=null;
			var goal2=null;
			var team1Score=0;
			var team2Score=0;
			var blitzoffTeam=2;
			var timeSinceLastTrigger=10;
			var halvesComplete=Number(document.getElementById('halvesComplete').value);
			var loader = new THREE.ColladaLoader();
			loader.options.convertUpAxis = true;
			loader.load( 'obj/blitzball/blitzball.dae', function ( collada ) {

				blitzball = collada.scene;
				blitzball.children[0].children[0].material.side=THREE.DoubleSide;
				
				blitzball.updateMatrix();

				addPlayer(blitzball);
			} );

			loader.load( 'obj/stormtrooper/goal.dae', function ( collada ) {

				goal1 = collada.scene;
				//dae.children[0].children[0].material.side=THREE.DoubleSide;
				goal1.traverse( function ( child ) {

				if ( child instanceof THREE.Mesh ) {
					child.material.side=THREE.DoubleSide
					if (child.material.name=='netmat'){
						child.material.transparent=true;
						child.material.opacity=0.5;
					}
				}

				} );
				goal1.scale.x = goal1.scale.y = goal1.scale.z = 4;
				
				goal2=goal1.clone();
				goal1.position.set(100, 0, 0);
				goal2.position.set(-100, 0, 0);
				goal1.rotation.y=-Math.PI/2;
				goal2.rotation.y=Math.PI/2;
				
				goal1.updateMatrix();
				goal2.updateMatrix();
				addPlayer(goal1);

				//addPlayer(blitzball);
			} );


			var myTeamJSON=JSON.parse('${myTeam}');
			var oppTeamJSON=JSON.parse('${oppTeam}');

			var myTeam = [];
			var myTeamLW = new THREE.BBPlayer(myTeamJSON.leftWing, new THREE.Vector3(20, 0, 50), triggerBreak);
			myTeamLW.loadPlayer(function(){addPlayer(myTeamLW);});
			myTeam.push(myTeamLW);
			var myTeamRW = new THREE.BBPlayer(myTeamJSON.rightWing, new THREE.Vector3(20, 0, -50), triggerBreak);
			myTeamRW.loadPlayer(function(){addPlayer(myTeamRW);});
			myTeam.push(myTeamRW);
			var myTeamMF = new THREE.BBPlayer(myTeamJSON.midfielder, new THREE.Vector3(40, 0, 0), triggerBreak);
			myTeamMF.loadPlayer(function(){addPlayer(myTeamMF);});
			myTeam.push(myTeamMF);
			var myTeamLB = new THREE.BBPlayer(myTeamJSON.leftBack, new THREE.Vector3(60, 0, 20), triggerBreak);
			myTeamLB.loadPlayer(function(){addPlayer(myTeamLB);});
			myTeam.push(myTeamLB);
			var myTeamRB = new THREE.BBPlayer(myTeamJSON.rightBack, new THREE.Vector3(60, 0, -20), triggerBreak);
			myTeamRB.loadPlayer(function(){addPlayer(myTeamRB);});
			myTeam.push(myTeamRB);
			var myTeamGK = new THREE.BBPlayer(myTeamJSON.keeper, new THREE.Vector3(95, 0, 0), triggerBreak);
			myTeamGK.loadPlayer(function(){addPlayer(myTeamGK);});

			var oppTeam = [];
			var oppTeamLW = new THREE.BBPlayer(oppTeamJSON.leftWing, new THREE.Vector3(-20, 0, -50), triggerBreak);
			oppTeamLW.loadPlayer(function(){addPlayer(oppTeamLW);});
			oppTeam.push(oppTeamLW);
			var oppTeamRW = new THREE.BBPlayer(oppTeamJSON.rightWing, new THREE.Vector3(-20, 0, 50), triggerBreak);
			oppTeamRW.loadPlayer(function(){addPlayer(oppTeamRW);});
			oppTeam.push(oppTeamRW);
			var oppTeamMF = new THREE.BBPlayer(oppTeamJSON.midfielder, new THREE.Vector3(-40, 0, 0), triggerBreak);
			oppTeamMF.loadPlayer(function(){addPlayer(oppTeamMF);});
			oppTeam.push(oppTeamMF);
			var oppTeamLB = new THREE.BBPlayer(oppTeamJSON.leftBack, new THREE.Vector3(-60, 0, -20), triggerBreak);
			oppTeamLB.loadPlayer(function(){addPlayer(oppTeamLB);});
			oppTeam.push(oppTeamLB);
			var oppTeamRB = new THREE.BBPlayer(oppTeamJSON.rightBack, new THREE.Vector3(-60, 0, 20), triggerBreak);
			oppTeamRB.loadPlayer(function(){addPlayer(oppTeamRB);});
			oppTeam.push(oppTeamRB);
			var oppTeamGK = new THREE.BBPlayer(oppTeamJSON.keeper, new THREE.Vector3(-95, 0, 0), triggerBreak);
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
			var animatingPlayer=null;
			var targettedPlayer=null

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
				if (loadedCount>=14){
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
				clearInfo();
				gameActive=true;
				for (var i=0; i<allPlayers.length; i++){
					allPlayers[i].gameActive=true;
				}
			}

			function clearInfo(){
				document.getElementById('infoText').innerHTML="";
			}

			function writeInfo(inText){
				var text=document.getElementById('infoText').innerHTML+"<br />"+inText;
				document.getElementById('infoText').innerHTML=text;
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
				minimapContext.globalAlpha=0.5;

				minimapContext.clearRect(0,0,minimapCanvas.width,minimapCanvas.width);
				//minimapContext.fillStyle="grey";
				//minimapContext.fill();
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
				scene.add(blitzball);
				scene.add(goal1);
				scene.add(goal2);

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
					new THREE.BoxGeometry( sphereRadius*8, sphereRadius*8, sphereRadius*8 ),
					skyBoxMaterial
				);

				scene.add( skyBox );
				
				//sphere
				var sphereTexture = THREE.ImageUtils.loadTexture('img/blitzball/stadium5.jpg');//TODO real texture
				var sphereMaterial = new THREE.MeshLambertMaterial( { color: 0xffffff, map: sphereTexture,  side:THREE.DoubleSide, opacity:0.5, transparent:true } );
				var sphereGeometry = new THREE.SphereGeometry( sphereRadius*1.1, 64, 64 );
				var sphereMesh = new THREE.Mesh( sphereGeometry, sphereMaterial );
				sphereMesh.rotation.y=Math.PI/2;
				//sphereMesh.rotation.x=Math.PI/2;
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

				//scoreboard
				var logoImg1 = new Image();
				logoImg1.onload = function(){
					var img=document.getElementById('team1Logo');
					img.height=window.innerWidth*0.03;
					img.width=window.innerWidth*0.04;
					img.src=logoImg1.src;
				}
				logoImg1.src="img/blitzball/Bandits.jpg";
				var logoImg2 = new Image();
				logoImg2.onload = function(){
					var img=document.getElementById('team2Logo');
					img.height=window.innerWidth*0.03;
					img.width=window.innerWidth*0.04;
					img.src=logoImg2.src;
				}
				logoImg2.src="img/blitzball/Bandits.jpg";
				
				window.addEventListener( 'resize', onWindowResize, false );
				window.addEventListener('keydown', onKeyDown, true);
				window.addEventListener('keyup', onKeyUp, true);
			}

			function startGame(){
				cameraTarget.set(scene.position.x, scene.position.y, scene.position.z);
				document.getElementById('bottomDisplay').style.visibility='';

				clock=new THREE.Clock();
				//updateCurrentPlayer(myTeamLW);
				for (var i=0; i<myTeam.length; i++){
					myTeam[i].playTreadAnimation();
					myTeam[i].gameActive=true;
				}
				for (var i=0; i<oppTeam.length; i++){
					oppTeam[i].playTreadAnimation();
					oppTeam[i].gameActive=true;
				}
				myTeamGK.playGoalieTreadAnimation();
				myTeamGK.gameActive=true;
				oppTeamGK.playGoalieTreadAnimation();
				oppTeamGK.gameActive=true;
				//teamWithBall=1;
				//gameActive=true;
				blitzoff();
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
					navMenu.moveDown();
					if (currAction=="break"){
						numDefenders=navMenu.getRow()-1;
						highlightBreakInfo();
					} else if (currAction=="main"){
						highlightTargettedPlayer();
					} else if (currAction=="pass"){
						if (navMenu.getRow()==MAXITEMS||navMenu.getRow()==1){
							document.getElementById('playerPAS').innerHTML=currentPlayer.pass;
						} else {
							document.getElementById('playerPAS').innerHTML=currentPlayer.pass+techOptions[navMenu.getRow()-1].statMod;
						}
					} else if (currAction=="shoot"){
						if (navMenu.getRow()==MAXITEMS||navMenu.getRow()==1){
							document.getElementById('playerSHT').innerHTML=currentPlayer.shot;
						} else {
							document.getElementById('playerSHT').innerHTML=currentPlayer.shot+techOptions[navMenu.getRow()-1].statMod;
						}
					} else if (currAction=="targetting"){
						var j=0;
						for (var i=0; i<myTeam.length; i++){
							if (myTeam[i]!=currentPlayer){
								j++;
								if (j==navMenu.getRow()){
									targettedPlayer=myTeam[i];
									break;
								}
							}
						}
						highlightTargettedPlayer();
					}
				} else if (!gameActive&&teamWithBall==2&&attackAction=="attackSelection"){
					navMenu.moveDown();
					document.getElementById('break'+breakAttackerNum+'ATK').innerHTML=breakingPlayer.attack+attackOptions[navMenu.getRow()-1].statMod;
				}
			}
			
			function upButtonPressed(){
				if (gameActive&&teamWithBall==1){
					controls.moveForward = true;
				} else if (!gameActive&&teamWithBall==1){
					navMenu.moveUp();
					if (currAction=="break"){
						numDefenders=navMenu.getRow()-1;
						highlightBreakInfo();
					} else if (currAction=="main"){
						highlightTargettedPlayer();
					} else if (currAction=="pass"){
						if (navMenu.getRow()==MAXITEMS||navMenu.getRow()==1){
							document.getElementById('playerPAS').innerHTML=currentPlayer.pass;
						} else {
							document.getElementById('playerPAS').innerHTML=currentPlayer.pass+techOptions[navMenu.getRow()-1].statMod;
						}
					} else if (currAction=="shoot"){
						if (navMenu.getRow()==MAXITEMS||navMenu.getRow()==1){
							document.getElementById('playerSHT').innerHTML=currentPlayer.shot;
						} else {
							document.getElementById('playerSHT').innerHTML=currentPlayer.shot+techOptions[navMenu.getRow()-1].statMod;
						}
					} else if (currAction=="targetting"){
						var j=0;
						for (var i=0; i<myTeam.length; i++){
							if (myTeam[i]!=currentPlayer){
								j++;
								if (j==navMenu.getRow()){
									targettedPlayer=myTeam[i];
									break;
								}
							}
						}
						highlightTargettedPlayer();
					}
				} else if (!gameActive&&teamWithBall==2&&attackAction=="attackSelection"){
					navMenu.moveUp();
					document.getElementById('break'+breakAttackerNum+'ATK').innerHTML=breakingPlayer.attack+attackOptions[navMenu.getRow()-1].statMod;
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

			function triggerBreak(randomTriggered){
				timerActive=false
				controls.moveForward=false;
				controls.moveBackward=false;
				controls.moveLeft=false;
				controls.moveRight=false;
				defendingPlayers = [];
				numDefenders=0;
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
				timeSinceLastTrigger=0;
				pause();
				if (teamWithBall==1){
					showBreakMenu();
				} else {
					currAction="aibreak";
					for (var i=0; i<defendingPlayers.length; i++){
						document.getElementById('break'+(i+1)+'Name').innerHTML=defendingPlayers[i].name;
						document.getElementById('break'+(i+1)+'HP').innerHTML=defendingPlayers[i].hp;
						document.getElementById('break'+(i+1)+'ATK').innerHTML=defendingPlayers[i].attack;
						document.getElementById('break'+(i+1)+'ATKLabel').innerHTML='ATK';
						document.getElementById('break'+(i+1)+'BLK').innerHTML=defendingPlayers[i].block;
						document.getElementById('break'+(i+1)+'BLKLabel').innerHTML='BLK';
						document.getElementById('break'+(i+1)+'Stats').style.visibility='';
					}
					if (defendingPlayers!=null&&defendingPlayers.length>0){
						var expectedBreakLeft=currentPlayer.endurance;
						for (var i=0; i<defendingPlayers.length; i++){
							expectedBreakLeft-=defendingPlayers[i].attack;
							if (expectedBreakLeft<=3){
								var expectedPassLeft=currentPlayer.pass;
								for (var j=i; j<defendingPlayers.length; j++){
									expectedPassLeft-=defendingPlayers[i].block;
								}
								if (expectedBreakLeft>=expectedPassLeft){
									numDefenders++;
									break;
								} else {
									break;
								}
							} else {
								numDefenders++;
							}
						}
						if (numDefenders>0){
							writeInfo(numDefenders + ' player breakthrough.');
						} else {
							writeInfo('No break');
						}
					} else {
						writeInfo('No break');
					}
					setTimeout(function(){
						var shotChance=0.0;
						if (currentPlayer.currentPosition.x>0){
							shotChance = currentPlayer.currentPosition.x/200;
							if (currentPlayer==oppTeamLW || currentPlayer==oppTeamRW){
								shotChance *= 2.5;
							}
						}
						if (Math.random()<shotChance){
							var options = [];
							for (var i=0; i<currentPlayer.techs.length; i++){
								if (currentPlayer.techs[i].techType=='SHOT'&&currentPlayer.techs[i].hpCost<currentPlayer.hp){
									options.push(i);
								}
							}
							if (options.length>0){
								var chosen = Math.floor(Math.random()*(options.length+1));
								if (chosen>0){
									selectedTech = currentPlayer.techs[options[chosen-1]];
								}
							}
							if (selectedTech!=null){
								writeInfo(selectedTech.techName);
								//TODO increase shot value on dom
							} else {
								writeInfo('Shoot');
							}
							//TODO display keeper
							currAction="breakshoot";
						} else {
							if (numDefenders>0 || randomTriggered || (Math.random()<(currentPlayer.pass/(currentPlayer.endurance/2+currentPlayer.pass)))){
								var options = [];
								for (var i=0; i<currentPlayer.techs.length; i++){
									if (currentPlayer.techs[i].techType=='PASS'&&currentPlayer.techs[i].hpCost<currentPlayer.hp){
										options.push(i);
									}
								}
								if (options.length>0){
									var chosen = Math.floor(Math.random()*(options.length+1));
									if (chosen>0){
										selectedTech = currentPlayer.techs[options[chosen-1]];
									}
								}
								if (selectedTech!=null){
									writeInfo(selectedTech.techName);
									//TODO increase pass value on dom
								} else {
									writeInfo('Pass');
								}
								currAction="breaktargetting";
							} else {
								writeInfo('Dribble');
								currAction="breakdribble";
							}
						}
						breakAttackerNum=0;
						setTimeout(function(){animateBreak(numDefenders);}, '2000');
					}, '2000');
				}
			}
			var gameOver=false;
			function selectButtonPressed(){
				if (!gameOver){
				if (techCopying){
					if (techCopyMatch){
						if (Math.random()<Math.max((.75+.05*(techCopyPlayer.level-currentPlayer.level)), .5)){
							techCopyPlayer.learnedTechs.push(selectedTech);
							if (techCopyPlayer.keyTech1!=selectedTech.techID&&techCopyPlayer.keyTech2!=selectedTech.techID&&techCopyPlayer.keyTech3!=selectedTech.techID){
								writeInfo(techCopyPlayer.name + ' learned a new tech');
							} else {
								writeInfo(techCopyPlayer.name + ' learned a new key tech');
							}
						} else {
							writeInfo(techCopyPlayer.name + ' level too low, tech copy failed.');
						}
					} else {
						writeInfo('Tech copy failed.');
					}
					techCopying=false;
					techCopyMatch=false;
					document.getElementById('techCopy').style.display='none';
				}
				else if (gameActive&&teamWithBall==1){
					triggerBreak();
				} else if (!gameActive&&teamWithBall==2&&attackAction=="attackSelection"){
					selectedAttack=attackOptions[navMenu.getRow()-1];
					document.getElementById('actionMenu').style.display='none';
					executeBreak();
				} else if (!gameActive&&currAction=="break"){
					if (navMenu.getRow()==1){
						writeInfo('No break.');
						showMainActionMenu();
					} else {
						//document.getElementById('actionMenu').style.display='none';
						writeInfo(numDefenders + ' player breakthrough.');
						showMainActionMenu();
						//animateBreak(menuSelection);
					}
				} else if (!gameActive&&currAction=="main"){
					if (navMenu.getRow()==1){
						clearMenu();
						techOptions=[];
						var normalPass = {
							effectChance:0,
							hpCost:currentPlayer.pass, 
							statMod:0,
							techDescription:"",
							techID:null,
							techName:"Normal Pass",
							techType:"PASS"
						};
						techOptions.push(normalPass);
						for (var i=0; i<currentPlayer.techs.length; i++){
							if (currentPlayer.techs[i].techType=="PASS"){
								techOptions.push(currentPlayer.techs[i]);
							}
						}
						document.getElementById('actionMenu').style.height=((techOptions.length+1)*4)+"vmin";
						for (var i=0; i<techOptions.length; i++){
							document.getElementById('menu'+(i+1)).style.display='';
							document.getElementById('menu'+(i+1)).innerHTML=techOptions[i].techName;
						}
						MAXITEMS=techOptions.length+1;
						navMenu.updateActiveSelector('selector', MAXITEMS, 1);
						document.getElementById('menu'+MAXITEMS).style.display='';
						document.getElementById('menu'+MAXITEMS).innerHTML='Back';
						currAction="pass";
					} else if (navMenu.getRow()==2){
						clearMenu();
						techOptions=[];
						var normalShot = {
							effectChance:0,
							hpCost:currentPlayer.shot, 
							statMod:0,
							techDescription:"",
							techID:null,
							techName:"Normal Shot",
							techType:"SHOT"
						};
						techOptions.push(normalShot);
						for (var i=0; i<currentPlayer.techs.length; i++){
							if (currentPlayer.techs[i].techType=="SHOT"){
								techOptions.push(currentPlayer.techs[i]);
							}
						}
						document.getElementById('actionMenu').style.height=((techOptions.length+1)*4)+"vmin";
						for (var i=0; i<techOptions.length; i++){
							document.getElementById('menu'+(i+1)).style.display='';
							document.getElementById('menu'+(i+1)).innerHTML=techOptions[i].techName;
						}
						MAXITEMS=techOptions.length+1;
						navMenu.updateActiveSelector('selector', MAXITEMS, 1);
						document.getElementById('menu'+MAXITEMS).style.display='';
						document.getElementById('menu'+MAXITEMS).innerHTML='Back';
						currAction="shoot";
					} else if (navMenu.getRow()==3){
						document.getElementById('actionMenu').style.display='none';
						currAction="breakdribble";
						inMenu=false;
						breakAttackerNum=0;
						animateBreak(numDefenders);
						//updateCurrentPlayer(currentPlayer);
						//unpause();
					}
				} else if (!gameActive&&currAction=="pass"){
					if (navMenu.getRow()==MAXITEMS){
						showMainActionMenu();
					} else {
						if (navMenu.getRow()>1){
							selectedTech=techOptions[navMenu.getRow()-1];
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
						navMenu.updateActiveSelector('selector', MAXITEMS, 1);
						document.getElementById('actionMenu').style.height=(MAXITEMS*4)+'vmin';
						document.getElementById('actionMenu').style.display="none";
						currAction="breaktargetting";
						inMenu=false;
						breakAttackerNum=0;
						animateBreak(numDefenders);
					}
				} else if (!gameActive&&currAction=="targetting"){
					pass();
				} else if (!gameActive&&currAction=="shoot"){
					if (navMenu.getRow()==MAXITEMS){
						showMainActionMenu();
					} else {
						if (navMenu.getRow()>1){
							selectedTech=techOptions[navMenu.getRow()-1];
						}
						currAction="breakshoot";
						inMenu=false;
						breakAttackerNum=0;
						animateBreak(numDefenders);
						//shoot();
					}
				}
				}
			}

			function cancelButtonPressed(){
				if (!gameActive){
					navMenu.updateRow(MAXITEMS);
					document.getElementById('selector').style.top=(navMenu.getRow()-1)*4+'vmin';
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
				navMenu.updateRow(1);
				document.getElementById('selector').style.top=(navMenu.getRow()-1)*4+'vmin';
			}
			
			function showBreakMenu(){
				if (defendingPlayers!=null&&defendingPlayers.length>0){
					clearMenu();
					MAXITEMS=1;
					document.getElementById('menu1').style.display='';
					document.getElementById('menu1').innerHTML='No Break';
					for (var i=0; i<defendingPlayers.length; i++){
						document.getElementById('menu'+(MAXITEMS+1)).style.display='';
						document.getElementById('menu'+(MAXITEMS+1)).innerHTML='Break to '+defendingPlayers[i].name;
						document.getElementById('break'+MAXITEMS+'Name').innerHTML=defendingPlayers[i].name;
						document.getElementById('break'+MAXITEMS+'HP').innerHTML=defendingPlayers[i].hp;
						document.getElementById('break'+MAXITEMS+'ATK').innerHTML=defendingPlayers[i].attack;
						document.getElementById('break'+MAXITEMS+'ATKLabel').innerHTML='ATK';
						document.getElementById('break'+MAXITEMS+'BLK').innerHTML=defendingPlayers[i].block;
						document.getElementById('break'+MAXITEMS+'BLKLabel').innerHTML='BLK';
						document.getElementById('break'+MAXITEMS+'Stats').style.visibility='';
						MAXITEMS++;
					}
					navMenu.updateActiveSelector('selector', MAXITEMS, 1);
					currAction="break";
					document.getElementById('actionMenu').style.height=(MAXITEMS*4)+'vmin';
					document.getElementById('actionMenu').style.display='';
					highlightBreakInfo();
				} else {
					showMainActionMenu();
				}
			}

			function showMainActionMenu(){
				clearMenu();
				document.getElementById('menu1').innerHTML='Pass';
				document.getElementById('menu2').innerHTML='Shoot';
				if (defendingPlayers.length>numDefenders){
					document.getElementById('menu3').style.display='none';
					MAXITEMS=2;
				} else {
					document.getElementById('menu3').style.display='';
					document.getElementById('menu3').innerHTML='Dribble';
					MAXITEMS=3;
				}
				navMenu.updateActiveSelector('selector', MAXITEMS, 1);
				currAction="main";
				document.getElementById('actionMenu').style.display='';
				document.getElementById('actionMenu').style.height=(MAXITEMS*4)+'vmin';
			}

			function delayResumeGame(newCurrentPlayer){
				setTimeout(function(){
					if (newCurrentPlayer!=null){
						updateCurrentPlayer(newCurrentPlayer);
					}
					resumeActiveGame();
				}, '1000');
				
			}

			function resumeActiveGame(){
				clearInfo();
				currAction="none";
				timerActive=true;
				unpause();
			}

			var breakingPlayer;
			var statUpdating=null;
			function updateStat(statName, value){
				trackTimer=0;
				statUpdating=statName;
				document.getElementById(statName).innerHTML=value;
				document.getElementById(statName).style.color='red';
				document.getElementById(statName).style.fontSize='5vmin';
			}


			var numDefenders=0;
			function highlightBreakInfo(){
				//var numDefenders=menuSelection-1;
				if (defendingPlayers!=null&&defendingPlayers.length>0){
					for (var i=0; i<defendingPlayers.length; i++){
						if (i<numDefenders){
							document.getElementById('break'+(i+1)+'ATK').style.color='#FFFF66';
							document.getElementById('break'+(i+1)+'BLK').style.color='#708090';
						} else {
							document.getElementById('break'+(i+1)+'ATK').style.color='#708090';
							document.getElementById('break'+(i+1)+'BLK').style.color='#FFFF66';
						}
							
					}
				}
			}

			function highlightTargettedPlayer(){
				var num=defendingPlayers.length+1;
				if (currAction=="targetting"){
					document.getElementById('break'+num+'Name').innerHTML=targettedPlayer.name;
					document.getElementById('break'+num+'HP').innerHTML=targettedPlayer.hp;
					document.getElementById('break'+num+'ATK').innerHTML=targettedPlayer.endurance;
					document.getElementById('break'+num+'ATKLabel').innerHTML='EN';
					document.getElementById('break'+num+'BLK').innerHTML=targettedPlayer.pass;
					document.getElementById('break'+num+'BLKLabel').innerHTML='PAS';
					document.getElementById('break'+num+'EXT').innerHTML=targettedPlayer.SHT;
					document.getElementById('break'+num+'EXTLabel').innerHTML='SHT';
					document.getElementById('break'+num+'Stats').style.visibility='';
					cameraTarget.set(targettedPlayer.currentPosition.x, 0, targettedPlayer.currentPosition.z);
				} else if (currAction=="main"){
					if (navMenu.getRow()==2){
						var keeper=null;
						if (teamWithBall==1){
							keeper=oppTeamGK;
						} else {
							keeper=myTeamGK;
						}
						document.getElementById('break'+num+'Name').innerHTML=keeper.name;
						document.getElementById('break'+num+'HP').innerHTML=keeper.hp;
						document.getElementById('break'+num+'ATK').innerHTML='';
						document.getElementById('break'+num+'ATKLabel').innerHTML='';
						document.getElementById('break'+num+'BLK').innerHTML=keeper.cat;
						document.getElementById('break'+num+'BLKLabel').innerHTML='CAT';
						document.getElementById('break'+num+'EXT').innerHTML='';
						document.getElementById('break'+num+'EXTLabel').innerHTML='';
						document.getElementById('break'+num+'Stats').style.visibility='';
					} else {
						document.getElementById('break'+num+'Stats').style.visibility='hidden';
					}
				}
			}

			function onBreakResult(numLeft){
				var currEnd = Number(document.getElementById('playerEND').innerHTML);
				currEnd-=Math.round((.5+Math.random())*(breakingPlayer.attack+selectedAttack.statMod));
				if (currEnd<=0){
					currEnd=0;
					//document.getElementById('playerEND').innerHTML=currEnd;
					updateStat('playerEND', currEnd);
					writeInfo(breakingPlayer.name + " steals the ball!");
					var napped=false;
					if (Math.random()<selectedAttack.effectChance){
						if (selectedAttack.techName.substring(0,3)=='Nap'){
							writeInfo(currentPlayer.name + " falls asleep!");
							napped=true;
						}
					}
					if (teamWithBall==1){
						teamWithBall=2;
					} else {
						teamWithBall=1;
					}
					currentPlayer.continueEndure(false, napped, function(){delayResumeGame(breakingPlayer);});
					breakingPlayer.continueTackle(true);
					//updateCurrentPlayer(breakingPlayer);
				} else {
					//document.getElementById('playerEND').innerHTML=currEnd;
					updateStat('playerEND', currEnd);
					currentPlayer.continueEndure(true, false, function(){animateBreak(numLeft)});
				}
			}

			function updateMinimap(){
				//reset canvas
				//minimapContext.globalAlpha=0.4;
				//minimapContext.rect(0,0,minimapCanvas.width,minimapCanvas.width);
				minimapContext.clearRect(0,0,minimapCanvas.width,minimapCanvas.width);
				//minimapContext.fillStyle="grey";
				//minimapContext.fill();
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
					if (!myTeam[i].isSleeping){
						minimapContext.strokeStyle="#FFCC00";
						minimapContext.stroke();
						minimapContext.fillStyle = "#FFCC00";
					} else {
						minimapContext.strokeStyle="#000000";
						minimapContext.stroke();
						minimapContext.fillStyle = "#000000";
					}
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
					if (!oppTeam[i].isSleeping){
						minimapContext.strokeStyle="#FF0000";
						minimapContext.fillStyle = "#FF0000";
					} else {
						minimapContext.strokeStyle="#000000";
						minimapContext.fillStyle = "#000000";
					}
					minimapContext.stroke();
					minimapContext.fill();
				}

				//dev
				minimapContext.beginPath();
				minimapContext.arc(minimapCanvas.width*(110+camera.position.x)/220, minimapCanvas.width*(110+camera.position.z)/220, minimapCanvas.width/50, 0, 2 * Math.PI, false);
				minimapContext.closePath();
				minimapContext.fillStyle = 'white';
				minimapContext.fill();

				if (currentPlayer){
					var playerRot=currentPlayer.currentRotation+Math.PI;
					var playerX=minimapCanvas.width*(110+currentPlayer.currentPosition.x)/220-Math.cos(playerRot)*minimapCanvas.width/24;
					var playerY=minimapCanvas.width*(110+currentPlayer.currentPosition.z)/220+Math.sin(playerRot)*minimapCanvas.width/24;
					minimapContext.beginPath();
					minimapContext.arc(playerX, playerY, minimapCanvas.width/14, 0, 2 * Math.PI, false);
					minimapContext.arc(playerX, playerY, minimapCanvas.width/15, 0, 2 * Math.PI, true);
					minimapContext.closePath();
					minimapContext.fillStyle = 'white';
					minimapContext.fill();
				}
				
				if (targettedPlayer!=null&&currAction=="targetting"){
					minimapContext.beginPath();
					minimapContext.arc(minimapCanvas.width*(110+targettedPlayer.currentPosition.x)/220, minimapCanvas.width*(110+targettedPlayer.currentPosition.z)/220, minimapCanvas.width/14, 0, 2 * Math.PI, false);
					minimapContext.arc(minimapCanvas.width*(110+targettedPlayer.currentPosition.x)/220, minimapCanvas.width*(110+targettedPlayer.currentPosition.z)/220, minimapCanvas.width/15, 0, 2 * Math.PI, true);
					minimapContext.closePath();
					minimapContext.fillStyle = 'white';
					minimapContext.fill();
				}
				if (currAction=="passedBall"||currAction=="shotBall"){
					minimapContext.beginPath();
					minimapContext.arc(minimapCanvas.width*(110+blitzball.position.x)/220, minimapCanvas.width*(110+blitzball.position.z)/220, minimapCanvas.width/50, 0, 2 * Math.PI, false);
					minimapContext.closePath();
					minimapContext.fillStyle = 'white';
					minimapContext.fill();
				}
			}
			
			function promptAttackMenu(){
				console.log(currAction);
				document.getElementById('actionMenu').style.height=((attackOptions.length)*4)+"vmin";
				for (var i=0; i<6; i++){
					document.getElementById('menu'+(i+1)).style.display='none';
				}
				for (var i=0; i<attackOptions.length; i++){
					document.getElementById('menu'+(i+1)).style.display='';
					document.getElementById('menu'+(i+1)).innerHTML=attackOptions[i].techName;
				}
				MAXITEMS=attackOptions.length;
				document.getElementById('actionMenu').style.display='';
				navMenu.updateActiveSelector('selector', MAXITEMS, 1);
				attackAction="attackSelection";
			}
			
			function executeBreak(){
				timerActive=true;
				inMenu=false;
				currentPlayer.animateEndure(function(){onBreakResult(numBreaksLeft-1)});
				var mv=currentPlayer.currentPosition.clone().sub(breakingPlayer.currentPosition).multiplyScalar(1.5);
				breakingPlayer.animateTackle(mv);
			}

			var numBreaksLeft=0;
			function animateBreak(numLeft){
				inMenu=true;
				timerActive=false;
				document.getElementById('actionMenu').style.display='none';
				if (numLeft>0){
					/*if (defendingPlayers!=null&&defendingPlayers.length>=numLeft){
						console.log('invalid number of break attempts: ' + numLeft);
						showMainActionMenu();
					}*/
					breakAttackerNum++;
					breakingPlayer=defendingPlayers.shift();
					writeInfo(currentPlayer.name + " breaks to " + breakingPlayer.name);
					attackOptions=[];
					numBreaksLeft=numLeft-1;
					var normalTackle = {
							effectChance:0,
							hpCost:0, 
							statMod:0,
							techDescription:"",
							techID:null,
							techName:"Normal Tackle",
							techType:"ATTACK"
						};
					attackOptions.push(normalTackle);
					for (var i=0; i<breakingPlayer.techs.length; i++){
						if (breakingPlayer.techs[i].techType=='ATTACK'&&breakingPlayer.techs[i].hpCost<=breakingPlayer.hp){
							attackOptions.push(breakingPlayer.techs[i]);
						}
					}
					if (attackOptions.length>1&&teamWithBall==2){//player is attacking
						promptAttackMenu();
					} else {
						if (attackOptions.length>1){
							selectedAttack = attackOptions[Math.floor(Math.random()*(attackOptions.length))];
						} else {
							selectedAttack=normalTackle;
						}
						if (selectedAttack!=normalTackle){
							writeInfo(selectedAttack.techName);
							setTimeout(function(){
								executeBreak();
								setupTechCopy();
							}, 2000);
						} else {
							executeBreak();
						}
					}
				} else {
					if (currAction=="breaktargetting"){
						if (teamWithBall==1){
							timerActive=false;
							currAction="targetting";
							document.getElementById('actionMenu').style.display='';

							if (currentPlayer!=myTeamLW){
								targettedPlayer=myTeamLW;
							} else {
								targettedPlayer=myTeamRW;
							}
							highlightTargettedPlayer();
							
						} else {
							var lwFreedom=0;
							var rwFreedom=0;
							var mfFreedom=0;
							var lbFreedom=0;
							var rbFreedom=0;
							if (currentPlayer!=oppTeamLW){
								lwFreedom = Math.random()/2*(myTeamLB.currentPosition.distanceTo(oppTeamLW.currentPosition)+myTeamRB.currentPosition.distanceTo(oppTeamLW.currentPosition)+myTeamMF.currentPosition.distanceTo(oppTeamLW.currentPosition));
							}
							if (currentPlayer!=oppTeamRW){
								rwFreedom = Math.random()/2*(myTeamLB.currentPosition.distanceTo(oppTeamRW.currentPosition)+myTeamRB.currentPosition.distanceTo(oppTeamRW.currentPosition)+myTeamMF.currentPosition.distanceTo(oppTeamRW.currentPosition));
							}
							if (currentPlayer!=oppTeamMF){
								mfFreedom = Math.random()/2*(myTeamLB.currentPosition.distanceTo(oppTeamMF.currentPosition)+myTeamRB.currentPosition.distanceTo(oppTeamMF.currentPosition)+myTeamMF.currentPosition.distanceTo(oppTeamMF.currentPosition));
							}
							if (currentPlayer!=oppTeamLB){
								lbFreedom = Math.random()/2*(myTeamRW.currentPosition.distanceTo(oppTeamLB.currentPosition)+myTeamMF.currentPosition.distanceTo(oppTeamLB.currentPosition));
							}
							if (currentPlayer!=oppTeamRB){
								lbFreedom = Math.random()/2*(myTeamRW.currentPosition.distanceTo(oppTeamRB.currentPosition)+myTeamMF.currentPosition.distanceTo(oppTeamRB.currentPosition));
							}
							if (lwFreedom>rwFreedom&&lwFreedom>mfFreedom&&lwFreedom>lbFreedom&&lwFreedom>rbFreedom){
								targettedPlayer=oppTeamLW;
							} else if (rwFreedom>lwFreedom&&rwFreedom>mfFreedom&&rwFreedom>lbFreedom&&rwFreedom>rbFreedom){
								targettedPlayer=oppTeamRW;
							} else if (lbFreedom>lwFreedom&&lbFreedom>mfFreedom&&lbFreedom>rwFreedom&&lbFreedom>rbFreedom){
								targettedPlayer=oppTeamLB;
							} else if (rbFreedom>lwFreedom&&rbFreedom>mfFreedom&&rbFreedom>lbFreedom&&rbFreedom>rwFreedom){
								targettedPlayer=oppTeamRB;
							} else {
								if (currentPlayer!=oppTeamMF){
									targettedPlayer=oppTeamMF;
								} else {
									targettedPlayer=oppTeamLW;
								}
							}
							pass();
						}
					} else if (currAction=="breakshoot"){
						shoot();
					} else if (currAction=="breakdribble"){
						updateCurrentPlayer(currentPlayer);
						resumeActiveGame();
					}
					//showMainActionMenu();
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
				document.getElementById('playerStats').style.visibility='';
				document.getElementById('break1Stats').style.visibility='hidden';
				document.getElementById('break2Stats').style.visibility='hidden';
				document.getElementById('break3Stats').style.visibility='hidden';
				document.getElementById('break4Stats').style.visibility='hidden';
				document.getElementById('break5Stats').style.visibility='hidden';
				currentPlayer.hasBall=true;
				for (var i=0; i<allPlayers.length; i++){
					allPlayers[i].chasingPosition=null;
				}
				ballQuadrant=0;

				if (teamWithBall==2){
					triggerTimer=-1;
					//setTimeout(triggerAIStop, '2000');
				}
			}

			var updateActiveOverride=false;

			function onBallArrive(){
				blitzball.visible=false;
				timeSinceLastTrigger=0;
				if (currAction=="shotBall"){
					currAction="saving";
					var keeper;
					if (teamWithBall==1){
						keeper=oppTeamGK;
						camera.position.x=-75;
						camera.position.z=0;
						cameraTarget.set(-100, 0, 0);
					} else {
						keeper=myTeamGK;
						camera.position.x=75;
						camera.position.z=0;
						cameraTarget.set(100, 0, 0);
					}
					var goalNum=Math.round(currStat-((.5+Math.random())*keeper.cat));
					if (goalNum<=0){
						if (Math.random()<.5){
							if (teamWithBall==1){
								targettedPlayer=oppTeam[Math.floor(Math.random()*5)];
								teamWithBall=2;
							} else {
								targettedPlayer=myTeam[Math.floor(Math.random()*5)];
								teamWithBall=1;
							}
							
							keeper.animateGoalieSaveGrab(function(){
								updateStat('playerSHT', 0);
								writeInfo(keeper.name + ' saves the ball!');
							}, function(){
								targettedPlayer.lookAt(keeper.currentPosition);
								keeper.animatePass(function(){
									if (targettedPlayer.isSleeping){
										targettedPlayer.animateWakeup(function(){
											writeInfo(targettedPlayer.name + ' dropped the pass');
											if (targettedPlayer.isSleeping){
												targettedPlayer.wakeup();
												writeInfo(targettedPlayer.name + ' woke up');
											}
											var currReceiver;
											var minDistance=200;
											for (var i=0; i<myTeam.length; i++){
												if (myTeam[i]!=targettedPlayer){
													if (!myTeam[i].isSleeping&&myTeam[i].currentPosition.distanceTo(targettedPlayer.currentPosition)<minDistance){
														currReceiver=myTeam[i];
														minDistance=myTeam[i].currentPosition.distanceTo(targettedPlayer.currentPosition);
														teamWithBall=1;
													}
												}
											}
											for (var i=0; i<oppTeam.length; i++){
												if (oppTeam[i]!=targettedPlayer){
													if (!oppTeam[i].isSleeping&&oppTeam[i].currentPosition.distanceTo(targettedPlayer.currentPosition)<minDistance){
														currReceiver=oppTeam[i];
														minDistance=oppTeam[i].currentPosition.distanceTo(targettedPlayer.currentPosition);
														teamWithBall=2;
													}
												}
											}
											targettedPlayer=null;
											grabLooseBall(currReceiver);
										});
									} else {
										grabLooseBall(targettedPlayer);
									}
								});
							});
						} else {
							if (selectedTech!=null){
								if (selectedTech.techName=='Venom Pass'){
									writeInfo(keeper.name + " is poisoned!");//TODO
								}
							}
							keeper.animateGoalieSaveDeflect(function(){
								updateStat('playerSHT', 0);
								writeInfo(keeper.name + ' blocks the ball!');
							}, function(){
								var currDist = 200;
								var currWinner=null;
								for (var i=0; i<myTeam.length; i++){
									if (!myTeam[i].isSleeping&&myTeam[i].currentPosition.distanceTo(keeper.currentPosition)<currDist){
										currWinner=myTeam[i];
										currDist=myTeam[i].currentPosition.distanceTo(keeper.currentPosition);
										teamWithBall=1;
									}
								}
								for (var i=0; i<oppTeam.length; i++){
									if (!oppTeam[i].isSleeping&&oppTeam[i].currentPosition.distanceTo(keeper.currentPosition)<currDist){
										currWinner=oppTeam[i];
										currDist=oppTeam[i].currentPosition.distanceTo(keeper.currentPosition);
										teamWithBall=2;
									}
								}
								keeper.ball.visible=false;
								grabLooseBall(currWinner);
							});
						}
					} else {
						keeper.animateGoalieFailSave(blitzball, function(){
							updateStat('playerSHT', goalNum);
							writeInfo(currentPlayer.name + ' scores!');
							timerActive=false;
							cameraZoom = new THREE.Vector3(0, 10, 0);
							zoomLeft=3;
							//TODO increment score
							setTimeout(function(){
								if (teamWithBall==1){
									team1Score++;
									trackTimer=0;
									statUpdating="team1Score";
									document.getElementById(statUpdating).innerHTML=team1Score;
									document.getElementById(statUpdating).style.color='white';
									document.getElementById(statUpdating).style.fontSize='5vmin';
									blitzoffTeam=2;
								} else {
									team2Score++;
									trackTimer=0;
									statUpdating="team2Score";
									document.getElementById(statUpdating).innerHTML=team2Score;
									document.getElementById(statUpdating).style.color='white';
									document.getElementById(statUpdating).style.fontSize='5vmin';
									blitzoffTeam=1;
								}
								cameraZoom = new THREE.Vector3(0, 10, 300);
								zoomLeft=2;
								cameraTarget.set(0, 10, 0);
								setTimeout(blitzoff, '5000');
							}, '3000');
						});
					}
				} else if (currAction=="passedBall"){
					timeSinceLastTrigger=1;
					if (currStat>0&&!targettedPlayer.isSleeping){
						currAction="catching";
						var vec = currentPlayer.currentPosition.clone().sub(targettedPlayer.currentPosition);
						vec.multiplyScalar(15/vec.length());
						camera.position.addVectors(targettedPlayer.currentPosition, vec);
						//updateCurrentPlayer(targettedPlayer);
						cameraTarget.set(targettedPlayer.currentPosition.x, 0, targettedPlayer.currentPosition.z);
						targettedPlayer.animateCatchBall(function(){
							delayResumeGame(targettedPlayer);
							targettedPlayer=null;
						});
						currStat=0;
					} else {
						currAction="droppedBall";
						var vec = currentPlayer.currentPosition.clone().sub(targettedPlayer.currentPosition);
						vec.multiplyScalar(15/vec.length());
						camera.position.addVectors(targettedPlayer.currentPosition, vec);
						cameraTarget.set(targettedPlayer.currentPosition.x, 0, targettedPlayer.currentPosition.z);
						var dropCallback = function(){
							writeInfo(targettedPlayer.name + ' dropped the pass');
							if (targettedPlayer.isSleeping){
								targettedPlayer.wakeup();
								writeInfo(targettedPlayer.name + ' woke up');
							}
							var currReceiver;
							var minDistance=200;
							for (var i=0; i<myTeam.length; i++){
								if (myTeam[i]!=targettedPlayer){
									if (!myTeam[i].isSleeping&&myTeam[i].currentPosition.distanceTo(targettedPlayer.currentPosition)<minDistance){
										currReceiver=myTeam[i];
										minDistance=myTeam[i].currentPosition.distanceTo(targettedPlayer.currentPosition);
										teamWithBall=1;
									}
								}
							}
							for (var i=0; i<oppTeam.length; i++){
								if (oppTeam[i]!=targettedPlayer){
									if (!oppTeam[i].isSleeping&&oppTeam[i].currentPosition.distanceTo(targettedPlayer.currentPosition)<minDistance){
										currReceiver=oppTeam[i];
										minDistance=oppTeam[i].currentPosition.distanceTo(targettedPlayer.currentPosition);
										teamWithBall=2;
									}
								}
							}
							targettedPlayer=null;
							grabLooseBall(currReceiver);
						};
						if (targettedPlayer.isSleeping){
							targettedPlayer.animateWakeup(dropCallback);
						} else {
							targettedPlayer.animateDropCatch(dropCallback);
						}
					}
				}
				selectedTech=null;
			}

			var techCopying = false;
			var techCopyMatch=false;
			var toggleCount=0;
			var techCopyPlayer=null;
			function setupTechCopy(){
				techCopyMatch=false;
				toggleCount=0;
				techCopyPlayer=null;
				if (selectedTech!=null&&teamWithBall==2){
					techCopying = true;
					var playerOptions=[];
					for (var i=0; i<myTeam[i].length; i++){
						if (myTeam[i].techCopyTarget==currentPlayer.playerID){
							for (var j=0; i<myTeam[i].learnableTechs.length; j++){
								if (myTeam[i].learnableTechs[j].techID==selectedTech.techID){
									playerOptions.push(myTeam[i]);
									break;
								}
							}
						}
					}
					playerOptions.push(myTeam[0]);//TODO testing
					if (playerOptions.length>0){
						techCopyPlayer = playerOptions[Math.floor(Math.random()*playerOptions.length)];
						document.getElementById('techCopy').style.color='#708090';
						document.getElementById('techCopy').style.display='';
						toggleTechCopy();
					}
				}
			}
			
			function toggleTechCopy(){
				setTimeout(function(){
					toggleCount++;
					if (toggleCount>5){
						techCopyMatch=false;
						techCopying = false;
						document.getElementById('techCopy').style.display='none';
					} else if (techCopying){
						if (!techCopyMatch){
							techCopyMatch=true;
							document.getElementById('techCopy').style.color='#FFFFFF';
						} else {
							techCopyMatch=false;
							document.getElementById('techCopy').style.color='#708090';
						}
						toggleTechCopy();
					}
				}, '400');
			}

			function blockInterim(){
				if (currStat>0){
					if (currAction=="blockPass"){
						setTimeout(animatePassBlock, '1000');
					} else if (currAction=="blockShot"){
						setTimeout(animateShotBlock, '1000');
					}
				} else {
					if (teamWithBall==1){
						teamWithBall=2;
					} else {
						teamWithBall=1;
					}

					delayResumeGame(animatingPlayer);
				}
			}

			function animateBlock(){
				techCopying=false;
				techCopyMatch=false;
				document.getElementById('techCopy').style.display='none';
				/*animatingPlayer=defendingPlayers[0];
				currStat = currStat-((.5+Math.random())*defendingPlayers[0].block);
				defendingPlayers.shift();
				setTimeout(animatePassBlock, '1500');*/
				animatingPlayer=defendingPlayers.shift();
				currStat = currStat-Math.round((.5+Math.random())*animatingPlayer.block);
				if (teamWithBall==1){
					camera.position.x=animatingPlayer.currentPosition.x+7;
				} else {
					camera.position.x=animatingPlayer.currentPosition.x-7;
				}
				//camera.position.y=0;
				camera.position.z=animatingPlayer.currentPosition.z+7;
				cameraTarget.set(animatingPlayer.currentPosition.x, 0, animatingPlayer.currentPosition.z);
				var statName='playerPAS';
				if (currAction=='blockShot'){
					statName='playerSHT';
				}
				if (currStat>0){
					var napped=false;
					if (selectedTech!=null&&Math.random()<selectedTech.effectChance){
						if (selectedTech.techName.substring(0,3)=='Nap'){
							writeInfo(animatingPlayer.name + " falls asleep!");
							napped=true;
						}
					}
					if (napped){
						animatingPlayer.animateBlockSleep(function(){updateStat(statName, currStat); writeInfo(animatingPlayer.name + ' got a hand on it')}, blockInterim);
					} else {
						animatingPlayer.animateBlockFail(function(){updateStat(statName, currStat); writeInfo(animatingPlayer.name + ' got a hand on it')}, blockInterim);
					}
				} else {
					animatingPlayer.animateGrabBall(function(){updateStat(statName, 0); writeInfo(animatingPlayer.name + ' grabbed the ball');}, blockInterim);
				}
			}			

			function animateShotBlock(){
				if (defendingPlayers==null||defendingPlayers.length==0){
					currAction="shotBall";
					//triggerBallMove();
					ballMoveIteration=0;
					blitzball.visible=true;
					blitzball.position.set(currentPlayer.currentPosition.x, 0, currentPlayer.currentPosition.z);
					if (teamWithBall==1){
						ballTrajectory=goal2Loc.clone().sub(blitzball.position);
					} else {
						ballTrajectory=goal1Loc.clone().sub(blitzball.position);
					}
					var ballmv = ballTrajectory.clone().sub(blitzball.position).multiplyScalar(1/ballTrajectory.length());
					blitzball.position.addVectors(blitzball.position, ballmv);
					ballTrajectory.sub(ballmv);
					//blitzball.position.y=3;
				} else {
					currAction="blockShot";
					animateBlock();
				}
			}

			function animatePassBlock(){
				if (defendingPlayers==null||defendingPlayers.length==0){
					currAction="passedBall";
					//triggerBallMove();
					ballMoveIteration=0;
					blitzball.visible=true;
					ballTrajectory=targettedPlayer.currentPosition.clone().sub(currentPlayer.currentPosition);
					var ballmv = ballTrajectory.clone().sub(blitzball.position).multiplyScalar(1/ballTrajectory.length());
					blitzball.position.addVectors(currentPlayer.currentPosition, ballmv);
					blitzball.position.y=3;
					writeInfo(currentPlayer.name + ' passes to ' + targettedPlayer.name);
				} else {
					currAction="blockPass";
					animateBlock();
				}
			}

			function pass(){
				inMenu=false;
				timerActive=true;
				currAction="animPass";
				currentPlayer.lookAt(targettedPlayer.currentPosition);
				if (targettedPlayer.currentPosition.x<currentPlayer.currentPosition.x){
					camera.position.x=currentPlayer.currentPosition.x-7;
				} else {
					camera.position.x=currentPlayer.currentPosition.x+7;
				}
				//camera.position.y=0;
				camera.position.z=currentPlayer.currentPosition.z+7;
				cameraTarget.set(currentPlayer.currentPosition.x, 0, currentPlayer.currentPosition.z);
				document.getElementById('actionMenu').style.display='none';
				if (selectedTech!=null){
					setTimeout(function(){
						targettedPlayer.lookAt(currentPlayer.currentPosition);
						currentPlayer.animatePass(animatePassBlock);
						currStat=currentPlayer.pass+selectedTech.statMod;
						setupTechCopy();
					}, '1000');
				} else {
					setTimeout(function(){
						targettedPlayer.lookAt(currentPlayer.currentPosition);
						currentPlayer.animatePass(animatePassBlock);
					}, '1000');
					currStat=currentPlayer.pass;
				}
				//currentPlayer=destination;
			}
			
			function setupStatReel(minShot, maxShot){
				//TODO create function
			}

			function shoot(){
				inMenu=false;
				timerActive=true;
				currAction="animShot";
				
				if (teamWithBall==1){
					camera.position.x=currentPlayer.currentPosition.x-7;
				} else {
					camera.position.x=currentPlayer.currentPosition.x+7;
				}
				//camera.position.y=0;
				camera.position.z=currentPlayer.currentPosition.z+7;
				document.getElementById('actionMenu').style.display='none';
				if (selectedTech!=null){
					setTimeout(function(){
						if (selectedTech.techID==1){
							currentPlayer.animateSphereShot(animateShotBlock);
							cameraTarget.set(currentPlayer.currentPosition.x, 2, currentPlayer.currentPosition.z);
							setupStatReel(currentPlayer.shot-5, currentPlayer.shot+10);
						} else {
							currentPlayer.animateShoot(animateShotBlock);
							cameraTarget.set(currentPlayer.currentPosition.x, 0, currentPlayer.currentPosition.z);
							currStat=currentPlayer.shot+selectedTech.statMod;
						}
						setupTechCopy();
					}, '1000');
				} else {
					setTimeout(function(){currentPlayer.animateShoot(animateShotBlock);}, '1000');
					currStat=currentPlayer.shot;
				}
			}
			
			function blitzoff(){
				currAction="blitzoff";
				for (var i=0; i<myTeam.length; i++){
					myTeam[i].currentRotation=Math.PI;
					myTeam[i].root.rotation.y=3*Math.PI/2;
					myTeam[i].wakeup();
				}
				for (var i=0; i<oppTeam.length; i++){
					oppTeam[i].currentRotation=0;
					oppTeam[i].root.rotation.y=Math.PI/2;
					oppTeam[i].wakeup();
				}
				myTeamLW.currentPosition.set(20, 0, 50);
				myTeamMF.currentPosition.set(40, 0, 0);
				myTeamRW.currentPosition.set(20, 0, -50);
				myTeamLB.currentPosition.set(60, 0, 20);
				myTeamRB.currentPosition.set(60, 0, -20);
				oppTeamLW.currentPosition.set(-20, 0, -50);
				oppTeamMF.currentPosition.set(-40, 0, 0);
				oppTeamRW.currentPosition.set(-20, 0, 50);
				oppTeamLB.currentPosition.set(-60, 0, -20);
				oppTeamRB.currentPosition.set(-60, 0, 20);
				blitzball.position.set(0,0,0);
				camera.position.set(0,1,3);
				cameraTarget.set(0,0,0);
				document.getElementById('overlay').innerHTML="Blitzoff!";
				document.getElementById('overlay').style.display="";
				trackTimer=0;
			}

			function grabLooseBall(player){
				currAction="grab";
				writeInfo(player.name + ' grabbed the ball');
				document.getElementById('overlay').innerHTML="";
				document.getElementById('overlay').style.display="none";
				cameraTarget.x=player.currentPosition.x;
				cameraTarget.z=player.currentPosition.z;
				cameraTarget.y=0;
				camera.position.x=player.currentPosition.x-7;
				camera.position.z=player.currentPosition.z+7;
				player.animateGrabBall(null, function(){delayResumeGame(player);});
			}

			function endBlitzoff(){
				blitzball.visible=false;
				timeSinceLastTrigger=10;
				if (blitzoffTeam==1){
					teamWithBall=1;
					grabLooseBall(myTeamMF);
				} else {
					teamWithBall=2;
					grabLooseBall(oppTeamMF);
				}
			}

			function updateActiveNumbers(){
				if (!updateActiveOverride){
					var change=Math.ceil(currStat/5);
					currStat-=change;
					if (currAction=="shotBall"){
						document.getElementById('playerSHT').innerHTML=currStat;
					} else if (currAction=="passedBall"){
						document.getElementById('playerPAS').innerHTML=currStat;
					}
				}
			}

			var ballQuadrant=0;
			function computeRestingPositions(){
				if (ballQuadrant!=1&&currentPlayer.currentPosition.x<-50){
					ballQuadrant=1;
					if (teamWithBall==1){
						myTeamLW.restingPosition.set(-80, 0, 25);
						myTeamMF.restingPosition.set(-65, 0, 0);
						myTeamRW.restingPosition.set(-80, 0, -25);
						myTeamLB.restingPosition.set(0, 0, 25);
						myTeamRB.restingPosition.set(0, 0, -25);
						oppTeamLW.restingPosition.set(-65, 0, -25);
						oppTeamMF.restingPosition.set(-80, 0, 0);
						oppTeamRW.restingPosition.set(-65, 0, 25);
						oppTeamLB.restingPosition.set(-85, 0, -15);
						oppTeamRB.restingPosition.set(-85, 0, 15);
					} else {
						myTeamLW.restingPosition.set(-55, 0, 50);
						myTeamMF.restingPosition.set(-45, 0, 0);
						myTeamRW.restingPosition.set(-55, 0, -50);
						myTeamLB.restingPosition.set(25, 0, 25);
						myTeamRB.restingPosition.set(25, 0, -25);
						oppTeamLW.restingPosition.set(-40, 0, -50);
						oppTeamMF.restingPosition.set(-55, 0, 0);
						oppTeamRW.restingPosition.set(-40, 0, 50);
						oppTeamLB.restingPosition.set(-70, 0, -25);
						oppTeamRB.restingPosition.set(-70, 0, 25);
					}
				} else if (ballQuadrant!=2&&currentPlayer.currentPosition.x<0&&currentPlayer.currentPosition.x>=-50){
					ballQuadrant=2;
					if (teamWithBall==1){
						myTeamLW.restingPosition.set(-55, 0, 50);
						myTeamMF.restingPosition.set(-45, 0, 0);
						myTeamRW.restingPosition.set(-55, 0, -50);
						myTeamLB.restingPosition.set(25, 0, 25);
						myTeamRB.restingPosition.set(25, 0, -25);
						oppTeamLW.restingPosition.set(-40, 0, -50);
						oppTeamMF.restingPosition.set(-55, 0, 0);
						oppTeamRW.restingPosition.set(-40, 0, 50);
						oppTeamLB.restingPosition.set(-70, 0, -25);
						oppTeamRB.restingPosition.set(-70, 0, 25);
					} else {
						myTeamLW.restingPosition.set(-35, 0, 50);
						myTeamMF.restingPosition.set(-10, 0, 0);
						myTeamRW.restingPosition.set(-35, 0, -50);
						myTeamLB.restingPosition.set(35, 0, 25);
						myTeamRB.restingPosition.set(35, 0, -25);
						oppTeamLW.restingPosition.set(10, 0, -50);
						oppTeamMF.restingPosition.set(-10, 0, 0);
						oppTeamRW.restingPosition.set(10, 0, 50);
						oppTeamLB.restingPosition.set(-45, 0, -25);
						oppTeamRB.restingPosition.set(-45, 0, 25);
					}
				} else if (ballQuadrant!=3&&currentPlayer.currentPosition.x>0&&currentPlayer.currentPosition.x<=50){
					ballQuadrant=3;
					if (teamWithBall==1){
						myTeamLW.restingPosition.set(-10, 0, 50);
						myTeamMF.restingPosition.set(10, 0, 0);
						myTeamRW.restingPosition.set(-10, 0, -50);
						myTeamLB.restingPosition.set(45, 0, 25);
						myTeamRB.restingPosition.set(45, 0, -25);
						oppTeamLW.restingPosition.set(35, 0, -50);
						oppTeamMF.restingPosition.set(10, 0, 0);
						oppTeamRW.restingPosition.set(35, 0, 50);
						oppTeamLB.restingPosition.set(-35, 0, -25);
						oppTeamRB.restingPosition.set(-35, 0, 25);
					} else {
						myTeamLW.restingPosition.set(40, 0, 50);
						myTeamMF.restingPosition.set(55, 0, 0);
						myTeamRW.restingPosition.set(45, 0, -50);
						myTeamLB.restingPosition.set(70, 0, 25);
						myTeamRB.restingPosition.set(70, 0, -25);
						oppTeamLW.restingPosition.set(55, 0, -50);
						oppTeamMF.restingPosition.set(45, 0, 0);
						oppTeamRW.restingPosition.set(50, 0, 50);
						oppTeamLB.restingPosition.set(25, 0, -25);
						oppTeamRB.restingPosition.set(25, 0, 25);
					}
				} else if (ballQuadrant!=4&&currentPlayer.currentPosition.x>50){
					ballQuadrant=4;
					if (teamWithBall==1){
						myTeamLW.restingPosition.set(40, 0, 50);
						myTeamMF.restingPosition.set(55, 0, 0);
						myTeamRW.restingPosition.set(45, 0, -50);
						myTeamLB.restingPosition.set(70, 0, 25);
						myTeamRB.restingPosition.set(70, 0, -25);
						oppTeamLW.restingPosition.set(55, 0, -50);
						oppTeamMF.restingPosition.set(45, 0, 0);
						oppTeamRW.restingPosition.set(50, 0, 50);
						oppTeamLB.restingPosition.set(25, 0, -25);
						oppTeamRB.restingPosition.set(25, 0, 25);
					} else {
						myTeamLW.restingPosition.set(65, 0, 25);
						myTeamMF.restingPosition.set(80, 0, 0);
						myTeamRW.restingPosition.set(65, 0, -25);
						myTeamLB.restingPosition.set(85, 0, 15);
						myTeamRB.restingPosition.set(85, 0, -15);
						oppTeamLW.restingPosition.set(80, 0, -25);
						oppTeamMF.restingPosition.set(65, 0, 0);
						oppTeamRW.restingPosition.set(80, 0, 25);
						oppTeamLB.restingPosition.set(0, 0, -25);
						oppTeamRB.restingPosition.set(0, 0, 25);
					}
				}
				if (teamWithBall==1){
					if (timeSinceLastTrigger>2){
						for (var i=0; i<oppTeam.length; i++){
							oppTeam[i].testViewBallCarrier(currentPlayer.currentPosition);
						}
					}
				} else {
					if (timeSinceLastTrigger>2){
						for (var i=0; i<myTeam.length; i++){
							myTeam[i].testViewBallCarrier(currentPlayer.currentPosition);
						}
					}
				}
			}

			function triggerAIStop(){
				triggerTimer=0;
				if (currentPlayer.currentPosition.x>85){
					triggerBreak(true);
				} else if (currentPlayer.currentPosition.x>0){
					if (currentPlayer==oppTeamLB||currentPlayer==oppTeamRB){
						if (Math.random()<.85){
							triggerBreak(true);
						} else {
							//setTimeout(triggerAIStop, '1000');
						}
					} else {
						if (Math.random()<.3){
							triggerBreak(true);
						} else {
							//setTimeout(triggerAIStop, '1000');
						}
					}
				} else if (currentPlayer==oppTeamLB||currentPlayer==oppTeamRB){
					if (Math.random()<.3){
						triggerBreak(true);
					} else {
						//setTimeout(triggerAIStop, '1000');
					}
				} else {
					if (Math.random()<.15){
						triggerBreak(true);
					} else {
						//setTimeout(triggerAIStop, '1000');
					}
				}
			}

			function computeAIMove(){
				if (currentPlayer==oppTeamLW){
					controls.moveRight=true;
					controls.moveLeft=false;
					if (currentPlayer.currentPosition.z>-20){
						controls.moveForward=true;
						controls.moveBackward=false;
					} else if (currentPlayer.currentPosition.z>-80){
						controls.moveBackward=false;
						if (myTeamRW.currentPosition.x>currentPlayer.currentPosition.x&&myTeamRW.currentPosition.z>currentPlayer.currentPosition.z){//opposing striker in front and above, escape up
							controls.moveForward=true;
						} else if (myTeamMF.currentPosition.x>currentPlayer.currentPosition.x&&myTeamMF.currentPosition.z>currentPlayer.currentPosition.z&&myTeamMF.chasingPosition!=null){
							controls.moveForward=true;
						} else {
							controls.moveForward=false;
						}
					} else if (currentPlayer.currentPosition.x>50){
						controls.moveForward=false;
						controls.moveBackward=true;
					} else {
						controls.moveForward=false;
						controls.moveBackward=false;
					}
				} else if (currentPlayer==oppTeamRW){
					controls.moveRight=true;
					controls.moveLeft=false;
					if (currentPlayer.currentPosition.z<20){
						controls.moveForward=false;
						controls.moveBackward=true;
					} else if (currentPlayer.currentPosition.z<80){
						controls.moveForward=false;
						if (myTeamLW.currentPosition.x>currentPlayer.currentPosition.x&&myTeamLW.currentPosition.z<currentPlayer.currentPosition.z){
							controls.moveBackward=true;
						} else if (myTeamMF.currentPosition.x>currentPlayer.currentPosition.x&&myTeamMF.currentPosition.z<currentPlayer.currentPosition.z&&myTeamMF.chasingPosition!=null){
							controls.moveBackward=true;
						} else {
							controls.moveBackward=false;
						}
					} else if (currentPlayer.currentPosition.x>50){
						controls.moveForward=true;
						controls.moveBackward=false;
					} else {
						controls.moveForward=false;
						controls.moveBackward=false;
					}
				} else if (currentPlayer==oppTeamMF){
					controls.moveRight=true;
					controls.moveLeft=false;
					var belowCnt=0;
					var aboveCnt;
					for (var i=0; i<myTeam.length; i++){
						if (myTeam[i].chasingPosition==null){
							if (myTeam[i].currentPosition.z<currentPlayer.currentPosition.z){
								aboveCnt++;
							} else {
								belowCnt++
							}
						}
					}
					if (aboveCnt<belowCnt){
						controls.moveForward=true;
						controls.moveBackward=false;
					} else if (aboveCnt>belowCnt){
						controls.moveForward=false;
						controls.moveBackward=true;
					} else {
						controls.moveForward=false;
						controls.moveBackward=false;
					}
				} else if (currentPlayer==oppTeamLB){
					controls.moveRight=true;
					controls.moveLeft=false;
					if (currentPlayer.currentPosition.z>-20){
						controls.moveForward=true;
						controls.moveBackward=false;
					} else if (currentPlayer.currentPosition.z>-70){
						controls.moveBackward=false;
						if (myTeamRW.currentPosition.x>currentPlayer.currentPosition.x&&myTeamRW.currentPosition.z>currentPlayer.currentPosition.z){//opposing striker in front and above, escape up
							controls.moveForward=true;
						} else if (myTeamMF.currentPosition.x>currentPlayer.currentPosition.x&&myTeamMF.currentPosition.z>currentPlayer.currentPosition.z&&myTeamMF.chasingPosition!=null){
							controls.moveForward=true;
						} else {
							controls.moveForward=false;
						}
					} else if (currentPlayer.currentPosition.x>50){
						controls.moveForward=false;
						controls.moveBackward=true;
					} else {
						controls.moveForward=false;
						controls.moveBackward=false;
					}
				} else if (currentPlayer==oppTeamRB){
					controls.moveRight=true;
					controls.moveLeft=false;
					if (currentPlayer.currentPosition.z<20){
						controls.moveForward=false;
						controls.moveBackward=true;
					} else if (currentPlayer.currentPosition.z<70){
						controls.moveForward=false;
						if (myTeamLW.currentPosition.x>currentPlayer.currentPosition.x&&myTeamLW.currentPosition.z<currentPlayer.currentPosition.z){
							controls.moveBackward=true;
						} else if (myTeamMF.currentPosition.x>currentPlayer.currentPosition.x&&myTeamMF.currentPosition.z<currentPlayer.currentPosition.z&&myTeamMF.chasingPosition!=null){
							controls.moveBackward=true;
						} else {
							controls.moveBackward=false;
						}
					} else if (currentPlayer.currentPosition.x>50){
						controls.moveForward=true;
						controls.moveBackward=false;
					} else {
						controls.moveForward=false;
						controls.moveBackward=false;
					}
				}
			}
			

			function updateCameraTarget(){
				if (currAction=="none"){
					cameraTarget.set(currentPlayer.currentPosition.x, 0, currentPlayer.currentPosition.z);
					if (currentPlayer.currentPosition.x<-40){
						camera.position.x=-75;
						if (currentPlayer.currentPosition.z<=-75){
							camera.position.z=-60;
						} else {
							camera.position.z=currentPlayer.currentPosition.z+15;
						}
					} else if (currentPlayer.currentPosition.x>40){
						camera.position.x=75;
						if (currentPlayer.currentPosition.z<=-75){
							camera.position.z=-60;
						} else {
							camera.position.z=currentPlayer.currentPosition.z+15;
						}
					} else {
						if (currentPlayer.currentPosition.x>15){
							camera.position.x=currentPlayer.currentPosition.x-15;
						} else if (currentPlayer.currentPosition.x<-15){
							camera.position.x=currentPlayer.currentPosition.x+15;
						}else {
							camera.position.x=0;
						}
						if (currentPlayer.currentPosition.z<=-75){
							camera.position.z=-60;
						} else {
							camera.position.z=currentPlayer.currentPosition.z+15;
						}
					}
				}
			}

			var displayedTime=0;
			function updateGameTimer(delta){
				gameTimer+=(delta*3);
				if (gameTimer-displayedTime>=1){
					displayedTime=gameTimer-gameTimer%1;
					var mins = Math.floor(displayedTime/60);
					var seconds = (displayedTime - mins*60);
					if (mins<10){
						document.getElementById('minuteLabel').innerHTML='0'+mins;
					} else {
						document.getElementById('minuteLabel').innerHTML=mins;
					}
					if (seconds<10){
						document.getElementById('secondLabel').innerHTML='0'+seconds;
					} else {
						document.getElementById('secondLabel').innerHTML=seconds;
					}
					if (mins>=5*(halvesComplete+1)){
						if (halvesComplete==0){
							document.getElementById('overlay').innerHTML="HalfTime!";
						} else {
							document.getElementById('overlay').innerHTML="Times up!";
						}
						document.getElementById('overlay').style.display="";
						timerActive=false;
						gameOver=true;
						//setTimeout(submitGame, '5000');
					}
				}
			}
			
			function render() {

				//var timer = Date.now() * 0.0005;
				var delta = Math.min(clock.getDelta(), 0.3);

				if (timerActive){
					updateGameTimer(delta);
					if (teamWithBall==2&&currAction=="none"){
						triggerTimer+=delta;
						if (triggerTimer>=1){
							triggerAIStop();
						}
					}
				}
				if (gameActive){
					computeRestingPositions();
					timeSinceLastTrigger+=delta;

					if (teamWithBall==2&&!multiplayer){
						computeAIMove();
					}
				}

				if (currAction=="blitzoff"){
					trackTimer+=delta;
					if (trackTimer>=1){
						blitzball.rotation.y+=delta*10;
					}
					if (trackTimer>=3){
						blitzball.position.y+=delta*10;
						cameraTarget.y=blitzball.position.y;
					}
					if (trackTimer>=5){
						endBlitzoff();
					}
				}

				if (statUpdating!=null){
					trackTimer+=delta;
					if (trackTimer<1){
						if (statUpdating=='team1Score'||statUpdating=='team2Score'){
							document.getElementById(statUpdating).style.fontSize=(3-trackTimer)+'vw';
						} else {
							document.getElementById(statUpdating).style.fontSize=(3-trackTimer)+'vw';
						}
					} else {
						document.getElementById(statUpdating).style.fontSize='2vw';
						document.getElementById(statUpdating).style.color="#FFFF66";
						statUpdating=null;
						trackTimer=0;
					}
				}

				if (currAction=="passedBall"||currAction=="shotBall"){
					var maxBallMove=20*delta;
					var lengthLeft=ballTrajectory.length();
					if (maxBallMove>=lengthLeft){
						blitzball.position.add(ballTrajectory);
						ballMoveIteration+=ballTrajectory.length();
						ballTrajectory=null;
						if (ballMoveIteration>=20){
							updateActiveNumbers();
						}
						ballMoveIteration=0;
						onBallArrive();
					} else {
						var scale = maxBallMove/lengthLeft;
						var mv = ballTrajectory.clone().multiplyScalar(scale);
						ballMoveIteration+=mv.length();
						if (ballMoveIteration>=20){
							updateActiveNumbers();
							ballMoveIteration-=20;
						}
						updateActiveOverride=false;
						blitzball.position.add(mv);
						ballTrajectory.sub(mv);
						if (blitzball.position.distanceTo(camera.position)>25){
							camera.position.add(mv);
						}
						cameraTarget.set(blitzball.position.x, blitzball.position.y, blitzball.position.z);
					}
				}

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
					//camera.position.y = 0;
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
				camera.position.y = 1;
				//camera.position.z = Math.sin( timer ) * 10;
				
				updateCameraTarget();
				//if (controls.moveForward||controls.moveBackward||controls.moveLeft||controls.moveRight){
					//cameraTarget.set(myTeamLW.root.position.x, myTeamLW.root.position.y, myTeamLW.root.position.z);
				//}
				camera.lookAt(cameraTarget);
				//camera.lookAt( scene.position );

				//particleLight.position.x = Math.sin( timer * 4 ) * 3009;
				//particleLight.position.y = Math.cos( timer * 5 ) * 4000;
				//particleLight.position.z = Math.cos( timer * 4 ) * 3009;

				for (var i=0; i<allPlayers.length; i++){
					allPlayers[i].updatePlayer(delta, controls);
				}
				//THREE.AnimationHandler.update( delta/30 );

				renderer.render( scene, camera );

			}

			function submitGame(){
				team1Score++;
				team2Score++;
				document.getElementById('formTeam1Score').value=team1Score;
				document.getElementById('formTeam2Score').value=team2Score;
				for (var i=0; i<allPlayers.length; i++){
					document.getElementById('goals'+(allPlayers[i].playerID)).value=allPlayers[i].goals;
					document.getElementById('shots'+(allPlayers[i].playerID)).value=allPlayers[i].shots;
					document.getElementById('assists'+(allPlayers[i].playerID)).value=allPlayers[i].assists;
					document.getElementById('goalsAgainst'+(allPlayers[i].playerID)).value=allPlayers[i].goalsAgainst;
					document.getElementById('shotsAgainst'+(allPlayers[i].playerID)).value=allPlayers[i].shotsAgainst;
					document.getElementById('tackles'+(allPlayers[i].playerID)).value=allPlayers[i].tackles;
					document.getElementById('blocks'+(allPlayers[i].playerID)).value=allPlayers[i].blocks;
					document.getElementById('breaks'+(allPlayers[i].playerID)).value=allPlayers[i].breaks;
					document.getElementById('turnovers'+(allPlayers[i].playerID)).value=allPlayers[i].turnovers;
				}
				document.getElementById('halvesComplete').value=halvesComplete+1;
				document.getElementById('gameInfoForm').submit();
			}

		</script>
	</body>
</html>
