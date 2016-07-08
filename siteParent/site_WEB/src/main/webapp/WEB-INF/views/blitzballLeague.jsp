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
	
	<div id="standings">
		<div id="div1Standings" style="position:absolute; left:40%; top:20vmin; width:40%; font-size:6vmin; text-align:center">
			<label>League Standings</label>
		</div>
		<div id="div1Standings" style="display:table; position:absolute; left:40%; top:30vmin; width:40%">
			<div style="display:table-caption; text-align:center">
				<label>Division 1</label>
			</div>
			<div style="display:table-row; border-bottom: 1px solid white">
				<div style="display:table-cell; width:4vmin;"><label></label></div>
				<div style="display:table-cell;"><label>Team Name</label></div>
				<div style="display:table-cell; width:4vmin; text-align:center"><label>W</label></div>
				<div style="display:table-cell; width:4vmin; text-align:center"><label>L</label></div>
				<div style="display:table-cell; width:4vmin; text-align:center"><label>T</label></div>
				<div style="display:table-cell; width:4vmin; text-align:center"><label>Pts</label></div>
			</div>
		<c:forEach var="team" items="${standings.division1Standings}"  varStatus="num">
			<div style="display:table-row">
				<div style="display:table-cell; width:4vmin;"><label>${num.count}.</label></div>
				<div style="display:table-cell;"><label>${team.teamName}</label></div>
				<div style="display:table-cell; width:4vmin; text-align:center"><label>${team.wins}</label></div>
				<div style="display:table-cell; width:4vmin; text-align:center"><label>${team.losses}</label></div>
				<div style="display:table-cell; width:4vmin; text-align:center"><label>${team.ties}</label></div>
				<div style="display:table-cell; width:4vmin; text-align:center"><label>${team.points}</label></div>
			</div>
		</c:forEach>
		</div>
		<div id="div2Standings" style="display:table; position:absolute; left:40%; top:60vmin; width:40%">
			<div style="display:table-caption; text-align:center">
				<label>Division 2</label>
			</div>
			<div style="display:table-row; border-bottom: 1px solid white">
				<div style="display:table-cell; width:4vmin;"><label></label></div>
				<div style="display:table-cell;"><label>Team Name</label></div>
				<div style="display:table-cell; width:4vmin; text-align:center"><label>W</label></div>
				<div style="display:table-cell; width:4vmin; text-align:center"><label>L</label></div>
				<div style="display:table-cell; width:4vmin; text-align:center"><label>T</label></div>
				<div style="display:table-cell; width:4vmin; text-align:center"><label>Pts</label></div>
			</div>
		<c:forEach var="team" items="${standings.division2Standings}"  varStatus="num">
			<div style="display:table-row">
				<div style="display:table-cell; width:4vmin;"><label>${num.count}.</label></div>
				<div style="display:table-cell;"><label>${team.teamName}</label></div>
				<div style="display:table-cell; width:4vmin; text-align:center"><label>${team.wins}</label></div>
				<div style="display:table-cell; width:4vmin; text-align:center"><label>${team.losses}</label></div>
				<div style="display:table-cell; width:4vmin; text-align:center"><label>${team.ties}</label></div>
				<div style="display:table-cell; width:4vmin; text-align:center"><label>${team.points}</label></div>
			</div>
		</c:forEach>
		</div>
	</div>
	
	<div id="confirmDiv" class="menu absoluteCentered" style="display:none; top:30vmin"">
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
					window.open("blitzballStartGame", "_self");
				} else  {
					popupOpen=false;
					document.getElementById('confirmDiv').style.display='none';
					navMenu.updateActiveSelector('selector', MAXITEMS, 1);
				}
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

	</script>

</body>
</html>