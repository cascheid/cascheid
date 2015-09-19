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
			
			#blitzMenu{
				position:absolute;
				top:20%;
				width:12%;
				height:190px;
				left:44%;
				background-color:#6B238E;
				background-image: url("img/cracks.png");
				border: 5px double white;
				display:none;
				padding:25px;
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
			left:5px;
			top:40px;
			width:40px;
			height:25px;
			}
			
			.selectedLink{
				color: #000000;	
			}
		</style>
	</head>

	<body>
		<div id="blitzMenu">
			<img id="selector" src="img/blitzball/arrow.png" />
			<div class="menuitems" style="top:30px">
				<a id="menu1" href="blitzballLeague" target="_self" onfocus="onFocusMenu(1)">League</a>
			</div>
			<div class="menuitems" style="top:70px">
				<a id="menu2" href="blitzballTourney" target="_self" onfocus="onFocusMenu(2)">Tournament</a>
			</div>
			<div class="menuitems" style="top:110px">
				<a id="menu3" href="blitzballTeamInfo" target="_self" onfocus="onFocusMenu(3)">Team Data</a>
			</div>
			<div class="menuitems" style="top:150px">
				<a id="menu4" href="blitzballRecruit" target="_self" onfocus="onFocusMenu(4)">Recruit</a>
			</div>
		</div>
		
		<script>
		var menuSelection=1;
		var MAXITEMS=4;
		document.getElementById('menu1').focus();
		document.body.onkeydown = function(e){
		    onKeyDown(e);
		};

		function onFocusMenu(multiplier){
			menuSelection=multiplier;
			document.getElementById('selector').style.top=40*multiplier+'px';
			document.getElementById('menu'+multiplier).focus();
		}

		function onKeyDown(event){
			if (event.keyCode==40){
				event.preventDefault();
				if (menuSelection>=MAXITEMS){
					menuSelection=1;
				} else {
					menuSelection++;
				}
			} else if (event.keyCode==38){
				event.preventDefault();
				if (menuSelection<=1){
					menuSelection=MAXITEMS;
				} else {
					menuSelection--;
				}
			} else if (event.keyCode==13){
				event.preventDefault();
				if (menuSelection==1){
					window.open('blitzballLeague', '_self');
				} else if (menuSelection==2){
					window.open('blitzballTourney', '_self');
				} else if (menuSelection==3){
					window.open('blitzballTeamInfo', '_self');
				} else if (menuSelection==4){
					window.open('blitzballRecruit', '_self');
				}
			}
			document.getElementById('selector').style.top=menuSelection*40+'px';
			document.getElementById('menu'+menuSelection).focus();
		}

		setTimeout(function(){
			document.getElementById('blitzMenu').style.display='inline';
			}, 2000);

		</script>

	</body>
</html>
