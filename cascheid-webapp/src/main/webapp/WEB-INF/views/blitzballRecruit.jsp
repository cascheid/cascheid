<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
	<title>Blitzball!</title>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0">
	<link rel="stylesheet" type="text/css" href="css/blitzball.css?version=1.00"/>
	<script src="js/BBNavMenu.js?version=0.1"></script>
		<style>
			body{
			background:light-grey;
			}
			
			.statCell{
				display:table-cell; 
				min-width:6vw;
				text-align:center;
			}
			
			.firstStatCell{
				display:table-cell; 
				min-width:11vw;
				text-align:center;
			}
			
			.lastStatCell{
				display:table-cell;
				width:6vw;
				text-align:center;
			}
			
			#techInfoDiv{
				position:absolute;
				top:10vmin;
				left:40%;
				width:40%;
				z-index:1000;
			}
			
			#displayedTechsContainer{
				top:40%;
				left:10%;
				width:81%;
				height:55%;
				z-index:1001;
			}
		</style>
	</head>

<body>
	<div id="navMenu" class="menu leagueNav">
		<div class="innerMenu">
			<div class="selectorWrapper">
				<img id="selector" class="selector" src="img/blitzball/arrow.png" />
			</div>
			<div>
				<label id="menu1">My Team</label>
			</div>
			<div>
				<label id="menu2">Free Agents</label>
			</div>
	<c:choose>
		<c:when test="${recruitType eq 'draft'}">
			<div>
				<label id="menu3">End Draft</label>
			</div>
		</c:when>
		<c:otherwise>
			<div>
				<label id="menu3">Back to Menu</label>
			</div>
		</c:otherwise>
	</c:choose>
		</div>
	</div>
		
	<div id="statTable" style="display:table; table-layout:fixed; position: absolute; left:30%; top:20vmin; width:65vw;">
			<div style="display:table-row; background-color:green; width:100%">
				<div style="display:table-row; width:100%">
					<div class="firstStatCell">Name</div>
					<div class="statCell">Level</div>
					<div class="statCell">HP</div>
					<div class="statCell">Speed</div>
					<div class="statCell">Endurance</div>
					<div class="statCell">Shot</div>
					<div class="statCell">Attack</div>
					<div class="statCell">Pass</div>
					<div class="statCell">Block</div>
					<div class="statCell">Catch</div>
					<div class="statCell">Salary</div>
					<div class="lastStatCell"># Known Techs</div>
				</div>
			</div>
			<div id="scroller" style="background-color:gray; overflow-y:auto; height:40vmin; width:100%">
			<c:forEach var="player" items="${allPlayers}" varStatus="status">
				<div id="row${status.count}" style="display:table-row; width:100%" class="team${player.teamID}">
					<div id="row${status.count}col1" class="firstStatCell">${player.name}</div>
					<div id="row${status.count}col2" class="statCell">${player.level}</div>
					<div id="row${status.count}col3" class="statCell">${player.hp}</div>
					<div id="row${status.count}col4" class="statCell">${player.speed}</div>
					<div id="row${status.count}col5" class="statCell">${player.endurance}</div>
					<div id="row${status.count}col6" class="statCell">${player.shot}</div>
					<div id="row${status.count}col7" class="statCell">${player.attack}</div>
					<div id="row${status.count}col8" class="statCell">${player.pass}</div>
					<div id="row${status.count}col9" class="statCell">${player.block}</div>
					<div id="row${status.count}col10" class="statCell">${player.cat}</div>
					<div id="row${status.count}col11" class="statCell">${player.salary}</div>
					<div id="row${status.count}col12" class="lastStatCell">${fn:length(player.learnedTechs)}</div>
					<div id="row${status.count}id" style="display:none">${player.playerID}</div>
					<div id="row${status.count}teamId" style="display:none">${player.teamID}</div>
					<div id="row${status.count}model" style="display:none">${player.model}</div>
				</div>
			</c:forEach>
		</div>
	</div>
		
	<iframe id="playerStatFrame" style="position:absolute; top:40%; left:50%; width:50%; height:60%; z-index:1000" frameborder=0 ></iframe>
	<iframe id="playerTechFrame" style="position:absolute; top:0; left:0; height:100vh; width:100vw; z-index:1050;" frameborder=0 ></iframe>
	
	<div id="playerSelectDiv" class="menu absoluteCentered" style="display:none; top:30vmin">
		<div class="innerMenu">
			<div class="selectorWrapper">
				<img id="playerSelector" class="selector" src="img/blitzball/arrow.png" />
			</div>
			<div id="signPlayerOption">Sign Player</div>
			<div>View Player</div>
			<div>Cancel</div>
		</div>
	</div>
	
	<div id="confirmDiv" class="menu absoluteCentered" style="display:none; top:30vmin">
		<div class="innerMenu">
			<div>End and Simulate Remainder of Draft?</div>
			<div class="selectorWrapper" style="top:6.5vmin">
				<img id="confSelector" class="selector" src="img/blitzball/arrow.png" />
			</div>
			<div>Yes</div>
			<div>No</div>
		</div>
	</div>
	
	<div id="signNumGamesDiv" class="menu absoluteCentered" style="display:none">
		<div>Total Cost:&nbsp;<span id="totalCost">0</span></div>
		<div>Resign for how many games?</div>
		<div id="numGames">1</div>
	</div>
	
	<script>
		var MAXITEMS=3;
		var popupOpen=false;
		var selectingTable=false;
		var selectedPlayer=1;
		var selectedColumn=1;
		var MAXCOL=12;
		var TOTALMAXROWS=${allPlayers.size()};
		var MAXROWS=${allPlayers.size()};
		var DISPLAYROWS=10;
		var displayingPlayerInfo=false;
		var sortOrder=[];
		var sortCol=2;
		var emptyDashString='- - - - - - - -';
		var navMenu = new BBNavMenu('selector', MAXITEMS, 1);
		var numGames=1;
		var signPrompted=false;
		
		function upButtonPressed(){
			var rowNum = sortOrder[(selectedPlayer-1)];
			if (signPrompted){
				var salary = Number(document.getElementById('row'+rowNum+'col12').innerHTML);
				numGames++;
				document.getElementById('numGames').innerHTML=numGames;
				document.getElementById('totalCost').innerHTML=numGames*salary;
			} else if (selectingTable&&navMenu.getSelector()==null){
				document.getElementById('row'+rowNum).style.backgroundColor='';
				document.getElementById('row'+rowNum+'col'+selectedColumn).style.backgroundColor='';
				if (selectedPlayer>1){
					selectedPlayer--;
				}
				rowNum = sortOrder[(selectedPlayer-1)];
				document.getElementById('row'+rowNum).style.backgroundColor='yellow';
				document.getElementById('row'+rowNum+'col'+selectedColumn).style.backgroundColor='red';
				var scroller=document.getElementById('scroller');
				var sel=document.getElementById('row'+rowNum+'col'+selectedColumn);
				if (sel.offsetTop<=(scroller.scrollTop+5)){
					scroller.scrollTop=sel.offsetTop-sel.offsetHeight;
				}
			} else {
				navMenu.moveUp();
			}
		}

		function downButtonPressed(){
			var rowNum = sortOrder[(selectedPlayer-1)];
			if (signPrompted){
				if (numGames>1){
					var salary = Number(document.getElementById('row'+rowNum+'col12').innerHTML);
					numGames--;
					document.getElementById('numGames').innerHTML=numGames;
					document.getElementById('totalCost').innerHTML=numGames*salary;
				}
			} else if (selectingTable&&navMenu.getSelector()==null){
				document.getElementById('row'+rowNum).style.backgroundColor='';
				document.getElementById('row'+rowNum+'col'+selectedColumn).style.backgroundColor='';
				if (selectedPlayer<MAXROWS){
					selectedPlayer++;
				}
				rowNum = sortOrder[(selectedPlayer-1)];
				document.getElementById('row'+rowNum).style.backgroundColor='yellow';
				document.getElementById('row'+rowNum+'col'+selectedColumn).style.backgroundColor='red';
				var scroller=document.getElementById('scroller');
				var sel=document.getElementById('row'+rowNum+'col'+selectedColumn);
				if (sel.offsetTop-(DISPLAYROWS+1)*sel.offsetHeight>(scroller.scrollTop-5)){
					scroller.scrollTop=sel.offsetTop-DISPLAYROWS*sel.offsetHeight;
				}
			} else {
				navMenu.moveDown();
			}
		}

		function leftButtonPressed(){
			if (selectingTable&&navMenu.getSelector()==null&&!signPrompted){
				if (selectedColumn>1){
					var rowNum = sortOrder[(selectedPlayer-1)];
					document.getElementById('row'+rowNum+'col'+selectedColumn).style.backgroundColor='';
					selectedColumn--;
					document.getElementById('row'+rowNum+'col'+selectedColumn).style.backgroundColor='red';
				} else {
					selectingTable=false;
					var rowNum = sortOrder[(selectedPlayer-1)];
					document.getElementById('row'+rowNum).style.backgroundColor='';
					document.getElementById('row'+rowNum+'col'+selectedColumn).style.backgroundColor='';
					navMenu.updateActiveSelector('selector', MAXITEMS, 1);
				}
			}
		}

		function rightButtonPressed(){
			if (selectingTable&&navMenu.getSelector()==null&&!signPrompted){
				if (selectedColumn<MAXCOL){
					var rowNum = sortOrder[(selectedPlayer-1)];
					document.getElementById('row'+rowNum+'col'+selectedColumn).style.backgroundColor='';
					selectedColumn++;
					document.getElementById('row'+rowNum+'col'+selectedColumn).style.backgroundColor='red';
				}
			} else if (navMenu.getSelector()=='selector'){
				selectingTable=true;
				var rowNum = sortOrder[(selectedPlayer-1)];
				document.getElementById('row'+rowNum).style.backgroundColor='yellow';
				document.getElementById('row'+rowNum+'col'+selectedColumn).style.backgroundColor='red';
				navMenu.updateActiveSelector(null, 1, 1);
			}
		}

		function selectButtonPressed(){
			if (signPrompted){
				signPlayer();
				signPrompted=false;
				document.getElementById('signNumGamesDiv').style.display='none';
			} else if (navMenu.getSelector()=='confSelector'){
				if (navMenu.getRow()==1){
					endAndSimulateDraft();
				} else  {
					popupOpen=false;
					document.getElementById('confirmDiv').style.display='none';
					navMenu.updateActiveSelector('selector', MAXITEMS, 1);
				}
			} else if (navMenu.getSelector()=='playerSelector'){
				switch (navMenu.getRow()){
				case (1):
					var rowNum = sortOrder[(selectedPlayer-1)];
					if (document.getElementById('row'+rowNum+'teamID')==0){
						signPrompted=true;
						updateNavMenu(null, 1, 1);
						document.getElementById('playerSelectDiv').style.display='none';
						document.getElementById('signNumGamesDiv').style.display='';
					}
					break;
				case (2):
					displayPlayerInfo();
					break;
				case (3):
					navMenu.updateActiveSelector(null, 1, 1);
					break;
				}
			} else if (selectingTable) {
				document.getElementById('playerSelectDiv').style.display='';
				navMenu.updateActiveSelector('playerSelector', 3, 1);
			} else {
				switch (navMenu.getRow()){
				case (1):
					sortByTeamId(Number('${myTeam.teamID}'));
					break;
				case (2):
					sortByTeamId(0);
					break;
				case (3):
					if ('${recruitType}' == 'draft'){
						navMenu.updateActiveSelector('confSelector', 3, 1);
					} else {
						window.open('blitzballMenu', '_self');
					}
					break;
				}
			}
		}

		function cancelButtonPressed(){
			if (displayingPlayerInfo){
				closePlayerInfo();
			} else if (signPrompted){
				signPrompted=false;
				document.getElementById('signNumGamesDiv').style.display='none';
				document.getElementById('playerSelectDiv').style.display='';
			} else if (navMenu.getSelector()=='playerSelector'){
				document.getElementById('playerSelectDiv').style.display='none';
				updateNavMenu(null, 1, 1);
			} else if (navMenu.getSelector()=='confSelector'){
				navMenu.updateRow(2);
			} else if (selectingTable) {
				selectingTable=false;
				var rowNum = sortOrder[(selectedPlayer-1)];
				document.getElementById('row'+rowNum).style.backgroundColor='';
				document.getElementById('row'+rowNum+'col'+selectedColumn).style.backgroundColor='';
				selectedColumn=1;
				navMenu.updateActiveSelector('selector', MAXITEMS, MAXITEMS);
			} else {
				navMenu.updateRow(MAXITEMS);
			}
		}

		function signPlayer(){
			var rowNum = sortOrder[(selectedPlayer-1)];
			var salary = Number(document.getElementById('row'+rowNum+'col12').innerHTML);
			var cost = numGames * salary;
			if (availableCash>=cost){
				availableCash-=cost;
				document.getElementById('availableCash').innerHTML=availableCash;
				$("#row"+rowNum).removeClass("team0");
				$("#row"+rowNum).addClass("team${myTeam.teamID}");
				var playerID = document.getElementById('row'+rowNum+'id').innerHTML;
				if ('${recruitType}'!='draft'){
					var req = new XMLHttpRequest();
					req.open("GET", "bbSignPlayer?playerId="+currPlayer.playerID+"&contractLength="+numGames, true);
					req.send();
				}
				sortByTeamID('${myTeam.teamID}');
			} else {
				window.alert("You can't afford that!");
			}
		}

		function sortByTeamId(teamID){
			MAXROWS=TOTALMAXROWS;
			for (var i=0; i<teamIDs.length; i++){
				var currID=teamIDs[i];
				if (teamID&&currID!=teamID){
					$(".team"+currID).each(function(){
						$(this).style.display="table-row";
					});
				} else {
					$(".team"+currID).each(function(){
						$(this).style.display="none";
						MAXROWS--;
					});
				}
			}
		}

		function sortButtonPressed(){
			if (selectingTable&&!displayingPlayerInfo){
				var rowNum = sortOrder[(selectedPlayer-1)];
				document.getElementById('row'+rowNum).style.backgroundColor='';
				document.getElementById('row'+rowNum+'col'+selectedColumn).style.backgroundColor='';

				if (selectedColumn==sortCol){
					sortOrder.reverse();
				} else {
					sortCol=selectedColumn;
					sortOrder = [];
					sortOrder.push(1);
					for (var i=2; i<=MAXROWS; i++){
						for (var j=0; j<sortOrder.length; j++){
							var val1;
							var val2;
							if (sortCol!=1){
								val1=Number(document.getElementById('row'+i+'col'+selectedColumn).innerHTML);
								val2=Number(document.getElementById('row'+sortOrder[j]+'col'+selectedColumn).innerHTML);
							} else {
								val2=document.getElementById('row'+i+'col'+selectedColumn).innerHTML;
								val1=document.getElementById('row'+sortOrder[j]+'col'+selectedColumn).innerHTML;
							}
							if (val1>val2){
								sortOrder.splice(j, 0, i);
								break;
							} else if (j==sortOrder.length-1){
								sortOrder.push(i);
								break;
							}
						}
					}
				}
				
				for (var i=sortOrder.length-2; i>=0; i--){
					document.getElementById('scroller').insertBefore(document.getElementById('row'+sortOrder[i]), document.getElementById('row'+sortOrder[i+1]));
				}
				
				rowNum = sortOrder[(selectedPlayer-1)];
				document.getElementById('row'+rowNum).style.backgroundColor='yellow';
				document.getElementById('row'+rowNum+'col'+selectedColumn).style.backgroundColor='red';
			}
		}

		function onKeyDown(event){
			if (displayingPlayerInfo){
				try{
					document.getElementById('playerTechFrame').contentWindow.onKeyDown(event);
				} catch (e){
					closePlayerInfo();
					displayingPlayerInfo=false;
				}
			} else {
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
			} else if (event.keyCode==83){
				event.preventDefault();
				sortButtonPressed();
			}
			}
		}

		function loadPlayer(){
		}

		function displayPlayerInfo(){
			document.getElementById('statTable').style.display='none';
			document.getElementById('navMenu').style.display='none';
			parent.loadPlayer('test');
			//var index = sortOrder.indexOf(selectedPlayer);
			var rowNum = sortOrder[(selectedPlayer-1)];
			var playerId = document.getElementById('row'+rowNum+'id').innerHTML;
			var model=document.getElementById('row'+rowNum+'model').innerHTML;
			parent.loadPlayer(model);
			displayingPlayerInfo=true;
			document.getElementById('playerStatFrame').src='bbStatDisplay?id='+playerId;
			document.getElementById('playerStatFrame').style.display='';
			document.getElementById('playerTechFrame').src='bbTechDisplay?id='+playerId;
			document.getElementById('playerTechFrame').style.display='';
		}

		function closePlayerInfo(){
			document.getElementById('statTable').style.display='table';
			document.getElementById('navMenu').style.display='';
			parent.unloadPlayer();
			displayingPlayerInfo=false;
			document.getElementById('playerStatFrame').src='';
			document.getElementById('playerStatFrame').style.display='none';
			document.getElementById('playerTechFrame').src='';
			document.getElementById('playerTechFrame').style.display='none';
		}

		window.onload = function(){
			for (var i=0; i<MAXROWS; i++){
				sortOrder.push((i+1));
			}
		}

	</script>

</body>
</html>