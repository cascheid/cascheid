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
		<style>
			
			#blitzMenu{
				top:20%;
				width:32vmin;
				height:28vmin;
				left:10%;
			}
			
			#confirmDiv{
				top:20%;
				width:20%;
				height:16vmin;
				left:40%;
			}
			
			#confSelector{
				left:0vmin;
				top:8vmin;
			}
		</style>
	</head>

	<body>
		<div id="blitzMenu" class="menu">
			<div style="position:absolute; top:4vmin; left:5vmin">
			<img id="selector" class="selector" src="img/blitzball/arrow.png" />
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
		
		<div id="confirmDiv" class="menu" style="display:none">
			<img id="confSelector" class="selector" src="img/blitzball/arrow.png" />
			<div class="promptLabel">
				<label>Play Game vs</label>
			</div>
			<div class="promptLabel">
				<label>${oppName}?</label>
			</div>
			<div class="promptOptions">
				<label>Yes</label>
			</div>
			<div class="promptOptions">
				<label>No</label>
			</div>
		</div>
		
		<script>
		var menuSelection=1;
		var MAXITEMS=5;
		var popupOpen=false;
		var onOKButton=true;
		document.body.onkeydown = function(e){
		    onKeyDown(e);
		};
		
		function upButtonPressed(){
			if (popupOpen){
				if (onOKButton){
					onOKButton=false;
					document.getElementById('confSelector').style.top='12vh';
				} else {
					onOKButton=true;
					document.getElementById('confSelector').style.top='8vh';
				}
			} else {
				if (menuSelection<=1){
					menuSelection=MAXITEMS;
				} else {
					menuSelection--;
				}
				document.getElementById('selector').style.top=(menuSelection-1)*4+'vmin';
			}
		}

		function downButtonPressed(){
			if (popupOpen){
				if (onOKButton){
					onOKButton=false;
					document.getElementById('confSelector').style.top='12vh';
				} else {
					onOKButton=true;
					document.getElementById('confSelector').style.top='8vh';
				}
			} else {
				if (menuSelection>=MAXITEMS){
					menuSelection=1;
				} else {
					menuSelection++;
				}
				document.getElementById('selector').style.top=(menuSelection-1)*4+'vmin';
			}
		}

		function selectButtonPressed(){
			if (popupOpen){
				if (onOKButton){
					window.open("blitzballStartGame", "_self");
				} else  {
					onOKButton=true;
					popupOpen=false;
					document.getElementById('confSelector').style.top='8vmin';
					document.getElementById('confirmDiv').style.display='none';
					document.getElemenyById('selector').style.display='';
				}
			} else {
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
			}
		}

		function cancelButtonPressed(){
			if (popupOpen){
				onOKButton=false;
				document.getElementById('confSelector').style.top='12vh';
			} else {
				menuSelection=MAXITEMS;
				document.getElementById('selector').style.top=(menuSelection-1)*4+'vmin';
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