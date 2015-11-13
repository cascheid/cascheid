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
		
		<div id="statTable" style="display:table; table-layout:fixed; position: absolute; left:30%; top:20%; width:65vw;">
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
			</div>
			</c:forEach>
			</div>
		</div>
		
		<iframe id="playerStatFrame" style="position:absolute; top:40%; left:50%; width:50%; height:60%" frameborder=0 onload="setupTechsForCurrentPlayer();"></iframe>
		
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
		
		<div id="techInfoDiv">
			<label id="techInfoName" style="color: #FFFF66"></label><br/>
			<label id="techInfoStats"></label>
			<p id="techInfoDescription" style="white-space:pre-wrap;"></p>
		</div>
		<div id="displayedTechsContainer" class="menu" style="display:none"> 
			<img id="techSelector" class="selector" src="img/blitzball/arrow.png" style="left:0vmin"/>
			<div id="techPage1" style="display:table; width:100%;">
				<div style="display:table-row">
					<div style="display:table-cell; padding-left:5vmin; width:30vw"><label id="tech1"></label></div>
					<div style="display:table-cell; padding-left:5vmin; width:30vw"><label id="tech12"></label></div>
					<div style="display:table-cell; padding-left:5vmin; width:20vw"><label id="tech23"></label></div>
				</div>
				<div style="display:table-row">
					<div style="display:table-cell; padding-left:5vmin; width:30vw"><label id="tech2"></label></div>
					<div style="display:table-cell; padding-left:5vmin; width:30vw"><label id="tech13"></label></div>
					<div style="display:table-cell; padding-left:5vmin; width:20vw"><label id="tech24"></label></div>
				</div>
				<div style="display:table-row">
					<div style="display:table-cell; padding-left:5vmin; width:30vw"><label id="tech3">Sphere Shot</label></div>
					<div style="display:table-cell; padding-left:5vmin; width:30vw"><label id="tech14">Venom Pass</label></div>
					<div style="display:table-cell; padding-left:5vmin; width:20vw"><label id="tech25">Volley Shot 3</label></div>
				</div>
				<div style="display:table-row">
					<div style="display:table-cell; padding-left:5vmin; width:30vw"><label id="tech4">Invisible Shot</label></div>
					<div style="display:table-cell; padding-left:5vmin; width:30vw"><label id="tech15">Venom Pass 2</label></div>
					<div style="display:table-cell; padding-left:5vmin; width:20vw"><label id="tech26">Venom Tackle</label></div>
				</div>
				<div style="display:table-row">
					<div style="display:table-cell; padding-left:5vmin; width:30vw"><label id="tech5">Venom Shot</label></div>
					<div style="display:table-cell; padding-left:5vmin; width:30vw"><label id="tech16">Venom Pass 3</label></div>
					<div style="display:table-cell; padding-left:5vmin; width:20vw"><label id="tech27">Venom Tackle 2</label></div>
				</div>
				<div style="display:table-row">
					<div style="display:table-cell; padding-left:5vmin; width:30vw"><label id="tech6">Venom Shot 2</label></div>
					<div style="display:table-cell; padding-left:5vmin; width:30vw"><label id="tech17">Nap Pass</label></div>
					<div style="display:table-cell; padding-left:5vmin; width:20vw"><label id="tech28">Venom Tackle 3</label></div>
				</div>
				<div style="display:table-row">
					<div style="display:table-cell; padding-left:5vmin; width:30vw"><label id="tech7">Venom Shot 3</label></div>
					<div style="display:table-cell; padding-left:5vmin; width:30vw"><label id="tech18">Nap Pass 2</label></div>
					<div style="display:table-cell; padding-left:5vmin; width:20vw"><label id="tech29">Nap Tackle</label></div>
				</div>
				<div style="display:table-row">
					<div style="display:table-cell; padding-left:5vmin; width:30vw"><label id="tech8">Nap Shot</label></div>
					<div style="display:table-cell; padding-left:5vmin; width:30vw"><label id="tech19">Nap Pass 3</label></div>
					<div style="display:table-cell; padding-left:5vmin; width:20vw"><label id="tech30">Nap Tackle 2</label></div>
				</div>
				<div style="display:table-row">
					<div style="display:table-cell; padding-left:5vmin; width:30vw"><label id="tech9">Nap Shot 2</label></div>
					<div style="display:table-cell; padding-left:5vmin; width:30vw"><label id="tech20">Wither Pass</label></div>
					<div style="display:table-cell; padding-left:5vmin; width:20vw"><label id="tech31">Nap Tackle 3</label></div>
				</div>
				<div style="display:table-row">
					<div style="display:table-cell; padding-left:5vmin; width:30vw"><label id="tech10">Nap Shot 3</label></div>
					<div style="display:table-cell; padding-left:5vmin; width:30vw"><label id="tech21">Wither Pass 2</label></div>
					<div style="display:table-cell; padding-left:5vmin; width:20vw"><label id="tech32">Wither Tackle</label></div>
				</div>
				<div style="display:table-row">
					<div style="display:table-cell; padding-left:5vmin; width:30vw"><label id="tech11">Wither Shot</label></div>
					<div style="display:table-cell; padding-left:5vmin; width:30vw"><label id="tech22">Wither Pass 3</label></div>
					<div style="display:table-cell; padding-left:5vmin; width:20vw"><label>Next Page</label></div>
				</div>
			</div>
			<div id="techPage2" style="display:table; width:100%; display:none">
				<div style="display:table-row">
					<div style="display:table-cell; padding-left:5vmin; width:30vw"><label id="tech33">Wither Tackle 2</label></div>
					<div style="display:table-cell; padding-left:5vmin; width:30vw"><label id="tech44">Anti-Wither</label></div>
					<div style="display:table-cell; padding-left:5vmin; width:20vw"><label id="tech55">Good Morning!</label></div>
				</div>
				<div style="display:table-row">
					<div style="display:table-cell; padding-left:5vmin; width:30vw"><label id="tech34">Wither Tackle 3</label></div>
					<div style="display:table-cell; padding-left:5vmin; width:30vw"><label id="tech45">Anti-Wither 2</label></div>
					<div style="display:table-cell; padding-left:5vmin; width:20vw"><label id="tech56">Hi-Risk</label></div>
				</div>
				<div style="display:table-row">
					<div style="display:table-cell; padding-left:5vmin; width:30vw"><label id="tech35">Drain Tackle</label></div>
					<div style="display:table-cell; padding-left:5vmin; width:30vw"><label id="tech46">Anti-Drain</label></div>
					<div style="display:table-cell; padding-left:5vmin; width:20vw"><label id="tech57">Golden-Arm</label></div>
				</div>
				<div style="display:table-row">
					<div style="display:table-cell; padding-left:5vmin; width:30vw"><label id="tech36">Drain Tackle 2</label></div>
					<div style="display:table-cell; padding-left:5vmin; width:30vw"><label id="tech47">Anti-Drain 2</label></div>
					<div style="display:table-cell; padding-left:5vmin; width:20vw"><label id="tech58">Gamble</label></div>
				</div>
				<div style="display:table-row">
					<div style="display:table-cell; padding-left:5vmin; width:30vw"><label id="tech37">Drain Tackle 3</label></div>
					<div style="display:table-cell; padding-left:5vmin; width:30vw"><label id="tech48">Spin Ball</label></div>
					<div style="display:table-cell; padding-left:5vmin; width:20vw"><label id="tech59">Super Goalie</label></div>
				</div>
				<div style="display:table-row">
					<div style="display:table-cell; padding-left:5vmin; width:30vw"><label id="tech38">Tackle Slip</label></div>
					<div style="display:table-cell; padding-left:5vmin; width:30vw"><label id="tech49">Grip Gloves</label></div>
					<div style="display:table-cell; padding-left:5vmin; width:20vw"><label id="tech60">Aurochs Spirit</label></div>
				</div>
				<div style="display:table-row">
					<div style="display:table-cell; padding-left:5vmin; width:30vw"><label id="tech39">Tackle Slip 2</label></div>
					<div style="display:table-cell; padding-left:5vmin; width:30vw"><label id="tech50">Elite Defense</label></div>
					<div style="display:table-cell; padding-left:5vmin; width:20vw"><label id="tech61"></label></div>
				</div>
				<div style="display:table-row">
					<div style="display:table-cell; padding-left:5vmin; width:30vw"><label id="tech40">Anti-Venom</label></div>
					<div style="display:table-cell; padding-left:5vmin; width:30vw"><label id="tech51">Brawler</label></div>
					<div style="display:table-cell; padding-left:5vmin; width:20vw"><label id="tech62"></label></div>
				</div>
				<div style="display:table-row">
					<div style="display:table-cell; padding-left:5vmin; width:30vw"><label id="tech41">Anti-Venom 2</label></div>
					<div style="display:table-cell; padding-left:5vmin; width:30vw"><label id="tech52">Pile Venom</label></div>
					<div style="display:table-cell; padding-left:5vmin; width:20vw"><label id="tech63"></label></div>
				</div>
				<div style="display:table-row">
					<div style="display:table-cell; padding-left:5vmin; width:30vw"><label id="tech42">Anti-Nap</label></div>
					<div style="display:table-cell; padding-left:5vmin; width:30vw"><label id="tech53">Pile Wither</label></div>
					<div style="display:table-cell; padding-left:5vmin; width:20vw"><label id="tech64"></label></div>
				</div>
				<div style="display:table-row">
					<div style="display:table-cell; padding-left:5vmin; width:30vw"><label id="tech43">Anti-Nap 2</label></div>
					<div style="display:table-cell; padding-left:5vmin; width:30vw"><label id="tech54">Regen</label></div>
					<div style="display:table-cell; padding-left:5vmin; width:20vw"><label>Prev Page</label></div>
				</div>
			</div>
			<div style="display:table; width:100%">
				<div style="display:table-row">
					<div style="display:table-cell; color:#00BFFF; width:50vw; padding-left:5vmin">Key Techniques:</div>
					<div style="color: #FFFF66; display:table-cell; width:30vw">Current HP:</div>
				</div>
				<div style="display:table-row">
					<div style="display:table-cell; width:50vw; padding-left:5vmin"><label id="keyTechs"></label></div>
					<div style="display:table-cell; width:30vw"><label id="currHP"></label></div>
				</div>
			</div>
		</div>
		
		<script>
		var menuSelection=1;
		var MAXITEMS=5;
		var popupOpen=false;
		var onOKButton=true;
		var selectingTable=false;
		var selectedPlayer=1;
		var selectedColumn=1;
		var MAXCOL=10;
		var MAXROWS=${statistics.size()};
		var DISPLAYROWS=10;
		var displayingPlayerInfo=false;
		var sortOrder=[];
		var sortCol=2;
		var techList=${techList};
		var currPlayer;
		var pageShowing=0;
		var techCol=1;
		var techRow=1;
		var MAXTECHROWS=11;
		var MAXTECHCOLS=3;
		var emptyDashString='- - - - - - - -';
				
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
			} else if (displayingPlayerInfo){
				if (pageShowing>0){
					if (techRow<=1){
						techRow=MAXTECHROWS;
					} else {
						techRow--;
					}
					document.getElementById('techSelector').style.top=(techRow-1)*4+'vmin';

					var techID=(techCol-1)*MAXTECHROWS+techRow;
					if (pageShowing==2){
						techID=techID+MAXTECHROWS*MAXTECHCOLS-1;
					}
					showTechInfo(techID);
				}
			} else if (selectingTable){
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
				if (sel.offsetTop>=scroller.scrollTop){
					scroller.scrollTop=sel.offsetTop-sel.offsetHeight;
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
					document.getElementById('confSelector').style.top='12vmin';
				} else {
					onOKButton=true;
					document.getElementById('confSelector').style.top='8vmin';
				}
			} else if (displayingPlayerInfo){
				if (pageShowing>0){
					if (techRow>=MAXTECHROWS){
						techRow=1;
					} else {
						techRow++;
					}
					document.getElementById('techSelector').style.top=(techRow-1)*4+'vmin';

					var techID=(techCol-1)*MAXTECHROWS+techRow;
					if (pageShowing==2){
						techID=techID+MAXTECHROWS*MAXTECHCOLS-1;
					}
					showTechInfo(techID);
				}
			} else if (selectingTable){
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
				if (sel.offsetTop-(DISPLAYROWS+1)*sel.offsetHeight>scroller.scrollTop){
					scroller.scrollTop=sel.offsetTop-DISPLAYROWS*sel.offsetHeight;
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

		function leftButtonPressed(){
			if (displayingPlayerInfo){
				if (pageShowing>0){
					if (techCol<=1){
						techCol=MAXTECHCOLS;
					} else {
						techCol--;
					}
					document.getElementById('techSelector').style.left=(techCol-1)*30+'vw';

					var techID=(techCol-1)*MAXTECHROWS+techRow;
					if (pageShowing==2){
						techID=techID+MAXTECHROWS*MAXTECHCOLS-1;
					}
					showTechInfo(techID);
				}
			} else if (selectingTable){
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
			if (displayingPlayerInfo){
				if (pageShowing>0){
					if (techCol>=MAXTECHCOLS){
						techCol=1;
					} else {
						techCol++;
					}
					document.getElementById('techSelector').style.left=(techCol-1)*30+'vw';

					var techID=(techCol-1)*MAXTECHROWS+techRow;
					if (pageShowing==2){
						techID=techID+MAXTECHROWS*MAXTECHCOLS-1;
					}
					showTechInfo(techID);
				}
			} else if (selectingTable){
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
				if (onOKButton){
					window.open("blitzballLeagueGame", "_self");
				} else  {
					onOKButton=true;
					popupOpen=false;
					document.getElementById('confSelector').style.top='8vmin';
					document.getElementById('confirmDiv').style.display='none';
					document.getElementById('selector').style.display='';
				}
			} else if (displayingPlayerInfo){
				if (pageShowing==0){
					techCol=1;
					techRow=1;
					document.getElementById('techSelector').style.left='0vw';
					document.getElementById('techSelector').style.top='0vmin';
					showTechPageCurrPlayer(1);
				} else {
					if (techRow==MAXTECHROWS&&techCol==MAXTECHCOLS){
						if (pageShowing==1){
							showTechPageCurrPlayer(2);
						} else if (pageShowing==2){
							showTechPageCurrPlayer(1);
						}
					}
				}
			} else if (selectingTable&&!displayingPlayerInfo) {
				displayPlayerInfo();
			} else if (!displayingPlayerInfo) {
				if (menuSelection==1){
					document.getElementById('confirmDiv').style.display='';
					popupOpen=true;
					document.getElementById('selector').style.display='none';
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
			if (displayingPlayerInfo){
				if (pageShowing>0){
					pageShowing=0;
					hideTechInfo();
					document.getElementById('displayedTechsContainer').style.display='none';
				} else {
					closePlayerInfo();
				}
			} else if (popupOpen){
				onOKButton=false;
				document.getElementById('confSelector').style.top='12vmin';
			} else if (selectingTable) {
				selectingTable=false;
				var rowNum = sortOrder[(selectedPlayer-1)];
				document.getElementById('row'+rowNum).style.backgroundColor='';
				document.getElementById('row'+rowNum+'col'+selectedColumn).style.backgroundColor='';
				selectedColumn=1;
				menuSelection=MAXITEMS;
				document.getElementById('selector').style.display='';
				document.getElementById('selector').style.top=(menuSelection-1)*4+'vmin';
			} else {
				menuSelection=MAXITEMS;
				document.getElementById('selector').style.top=(menuSelection-1)*4+'vmin';
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
							if (document.getElementById('row'+i+'col'+selectedColumn).innerHTML>document.getElementById('row'+sortOrder[j]+'col'+selectedColumn).innerHTML){
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

		function displayPlayerInfo(){
			document.getElementById('statTable').style.display='none';
			document.getElementById('blitzMenu').style.display='none';
			//parent.loadPlayer('test');
			//var index = sortOrder.indexOf(selectedPlayer);
			var rowNum = sortOrder[(selectedPlayer-1)];
			var playerId = document.getElementById('row'+rowNum+'id').innerHTML;
			displayingPlayerInfo=true;
			document.getElementById('playerStatFrame').src='bbStatDisplay?id='+playerId;
			document.getElementById('playerStatFrame').style.display='';
		}

		function closePlayerInfo(){
			document.getElementById('statTable').style.display='table';
			document.getElementById('blitzMenu').style.display='';
			parent.unloadPlayer();
			displayingPlayerInfo=false;
			document.getElementById('playerStatFrame').src='';
			document.getElementById('playerStatFrame').style.display='none';
		}

		function hideTechInfo(){
			document.getElementById('techInfoName').innerHTML='';
			document.getElementById('techInfoStats').innerHTML='';
			document.getElementById('techInfoDescription').innerHTML='';
		}
		
		function showTechInfo(techNum){
			if (techNum>0){
				var tech = techList[techNum-1];

				if (document.getElementById('tech'+techNum).innerHTML==tech.techName||document.getElementById('tech'+techNum).innerHTML==emptyDashString){
					document.getElementById('techInfoName').innerHTML=tech.techName;
					var statsString='HP Cost: '+tech.hpCost+' ';
					if (tech.techType=='SHOT'){
						statsString+=' SH + '+tech.statMod;
					} else if (tech.techType=='ATTACK'){
						statsString+=' ATK + '+tech.statMod;
					} else if (tech.techType=='PASS'){
						statsString+=' PAS + '+tech.statMod;
					}
					document.getElementById('techInfoStats').innerHTML=statsString;
					document.getElementById('techInfoDescription').innerHTML=tech.techDescription;
				} else {
					hideTechInfo();
				}
			} else {
				hideTechInfo();
			}
		}
		
		function setupTechsForCurrentPlayer(){
			currPlayer=document.getElementById("playerStatFrame").contentWindow.playerInfo;
			
			var numTechs=64;

			document.getElementById('currHP').innerHTML=currPlayer.hp;
			document.getElementById('keyTechs').innerHTML=techList[currPlayer.keyTech1-1].techName+'&nbsp&nbsp&nbsp&nbsp&nbsp'+techList[currPlayer.keyTech2-1].techName+'&nbsp&nbsp&nbsp&nbsp&nbsp'+techList[currPlayer.keyTech3-1].techName;
			
			for (var i=1; i<=numTechs; i++){
				document.getElementById('tech'+i).innerHTML='&nbsp';
			}
			for (var i=0; i<currPlayer.learnableTechs.length; i++){
				document.getElementById('tech'+currPlayer.learnableTechs[i]).innerHTML=emptyDashString;
			}
			for (var i=0; i<currPlayer.learnedTechs.length; i++){
				document.getElementById('tech'+currPlayer.learnedTechs[i]).innerHTML=techList[currPlayer.learnedTechs[i]-1].techName;
			}
		}

		function showTechPageCurrPlayer(pageNum){
			pageShowing=pageNum;
			document.getElementById('displayedTechsContainer').style.display='';
			if (pageNum==1){
				document.getElementById('techPage1').style.display='table';
				document.getElementById('techPage2').style.display='none';
				showTechInfo(1);
			} else if (pageNum==2){
				document.getElementById('techPage2').style.display='table';
				document.getElementById('techPage1').style.display='none';
				showTechInfo(MAXROWS*MAXCOLS);
			}
		}

		window.onload = function(){
			for (var i=0; i<MAXROWS; i++){
				sortOrder.push((i+1));
			}
		}

		</script>

	</body>
</html>