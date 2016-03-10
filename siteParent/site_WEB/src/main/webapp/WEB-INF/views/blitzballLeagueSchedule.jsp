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
		var weekSelecting=false;
		var weekOnPrev=true;
		var currentWeek='${week}';
		
		document.body.onkeydown = function(e){
		    onKeyDown(e);
		};
		
		function upButtonPressed(){
			if (popupOpen){
				if (onOKButton){
					onOKButton=false;
					document.getElementById('confSelector').style.top='12vmin';
				} else {
					onOKButton=true;
					document.getElementById('confSelector').style.top='8vmin';
				}
			} else if (!weekSelecting){
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
					document.getElementById('confSelector').style.top='12vmin';
				} else {
					onOKButton=true;
					document.getElementById('confSelector').style.top='8vmin';
				}
			} else if (!weekSelecting){
				if (menuSelection>=MAXITEMS){
					menuSelection=1;
				} else {
					menuSelection++;
				}
				document.getElementById('selector').style.top=(menuSelection-1)*4+'vmin';
			}
		}

		function leftButtonPressed(){
			if (weekSelecting){
				if (weekOnPrev){
					weekSelecting=false;
					document.getElementById('weekSelector').style.display='none';
					document.getElementById('selector').style.display='';
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
				document.getElementById('selector').style.display='none';
				document.getElementById('weekSelector').style.left='-5vmin';
				document.getElementById('weekSelector').style.display='';
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
				document.getElementById('confSelector').style.top='12vmin';
			} else if (weekSelecting) {
				weekSelecting=false;
				document.getElementById('weekSelector').style.display='none';
				weekOnPrev=true;
				document.getElementById('weekSelector').style.left='-5vmin';
				menuSelection=MAXITEMS;
				document.getElementById('selector').style.display='';
				document.getElementById('selector').style.top=(menuSelection-1)*4+'vmin';
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