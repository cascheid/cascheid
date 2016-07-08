<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<title>Blitzball!</title>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0">
	<link rel="stylesheet" type="text/css" href="css/blitzball.css?version=1.00"/>
	<script src="js/BBNavMenu.js?version=0.1"></script>
</head>

<body>
	<div id="blitzMenu" class="menu absoluteCentered" style="display:none; top: 20vmin;">
		<div class="innerMenu">
			<div class="selectorWrapper">
				<img id="selector" class="selector" src="img/blitzball/arrow.png" />
			</div>
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
				<label id="menu5">Reset Game Data</label>
			</div>
			<div>
				<label id="menu6">Back to Site</label>
			</div>
		</div>
	</div>
		
	<div id="infoDiv" class="menu absoluteCentered" style="display:none; top:68vmin;">
		<div class="innerMenu">
			<div>Controls: </div>
			<div>Arrow Keys: Navigate Menu</div>
			<div>Z: Select/OK </div>
			<div>X: Cancel/Back </div>
		</div>
	</div>
		
	<div id="confirmDiv" class="menu absoluteCentered" style="display:none; top:30vmin">
		<div class="innerMenu">
			<div>Are you sure you want to reset the game data?</div>
			<div class="smallFont">This will reset all rosters and player experience (Team Level will be retained).</div>
			<div>
				<div class="selectorWrapper" style="top:10.5vmin">
					<img id="confSelector" class="selector" src="img/blitzball/arrow.png" />
				</div>
				<div class="promptOptions">Yes</div>
				<div class="promptOptions">No</div>
			</div>
		</div>
	</div>
		
	<script>
		var MAXITEMS=6;
		var numPlayers=${numPlayers};
		var popupOpen=false;
		var navMenu = new BBNavMenu('selector', MAXITEMS, 1);

		function upButtonPressed(){
			navMenu.moveUp();
		}

		function downButtonPressed(){
			navMenu.moveDown();
		}

		function selectButtonPressed(){
			if (popupOpen){
				if (navMenu.getRow()==1){
					window.open("resetBlitzballGame", "_parent");
				} else {
					popupOpen=false;
					document.getElementById('confirmDiv').style.display='none';
					navMenu.updateActiveSelector('selector', MAXITEMS, 5);
				}
			} else {
				switch (navMenu.getRow()){
					case (1):
						if (numPlayers>=6){
							window.open('blitzballLeague', '_self');
						} else {
							window.alert("You don't have enough players! Please recruit more players to be able to field a full team");
						}
						break;
					case (2):
						if (numPlayers>=6){
							window.open('blitzballTourney', '_self');
						} else {
							window.alert("You don't have enough players! Please recruit more players to be able to field a full team");
						}
						break;
					case (3):
						window.open('blitzballTeamInfo', '_self');
						break;
					case (4):
						window.open('blitzballRecruit', '_self');
						break;
					case (5):
						document.getElementById('confirmDiv').style.display='';
						popupOpen=true;
						navMenu.updateActiveSelector('confSelector', 2, 2);
						break;
					case (6):
						window.open('gamesIndex', '_parent');
						break;
					
				}
			}
		}

		function cancelButtonPressed(){
			if (popupOpen){
				popupOpen=false;
				document.getElementById('confirmDiv').style.display='none';
				navMenu.updateActiveSelector('selector', MAXITEMS, 5);
			} else {
				navMenu.updateRow(MAXITEMS);
			}
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
				document.getElementById('blitzMenu').style.display='';
				document.getElementById('infoDiv').style.display='';
			}, 2000);

	</script>

</body>
</html>
