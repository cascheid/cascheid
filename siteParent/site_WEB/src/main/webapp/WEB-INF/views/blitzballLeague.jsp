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
				height:210px;
				left:10%;
				background-color:#6B238E;
				background-image: url("img/cracks.png");
				border: 5px double white;
				display:inline;
				padding:25px;
				z-index:1000;
			}
			
			#confirmDiv{
				position:absolute;
				top:20%;
				width:12%;
				height:100px;
				left:44%;
				background-color:#6B238E;
				background-image: url("img/cracks.png");
				border: 5px double white;
				padding:10px;
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
				<a id="menu1" href="blitzballLeague" target="_self" onfocus="onFocusMenu(1)">Play</a>
			</div>
			<div class="menuitems" style="top:70px">
				<a id="menu2" href="blitzballLeague" target="_self" onfocus="onFocusMenu(2)">Standings</a>
			</div>
			<div class="menuitems" style="top:110px">
				<a id="menu3" href="blitzballLeagueSched" target="_self" onfocus="onFocusMenu(3)">Schedule</a>
			</div>
			<div class="menuitems" style="top:150px">
				<a id="menu4" href="blitzballLeagueStats" target="_self" onfocus="onFocusMenu(4)">Statistics</a>
			</div>
			<div class="menuitems" style="top:190px">
				<a id="menu5" href="blitzballMenu" target="_self" onfocus="onFocusMenu(5)">Back to Menu</a>
			</div>
		</div>
		<div id="confirmDiv">
			<p>Play game vs. Guado Glories?</p>
			<div style="text-align:center">
				<button id="okButton" onclick="onOKButtonClick()">Play</button>
				<button id="CancelButton" onclick="onCancelButtonClick()">Back</button>
			</div>
		</div>
		
		<script>
		var menuSelection=1;
		var MAXITEMS=5;
		var popupOpen=false;
		var onOKButton=true;
		document.getElementById('menu1').focus();
		document.body.onkeydown = function(e){
		    onKeyDown(e);
		};

		function onFocusMenu(multiplier){
			menuSelection=multiplier;
			document.getElementById('selector').style.top=40*multiplier+'px';
			document.getElementById('menu'+multiplier).focus();
			popupOpen=true;
		}

		function onOKButtonClick(){
			window.open('blitzballLeagueGame', '_self');
		}

		function onCancelButtonClick(){
			document.getElementById('confirmDiv').style.display='none';
			document.getElementById('menu1').focus();
			popupOpen=false;
			document.getElemenyById('selector').style.display='';
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
				if (popupOpen){
					if (onOKButton){
						onOKButtonClick();
					} else  {
						onCancelButtonClick();
					}
				}
				if (menuSelection==1){
					document.getElementById('confirmDiv').style.display='';
					popupOpen=true;
					document.getElemenyById('selector').style.display='none';
				} else if (menuSelection==2){
					window.open('blitzballLeague', '_self');
				} else if (menuSelection==3){
					window.open('blitzballLeagueSched', '_self');
				} else if (menuSelection==4){
					window.open('blitzballLeagueStats', '_self');
				} else if (menuSelection==5){
					window.open('blitzballMenu', '_self');
				}
			} else if (event.keyCode==39){
				
			}
			document.getElementById('selector').style.top=menuSelection*40+'px';
			document.getElementById('menu'+menuSelection).focus();
		}

		</script>

	</body>
</html>