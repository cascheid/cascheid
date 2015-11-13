<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
	<head>
		<title>Blitzball!</title>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0">
		<style>
			body {
				background:none transparent;
				padding:0;
				margin:0;
				font-weight: bold;
				overflow:hidden;
			}

			.menuitems {
				position: absolute;
				color: #ffffff;	
				text-decoration: none;
				padding-top: 5px;
				padding-bottom: 5px;
				padding-left: 15px;
				font-family:"Arial Black", Gadget, sans-serif;
				font-size:20px;
				display:inline-block;
				outline: 0;
			}
			
			#infoDiv{
				font-size:3.5vh;
				line-height:4vh;
				color: #ffffff;
				position:absolute;
				top:68vmin;
				left:40%;
				width:30%;
				background:none transparent;
				z-index:1000;
				display:none;
			}
			
			#blitzMenu{
				font-size:3.5vmin;
				color: #ffffff;
				position:absolute;
				top:20vmin;
				width:12%;
				height:28vmin;
				left:44%;
				background-color:#6B238E;
				background-image: url("img/cracks.png");
				border: 5px double white;
				display:none;
				line-height:4vmin;
				padding-left:5vmin;
				z-index:1000;
			}

			a {	color: #ffffff;	
				text-decoration: none;
				padding-top: 5px;
				padding-bottom: 5px;
				padding-left: 15px;
				font-family:"Arial Black", Gadget, sans-serif;
				font-size:20px;
				display:inline-block;
				outline: 0;
				}
			
			#selector{
				position:absolute;
				left:-5vmin;
				top:0vmin;
				width:5vmin;
				height:3.5vmin;
			}
			
			.selectedLink{
				color: #000000;	
			}
		</style>
	</head>

	<body>
		<div id="blitzMenu">
			<div style="position:absolute; top:4vmin; left:5vmin">
			<img id="selector" src="img/blitzball/arrow.png" />
			<div>
				<label id="menu1">League</label>
			</div>
			<div>
				<label id="menu2">Tournament</label>
			</div>
			<div>
				<label id="menu3">Team Data</label>
			</div>
			<div>
				<label id="menu4">Recruit</label>
			</div>
			<div>
				<label id="menu5">Back to Site</label>
			</div>
			</div>
		</div>
		
		<div id="infoDiv">
			<p>Controls: <br/>
			Arrow Keys: Navigate Menu <br/>
			Z: Select/OK <br/>
			X: Cancel/Back <br/>
			</p>
		</div>
		
		<script>
		var menuSelection=1;
		var MAXITEMS=5;
		document.getElementById('menu1').focus();
		document.body.onkeydown = function(e){
		    onKeyDown(e);
		};

		function upButtonPressed(){
			if (menuSelection<=1){
				menuSelection=MAXITEMS;
			} else {
				menuSelection--;
			}
			document.getElementById('selector').style.top=(menuSelection-1)*4+'vmin';
		}

		function downButtonPressed(){
			if (menuSelection>=MAXITEMS){
				menuSelection=1;
			} else {
				menuSelection++;
			}
			document.getElementById('selector').style.top=(menuSelection-1)*4+'vmin';
		}

		function selectButtonPressed(){
			if (menuSelection==1){
				window.open('blitzballLeague', '_self');
			} else if (menuSelection==2){
				window.open('blitzballTourney', '_self');
			} else if (menuSelection==3){
				window.open('blitzballTeamInfo', '_self');
			} else if (menuSelection==4){
				window.open('blitzballRecruit', '_self');
			} else if (menuSelection==5){
				window.open('gamesIndex', '_parent');
			}
		}

		function cancelButtonPressed(){
			menuSelection=MAXITEMS;
			document.getElementById('selector').style.top=(menuSelection-1)*4+'vmin';
		}

		function onKeyDown(event){
			if (event.keyCode==40){
				event.preventDefault();
				downButtonPressed();
			} else if (event.keyCode==38){
				event.preventDefault();
				upButtonPressed();
			} else if (event.keyCode==90){
				event.preventDefault();
				selectButtonPressed();
			} else if (event.keyCode==88){
				event.preventDefault();
				cancelButtonPressed();
			}
		}

		setTimeout(function(){
			document.getElementById('blitzMenu').style.display='inline';
			document.getElementById('infoDiv').style.display='inline';
			}, 2000);

		</script>

	</body>
</html>
