<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
	<div class="menu leagueNav">
		<div class="innerMenu">
			<div class="selectorWrapper">
				<img id="selector" class="selector" src="img/blitzball/arrow.png" />
			</div>
			<div>
				<label id="menu1">Play</label>
			</div>
			<div>
				<label id="menu2">Standings</label>
			</div>
			<div>
				<label id="menu3">Schedule</label>
			</div>
			<div>
				<label id="menu4">Statistics</label>
			</div>
			<div>
				<label id="menu5">Back to Menu</label>
			</div>
		</div>
	</div>
		
	<div id="schedule">
		<div id="weekNavigator" style="display:table; position:absolute; left:40%; top:20%; width:50%;">
			<img id="weekSelector" class="selector" src="img/blitzball/arrow.png" style="display:none"/>
			<div style="display:table-row">
				<div style="display:table-cell; text-align:left; width:12%; text-decoration:underline"><label>Prev</label></div>
				<div style="display:table-cell; width:76%; text-align:center"><label id="weekNoDisplay">Week ${week}</label></div>
				<div style="display:table-cell; text-align:right; width:12%; text-decoration:underline"><label>Next</label></div>
			</div>
		</div>
		<div id="displayedWeek" style="position:absolute; left:40%; top:30%; width:50%">
			<c:forEach var="weekList" items="${schedule}" varStatus="weekNo">
				<div id="week${weekList.key}" style="display:none; position:absolute; left:0; top:0; width:100%">
				<c:forEach var="game" items="${weekList.value}" varStatus="gameNo">
					<div style="display:table-row">
						<div style="display:table-cell; text-align:left; width:38%"><label>${game.team1.teamName}</label></div>
						<div style="display:table-cell; width:8%; text-align:right"><label>${game.team1Score}</label></div>
						<div style="display:table-cell; width:8%; text-align:center"><label>-</label></div>
						<div style="display:table-cell; width:8%; text-align:left"><label>${game.team2Score}</label></div>
						<div style="display:table-cell; text-align:right; width:38%"><label>${game.team2.teamName}</label></div>
					</div>
					<div style="display:table-row">
						<br/>
					</div>
				</c:forEach>
				</div>
			</c:forEach>
		</div>
	</div>
		
	<div id="confirmDiv" class="menu absoluteCentered" style="display:none; top:30vmin">
		<div class="innerMenu">
			<div>Play Game vs</div>
			<div>${oppName}?</div>
			<div class="selectorWrapper" style="top:10.5vmin">
				<img id="confSelector" class="selector" src="img/blitzball/arrow.png" />
			</div>
			<div>Yes</div>
			<div>No</div>
		</div>
	</div>
		
	<script>
		var menuSelection=1;
		var MAXITEMS=5;
		var popupOpen=false;
		var onOKButton=true;
		var weekSelecting=false;
		var weekOnPrev=true;
		var currentWeek='${week}';
		var navMenu = new BBNavMenu('selector', MAXITEMS, 1);
		
		function upButtonPressed(){
			if (!weekSelecting){
				navMenu.moveUp();
			}
		}

		function downButtonPressed(){
			if (!weekSelecting){
				navMenu.moveDown();
			}
		}

		function leftButtonPressed(){
			if (weekSelecting){
				if (weekOnPrev){
					weekSelecting=false;
					document.getElementById('weekSelector').style.display='none';
					navMenu.updateActiveSelector('selector', MAXITEMS, 1);
				} else {
					weekOnPrev=true;
					document.getElementById('weekSelector').style.left='-5vmin';
				}
			}
		}

		function rightButtonPressed(){
			if (weekSelecting){
				if (weekOnPrev){
					weekOnPrev=false;
					document.getElementById('weekSelector').style.left='88%';
				}
			} else {
				weekSelecting=true;
				weekOnPrev=true;
				navMenu.updateActiveSelector(null, 1, 1);
				document.getElementById('weekSelector').style.left='-5vmin';
				document.getElementById('weekSelector').style.display='';
			}
		}

		function selectButtonPressed(){
			if (popupOpen){
				if (navMenu.getRow()==1){
					window.open("blitzballStartGame", "_self");
				} else  {
					onOKButton=true;
					popupOpen=false;
					document.getElementById('confSelector').style.top='8vmin';
					document.getElementById('confirmDiv').style.display='none';
					document.getElemenyById('selector').style.display='';
				}
			} else if (weekSelecting) {
				document.getElementById('week'+currentWeek).style.display='none';
				if (weekOnPrev){
					if (currentWeek>1){
						currentWeek=Number(currentWeek)-1;
					}
				} else {
					if (currentWeek<10){
						currentWeek=Number(currentWeek)+1;
					}
				}
				document.getElementById('week'+currentWeek).style.display='table';
				document.getElementById('weekNoDisplay').innerHTML='Week '+currentWeek;
			} else {
				switch (navMenu.getRow()){
				case (1):
					document.getElementById('confirmDiv').style.display='';
					popupOpen=true;
					navMenu.updateActiveSelector('confSelector', 2, 1);
					break;
				case (2):
					window.open('blitzballLeague', '_self');
					break;
				case (3):
					window.open('blitzballLeagueSched', '_self');
					break;
				case (4):
					window.open('blitzballLeagueStats', '_self');
					break;
				case (5):
					window.open('blitzballMenu', '_self');
					break;
				}
			}
		}

		function cancelButtonPressed(){
			if (popupOpen){
				navMenu.updateRow(2);
			} else if (weekSelecting) {
				weekSelecting=false;
				document.getElementById('weekSelector').style.display='none';
				weekOnPrev=true;
				document.getElementById('weekSelector').style.left='-5vmin';
				navMenu.updateActiveSelector('selector', MAXITEMS, MAXITEMS);
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
			} else if (event.keyCode==39){
				event.preventDefault();
				rightButtonPressed();
			} else if (event.keyCode==37){
				event.preventDefault();
				leftButtonPressed();
			} else if (event.keyCode==90){
				event.preventDefault();
				selectButtonPressed();
			} else if (event.keyCode==88){
				event.preventDefault();
				cancelButtonPressed();
			}
		}
		window.onload = function(){
			document.getElementById('week'+currentWeek).style.display='table';
		}

	</script>

</body>
</html>