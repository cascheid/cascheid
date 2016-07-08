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
		<style>
			
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
		
	<div id="statTable" style="display:table; table-layout:fixed; position: absolute; left:30%; top:20vmin; width:65vw;">
		<div style="display:table-row; background-color:green; width:100%">
		<div style="display:table-row; width:100%">
			<div class="firstStatCell">Name</div>
			<div class="statCell">Goals</div>
			<div class="statCell">Sht. %</div>
			<div class="statCell">Assists</div>
			<div class="statCell">Saves</div>
			<div class="statCell">Save %</div>
			<div class="statCell">Tackles</div>
			<div class="statCell">Blocks</div>
			<div class="statCell">Breaks</div>
			<div class="lastStatCell">TO</div>
		</div>
		</div>
		<div id="scroller" style="background-color:gray; overflow-y:auto; height:40vmin; width:100%">
		<c:forEach var="player" items="${statistics}" varStatus="status">
		<div id="row${status.count}" style="display:table-row; width:100%">
			<div id="row${status.count}col1" class="firstStatCell">${player.playerName}</div>
			<div id="row${status.count}col2" class="statCell">${player.goals}</div>
			<div id="row${status.count}col3" class="statCell">${Math.round(1000*(player.goals/player.shots))/10}</div>
			<div id="row${status.count}col4" class="statCell">${player.assists}</div>
			<div id="row${status.count}col5" class="statCell">${player.shotsAgainst-player.goalsAgainst}</div>
			<div id="row${status.count}col6" class="statCell">${Math.round(1000*(player.shotsAgainst-player.goalsAgainst)/player.shotsAgainst)/10}</div>
			<div id="row${status.count}col7" class="statCell">${player.tackles}</div>
			<div id="row${status.count}col8" class="statCell">${player.blocks}</div>
			<div id="row${status.count}col9" class="statCell">${player.breaks}</div>
			<div id="row${status.count}col10" class="lastStatCell">${player.turnovers}</div>
			<div id="row${status.count}id" style="display:none">${player.playerID}</div>
			<div id="row${status.count}model" style="display:none">${player.model}</div>
		</div>
		</c:forEach>
		</div>
	</div>
		
	<iframe id="playerStatFrame" style="position:absolute; top:40%; left:50%; width:50%; height:60%; z-index:1000" frameborder=0 ></iframe>
	<iframe id="playerTechFrame" style="position:absolute; top:0; left:0; height:100vh; width:100vw; z-index:1050;" frameborder=0 ></iframe>
	
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
		var MAXITEMS=5;
		var popupOpen=false;
		var selectingTable=false;
		var selectedPlayer=1;
		var selectedColumn=1;
		var MAXCOL=10;
		var MAXROWS=${statistics.size()};
		var DISPLAYROWS=10;
		var displayingPlayerInfo=false;
		var sortOrder=[];
		var sortCol=2;
		var emptyDashString='- - - - - - - -';
		var navMenu = new BBNavMenu('selector', MAXITEMS, 1);
		
		function upButtonPressed(){
			if (selectingTable){
				var rowNum = sortOrder[(selectedPlayer-1)];
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
			if (selectingTable){
				var rowNum = sortOrder[(selectedPlayer-1)];
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
			if (selectingTable){
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
					document.getElementById('selector').style.display='';
				}
			}
		}

		function rightButtonPressed(){
			if (selectingTable){
				if (selectedColumn<MAXCOL){
					var rowNum = sortOrder[(selectedPlayer-1)];
					document.getElementById('row'+rowNum+'col'+selectedColumn).style.backgroundColor='';
					selectedColumn++;
					document.getElementById('row'+rowNum+'col'+selectedColumn).style.backgroundColor='red';
				}
			} else {
				selectingTable=true;
				var rowNum = sortOrder[(selectedPlayer-1)];
				document.getElementById('row'+rowNum).style.backgroundColor='yellow';
				document.getElementById('row'+rowNum+'col'+selectedColumn).style.backgroundColor='red';
				document.getElementById('selector').style.display='none';
			}
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
			} else if (selectingTable) {
				displayPlayerInfo();
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
			if (displayingPlayerInfo){
				closePlayerInfo();
			} else if (popupOpen){
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
					}/*
					if (selectedColumn==1){
						sortOrder=${sortCol1};
					} else if (selectedColumn==2){
						sortOrder=${sortCol2};
					} else if (selectedColumn==3){
						sortOrder=${sortCol3};
					} else if (selectedColumn==4){
						sortOrder=${sortCol4};
					} else if (selectedColumn==5){
						sortOrder=${sortCol5};
					} else if (selectedColumn==6){
						sortOrder=${sortCol6};
					} else if (selectedColumn==7){
						sortOrder=${sortCol7};
					} else if (selectedColumn==8){
						sortOrder=${sortCol8};
					} else if (selectedColumn==9){
						sortOrder=${sortCol9};
					} else if (selectedColumn==10){
						sortOrder=${sortCol10};
					}*/
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