<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
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
			
			#playerMenu{
				font-size:3.5vmin;
				color: #ffffff;
				position:absolute;
				top:10vmin;
				width:20%;
				left:10%;
				z-index:1000;
				line-height:4vmin;
				padding:0px;
			}
			
			#techListDisplay{
				font-size:3.5vmin;
				position:absolute;
				top:65vmin;
				line-height:4vmin;
				width:20%;
				left:15%;
				background:none transparent;
				z-index:1000;
			}
			
			#infoDiv{
				font-size:3.5vmin;
				line-height:4vmin;
				color: #ffffff;
				position:absolute;
				top:55vmin;
				left:40%;
				background:none transparent;
				z-index:1000;
			}
			
			#oppPlayersDiv{
				font-size:3.5vmin;
				line-height:4vmin;
				color: #ffffff;
				position:absolute;
				top:10vmin;
				left:40%;
				background:none transparent;
				z-index:1000;
				white-space: nowrap;
			}
			
			#playerDisplay{
				position:absolute;
				top:0vmin;
				left:0vmin;
			}
			
			#oppPlayerList{
				position:absolute;
				top:4vmin;
				left:40vmin;
			}
			
			#selector{
				position:absolute;
				left:10vmin;
				top:4vmin;
				width:5vmin;
				height:4vmin;
			}
			
			#oppSelector{
				position:absolute;
				left:-5vmin;
				top:0vmin;
				width:5vmin;
				height:4vmin;
			}
			
			#confSelector{
				position:absolute;
				left:0vh;
				top:4vh;
				width:5vh;
				height:4vh;
			}
			
			#confirmDiv{
				position:absolute;
				color: #ffffff;
				font-size:3.5vh;
				line-height:4vh;
				top:40%;
				width:16%;
				height:16vmin;
				left:42%;
				background-color:#6B238E;
				background-image: url("img/blitzball/cracks.png");
				border: 5px double white;
				z-index:1001;
			}
			
			.crossDiv{
				position:absolute;
				background: rgba(0,0,0,.75);
				border: .2vmin solid rgba(255, 255, 255, .75);
				box-shadow: 0 0 2vmin #000000;
			}
			
			#displayedTechsContainer{
				position:absolute;
				color: #ffffff;
				font-size:3.5vmin;
				line-height:4vmin;
				top:40%;
				width:81%;
				height:55%;
				left:10%;
				background-color:#6B238E;
				background-image: url("img/blitzball/cracks.png");
				border: 5px double white;
				z-index:1001;
			}
			
			.stat{
				text-align:left;
				color: #87CEFA;
				display: table-cell; 
				width:8vmin;
				padding-left:0.5vmin
			}
			
			.num{
				text-align:right;
				color: #FFFF66;
				display: table-cell; 
				width:8vmin;
			}
		</style>
	</head>

	<body>
		<div class="crossDiv" style="left:10%; top:0; width:10vmin; height:47.7vmin"></div>
		<div id="playerMenu">
			<img id="selector" src="img/blitzball/arrow.png" />
			<div style="display:table-row">
				<div style="display: table-cell; width:10vmin"></div>
				<div style="display: table-cell"><label style="padding-left:5vmin">Set Marks</label></div>
			</div>
			<div style="display:table-row">
				<div style="display: table-cell; width:10vmin"><label style="padding-left:2vmin">LF</label></div>
				<div style="display: table-cell"><label style="padding-left:5vmin" id="players1"></label><label id="marks1" style="display:none">7</label></div>
			</div>
			<div style="display:table-row">
				<div style="display: table-cell; width:10vmin"><label style="padding-left:2vmin">RF</label></div>
				<div style="display: table-cell"><label style="padding-left:5vmin" id="players2"></label><label id="marks2" style="display:none">7</label></div>
			</div>
			<div style="display:table-row">
				<div style="display: table-cell; width:10vmin"><label style="padding-left:2vmin">MF</label></div>
				<div style="display: table-cell"><label style="padding-left:5vmin" id="players3"></label><label id="marks3" style="display:none">7</label></div>
			</div>
			<div style="display:table-row">
				<div style="display: table-cell; width:10vmin"><label style="padding-left:2vmin">LD</label></div>
				<div style="display: table-cell"><label style="padding-left:5vmin" id="players4"></label><label id="marks4" style="display:none">7</label></div>
			</div>
			<div style="display:table-row">
				<div style="display: table-cell; width:10vmin"><label style="padding-left:2vmin">RD</label></div>
				<div style="display: table-cell"><label style="padding-left:5vmin" id="players5"></label><label id="marks5" style="display:none">7</label></div>
			</div>
			<div style="display:table-row">
				<div style="display: table-cell; width:10vmin"><label style="padding-left:2vmin">GK</label></div>
				<div style="display: table-cell"><label style="padding-left:5vmin" id="players6"></label><label id="marks6" style="display:none">7</label></div>
			</div>
			<div style="display:table-row">
				<div style="display: table-cell; width:10vmin"></div>
				<div style="display: table-cell"><label style="padding-left:5vmin">Done</label></div>
			</div>
		</div>
		<div class="crossDiv" style="left:38%; top:0; width:2vmin; height:100%"></div>
		<div id="techListDisplay">
			<div id="lwTechList">
				<div style="width:100%">
				<label id="lwTechSlot1" style="color:#ffffff;"></label>
				<label id="lwTechID1" style="display:none">0</label>
				</div>
				<div style="width:100%">
				<label id="lwTechSlot2" style="color:#ffffff;"></label>
				<label id="lwTechID2" style="display:none">0</label>
				</div>
				<div style="width:100%">
				<label id="lwTechSlot3" style="color:#ffffff;"></label>
				<label id="lwTechID3" style="display:none">0</label>
				</div>
				<div style="width:100%">
				<label id="lwTechSlot4" style="color:#ffffff;"></label>
				<label id="lwTechID4" style="display:none">0</label>
				</div>
				<div style="width:100%">
				<label id="lwTechSlot5" style="color:#ffffff;"></label>
				<label id="lwTechID5" style="display:none">0</label>
				</div>
			</div>
			
			<div id="rwTechList" style="display:none">
				<div style="width:100%">
				<label id="rwTechSlot1" style="color:#ffffff;"></label>
				<label id="rwTechID1" style="display:none">0</label>
				</div>
				<div style="width:100%">
				<label id="rwTechSlot2" style="color:#ffffff;"></label>
				<label id="rwTechID2" style="display:none">0</label>
				</div>
				<div style="width:100%">
				<label id="rwTechSlot3" style="color:#ffffff;"></label>
				<label id="rwTechID3" style="display:none">0</label>
				</div>
				<div style="width:100%">
				<label id="rwTechSlot4" style="color:#ffffff;"></label>
				<label id="rwTechID4" style="display:none">0</label>
				</div>
				<div style="width:100%">
				<label id="rwTechSlot5" style="color:#ffffff;"></label>
				<label id="rwTechID5" style="display:none">0</label>
				</div>
			</div>
			
			<div id="mfTechList" style="display:none">
				<div style="width:100%">
				<label id="mfTechSlot1" style="color:#ffffff;"></label>
				<label id="mfTechID1" style="display:none">0</label>
				</div>
				<div style="width:100%">
				<label id="mfTechSlot2" style="color:#ffffff;"></label>
				<label id="mfTechID2" style="display:none">0</label>
				</div>
				<div style="width:100%">
				<label id="mfTechSlot3" style="color:#ffffff;"></label>
				<label id="mfTechID3" style="display:none">0</label>
				</div>
				<div style="width:100%">
				<label id="mfTechSlot4" style="color:#ffffff;"></label>
				<label id="mfTechID4" style="display:none">0</label>
				</div>
				<div style="width:100%">
				<label id="mfTechSlot5" style="color:#ffffff;"></label>
				<label id="mfTechID5" style="display:none">0</label>
				</div>
			</div>
			
			<div id="lbTechList" style="display:none">
				<div style="width:100%">
				<label id="lbTechSlot1" style="color:#ffffff;"></label>
				<label id="lbTechID1" style="display:none">0</label>
				</div>
				<div style="width:100%">
				<label id="lbTechSlot2" style="color:#ffffff;"></label>
				<label id="lbTechID2" style="display:none">0</label>
				</div>
				<div style="width:100%">
				<label id="lbTechSlot3" style="color:#ffffff;"></label>
				<label id="lbTechID3" style="display:none">0</label>
				</div>
				<div style="width:100%">
				<label id="lbTechSlot4" style="color:#ffffff;"></label>
				<label id="lbTechID4" style="display:none">0</label>
				</div>
				<div style="width:100%">
				<label id="lbTechSlot5" style="color:#ffffff;"></label>
				<label id="lbTechID5" style="display:none">0</label>
				</div>
			</div>
			
			<div id="rbTechList" style="display:none">
				<div style="width:100%">
				<label id="rbTechSlot1" style="color:#ffffff;"></label>
				<label id="rbTechID1" style="display:none">0</label>
				</div>
				<div style="width:100%">
				<label id="rbTechSlot2" style="color:#ffffff;"></label>
				<label id="rbTechID2" style="display:none">0</label>
				</div>
				<div style="width:100%">
				<label id="rbTechSlot3" style="color:#ffffff;"></label>
				<label id="rbTechID3" style="display:none">0</label>
				</div>
				<div style="width:100%">
				<label id="rbTechSlot4" style="color:#ffffff;"></label>
				<label id="rbTechID4" style="display:none">0</label>
				</div>
				<div style="width:100%">
				<label id="rbTechSlot5" style="color:#ffffff;"></label>
				<label id="rbTechID5" style="display:none">0</label>
				</div>
			</div>
			
			<div id="gkTechList" style="display:none">
				<div style="width:100%">
				<label id="gkTechSlot1" style="color:#ffffff;"></label>
				<label id="gkTechID1" style="display:none">0</label>
				</div>
				<div style="width:100%">
				<label id="gkTechSlot2" style="color:#ffffff;"></label>
				<label id="gkTechID2" style="display:none">0</label>
				</div>
				<div style="width:100%">
				<label id="gkTechSlot3" style="color:#ffffff;"></label>
				<label id="gkTechID3" style="display:none">0</label>
				</div>
				<div style="width:100%">
				<label id="gkTechSlot4" style="color:#ffffff;"></label>
				<label id="gkTechID4" style="display:none">0</label>
				</div>
				<div style="width:100%">
				<label id="gkTechSlot5" style="color:#ffffff;"></label>
				<label id="gkTechID5" style="display:none">0</label>
				</div>
			</div>
		</div>
		<div class="crossDiv" style="left:0; top:48vmin; width:100%; height:2vmin"></div>
		
		<div id="oppPlayersDiv">
			<div id="playerDisplay" style="width: 49%;">
			<div>
				<label id="displayName" style="color:#ffffff;">No Mark</label>
			</div>
			<div id="displayTable" style="display:table; visibility:none">
				<div style="display:table-row">
					<div class="stat"></div>
					<div class="stat"></div>
					<div class="stat" style="text-align:right;"><label>Lv</label></div>
					<div class="num" style="text-align:left; padding-left:0.5vmin"><label id="lvlDisplay"></label></div>
				</div>
				<div style="display:table-row">
					<div class="stat"></div>
					<div class="num"><label id="expDisplay"></label></div>
					<div class="stat"><label>EXP</label></div>
					<div class="stat"><label>LEFT</label></div>
				</div>
				<div style="display:table-row">
					<div class="num"><label id="spdDisplay"></label></div>
					<div class="stat"><label>SPD</label></div>
					<div class="num"><label id="hpDisplay"></label></div>
					<div class="stat"><label>HP</label></div>
				</div>
				<div style="display:table-row">
					<div class="num" style=""><label id="endDisplay" ></label></div>
					<div class="stat"><label >END</label></div>
					<div class="num"><label id="atkDisplay"></label></div>
					<div class="stat"><label>ATK</label></div>
				</div>
				<div style="display:table-row">
					<div class="num"><label id="pasDisplay"></label></div>
					<div class="stat"><label>PAS</label></div>
					<div class="num"><label id="blkDisplay"></label></div>
					<div class="stat"><label>BLK</label></div>
				</div>
				<div style="display:table-row">
					<div class="num"><label id="shtDisplay"></label></div>
					<div class="stat"><label>SHT</label></div>
					<div class="num"><label id="catDisplay"></label></div>
					<div class="stat"><label>CAT</label></div>
				</div>
			</div>
			</div>
			<div id="oppPlayerList" style="width:49%; visibility:hidden">
				<img id="oppSelector" src="img/blitzball/arrow.png" style="display:none"/>
				<div style="width:100%">
					<label id="oppPlayers1" style="color:#ffffff;"></label>
				</div>
				<div style="width:100%">
					<label id="oppPlayers2" style="color:#ffffff;"></label>
				</div>
				<div style="width:100%">
					<label id="oppPlayers3" style="color:#ffffff;"></label>
				</div>
				<div style="width:100%">
					<label id="oppPlayers4" style="color:#ffffff;"></label>
				</div>
				<div style="width:100%">
					<label id="oppPlayers5" style="color:#ffffff;"></label>
				</div>
				<div style="width:100%">
					<label id="oppPlayers6" style="color:#ffffff;"></label>
				</div>
				<div style="width:100%">
					<label style="color:#ffffff;">No Mark</label>
				</div>
			</div>
			<form:form id="marksForm" action="setBBGameMarks" commandName="blitzballGameMarks">
				<form:hidden id="targets1" path="leftWingTarget" value="0"></form:hidden>
				<form:hidden id="targets2" path="rightWingTarget" value="0"></form:hidden>
				<form:hidden id="targets3" path="midfielderTarget" value="0"></form:hidden>
				<form:hidden id="targets4" path="leftBackTarget" value="0"></form:hidden>
				<form:hidden id="targets5" path="rightBackTarget" value="0"></form:hidden>
				<form:hidden id="targets6" path="keeperTarget" value="0"></form:hidden>
			</form:form>
		</div>
		
		<div id="infoDiv">
		<label style="color:#FFFF66">Set Player Techniques</label>
		<p>Players level three and up<br/>
		can use techniques.<br/>
		Available slots increase as<br/>
		a player levels up, up to<br/>
		a maximum of five slots.<br/>
		</p>
		</div>
		
		<div id="confirmDiv" style="display:none">
			<img id="confSelector" src="img/blitzball/arrow.png" />
			<div style="width:100%; padding-left:2.5vh">
			<label>Proceed?</label>
			</div>
			<div style="width:100%; padding-left:5vh">
			<label>Play</label>
			</div>
			<div style="width:100%; padding-left:5vh">
			<label>Start Over</label>
			</div>
			<div style="width:100%; padding-left:5vh">
			<label>Cancel</label>
			</div>
		</div>
		
		<script>
		//document.getElementById('displayedTechsContainer').style.display='none';
		var menuSelection=1;
		var playerSelected=false;
		var oppPlayerRow=7;
		var selectedPrefix='lw';
		var techList=${techList};
		var emptyDashString='- - - - - - - -';
		var submitted=false;
		var myTeam;
		var oppTeam;
		var prompted=false;
		var promptList=1;
		
		
		document.getElementById('players1').focus();
		document.body.onkeydown = function(e){
		    onKeyDown(e);
		};

		function upButtonPressed(){
			if (prompted){
				if (promptList==1){
					promptList==3;
				} else {
					promptList--;
				}
				document.getElementById('confSelector').style.top=promptList*4+'vh';
			} else if (playerSelected){
				if (oppPlayerRow<=1){
					oppPlayerRow=7;
				} else {
					oppPlayerRow--;
				}
				document.getElementById('oppSelector').style.top=(oppPlayerRow-1)*4+'vmin';

				showPlayerInfo(oppPlayerRow);
			} else {
				if (menuSelection<=1){
					menuSelection=7;
				} else {
					menuSelection--;
				}
				document.getElementById('selector').style.top=(menuSelection)*4+'vmin';
				changeHighlightedPlayer(menuSelection);
			}
		}

		function downButtonPressed(){
			if (prompted){
				if (promptList==3){
					promptList==1;
				} else {
					promptList++;
				}
				document.getElementById('confSelector').style.top=promptList*4+'vh';
			} else if (playerSelected){
				if (oppPlayerRow>=7){
					oppPlayerRow=1;
				} else {
					oppPlayerRow++;
				}
				document.getElementById('oppSelector').style.top=(oppPlayerRow-1)*4+'vmin';

				showPlayerInfo(oppPlayerRow);
			} else {
				if (menuSelection>=7){
					menuSelection=1;
				} else {
					menuSelection++;
				}
				document.getElementById('selector').style.top=(menuSelection)*4+'vmin';
				changeHighlightedPlayer(menuSelection);
			}
		}
		
		function selectButtonPressed(){
			if (!submitted){
				if (playerSelected){
					playerSelected=false;
					document.getElementById('marks'+menuSelection).innerHTML=oppPlayerRow;
					if (oppPlayerRow==1){
						document.getElementById('targets'+menuSelection).value=oppTeam.leftWing.playerID;
					} else if (oppPlayerRow==2){
						document.getElementById('targets'+menuSelection).value=oppTeam.rightWing.playerID;
					} else if (oppPlayerRow==3){
						document.getElementById('targets'+menuSelection).value=oppTeam.midfielder.playerID;
					} else if (oppPlayerRow==4){
						document.getElementById('targets'+menuSelection).value=oppTeam.leftBack.playerID;
					} else if (oppPlayerRow==5){
						document.getElementById('targets'+menuSelection).value=oppTeam.rightBacl.playerID;
					} else if (oppPlayerRow==6){
						document.getElementById('targets'+menuSelection).value=oppTeam.keeper.playerID;
					} else {
						document.getElementById('targets'+menuSelection).value=0;
					}
					document.getElementById('oppSelector').style.display='none';
					document.getElementById('selector').style.display='';
					document.getElementById('oppPlayerList').style.visibility='hidden';
				} else {
					if (menuSelection==7){
						if (prompted){
							if (promptList==1){
								submitted=true;
								document.getElementById('marksForm').submit();
							} else if (promptList==3){
								promptList=1;
								document.getElementById('confirmDiv').style.display='none';
								document.getElementById('confSelector').style.top='4vh';
								document.getElementById('selector').style.display='';
								prompted=false;
							} else if (promptList==2){
								window.open("blitzballLeagueGame", "_self");
							}
						} else {
							prompted=true;
							document.getElementById('confirmDiv').style.display='';
							document.getElementById('selector').style.display='none';
						}
					} else {
						playerSelected=true;
						document.getElementById('oppSelector').style.top=(oppPlayerRow-1)*4+'vmin';
						document.getElementById('oppSelector').style.display='';
						document.getElementById('oppPlayerList').style.visibility='';
						document.getElementById('selector').style.display='none';
					}
				}
			}
		}

		function cancelButtonPressed(){
			if (prompted){
				promptList=3;
				document.getElementById('confSelector').style.top='12vh';
			} else if (playerSelected){
				playerSelected=false;
				document.getElementById('oppSelector').style.display='none';
				document.getElementById('oppPlayerList').style.visibility='hidden';
				document.getElementById('selector').style.display='';
				changeHighlightedPlayer(menuSelection);
			} else {
				menuSelection=7;
				document.getElementById('selector').style.top=(menuSelection)*4+'vmin';
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

		function showPlayerInfo(playerNo){
			if (playerNo>=7){//no mark
				document.getElementById('displayName').innerHTML='No Mark';
				document.getElementById('displayTable').style.visibility='hidden';

				document.getElementById('lwTechList').style.display='none';
				document.getElementById('rwTechList').style.display='none';
				document.getElementById('mfTechList').style.display='none';
				document.getElementById('lbTechList').style.display='none';
				document.getElementById('rbTechList').style.display='none';
				document.getElementById('gkTechList').style.display='none';
			} else if (playerNo>0){
				var playerInfo;
				var currPrefix='';
				if (playerNo==1){
					playerInfo=oppTeam.leftWing;
					currPrefix='lw';
				} else if (playerNo==2){
					playerInfo=oppTeam.rightWing;
					currPrefix='rw';
				} else if (playerNo==3){
					playerInfo=oppTeam.midfielder;
					currPrefix='mf';
				} else if (playerNo==4){
					playerInfo=oppTeam.leftBack;
					currPrefix='lb';
				} else if (playerNo==5){
					playerInfo=oppTeam.rightBack;
					currPrefix='rb';
				} else if (playerNo==6){
					playerInfo=oppTeam.keeper;
					currPrefix='gk';
				} else if (playerNo==7){
					playerInfo=oppTeam.bench1;
				} else if (playerNo==8){
					playerInfo=oppTeam.bench2;
				}

				document.getElementById('displayName').innerHTML=playerInfo.name;
				document.getElementById('lvlDisplay').innerHTML=playerInfo.level;
				document.getElementById('expDisplay').innerHTML=playerInfo.nextExp;
				document.getElementById('spdDisplay').innerHTML=playerInfo.speed;
				document.getElementById('endDisplay').innerHTML=playerInfo.endurance;
				document.getElementById('hpDisplay').innerHTML=playerInfo.hp;
				document.getElementById('atkDisplay').innerHTML=playerInfo.attack;
				document.getElementById('pasDisplay').innerHTML=playerInfo.pass;
				document.getElementById('shtDisplay').innerHTML=playerInfo.shot;
				document.getElementById('blkDisplay').innerHTML=playerInfo.block;
				document.getElementById('catDisplay').innerHTML=playerInfo.cat;
				document.getElementById('displayTable').style.visibility='';

				document.getElementById('lwTechList').style.display='none';
				document.getElementById('rwTechList').style.display='none';
				document.getElementById('mfTechList').style.display='none';
				document.getElementById('lbTechList').style.display='none';
				document.getElementById('rbTechList').style.display='none';
				document.getElementById('gkTechList').style.display='none';


				if (menuSelection==1){
					playerInfo=myTeam.leftWing;
				} else if (menuSelection==2){
					playerInfo=myTeam.rightWing;
				} else if (menuSelection==3){
					playerInfo=myTeam.midfielder;
				} else if (menuSelection==4){
					playerInfo=myTeam.leftBack;
				} else if (menuSelection==5){
					playerInfo=myTeam.rightBack;
				} else if (menuSelection==6){
					playerInfo=myTeam.keeper;
				}
				
				for (var i=1; i<6; i++){
					var techID=document.getElementById(currPrefix+'TechID'+i).innerHTML;
					document.getElementById(currPrefix+'TechSlot'+i).style.color='#FFFFFF';
					for (var j=0; j<playerInfo.learnableTechs.length; j++){
						if (playerInfo.learnableTechs[j]==techID){
							document.getElementById(currPrefix+'TechSlot'+i).style.color='#87CEFA';
							break;
						}
					}
				}
				document.getElementById(currPrefix+'TechList').style.display='';
			}
		}
		
		window.onload = function(){
			myTeam=JSON.parse('${myTeam}');
			oppTeam=JSON.parse('${oppTeam}');
			
			document.getElementById('players1').innerHTML=myTeam.leftWing.name;
			document.getElementById('players2').innerHTML=myTeam.rightWing.name;
			document.getElementById('players3').innerHTML=myTeam.midfielder.name;
			document.getElementById('players4').innerHTML=myTeam.leftBack.name;
			document.getElementById('players5').innerHTML=myTeam.rightBack.name;
			document.getElementById('players6').innerHTML=myTeam.keeper.name;
			
			document.getElementById('oppPlayers1').innerHTML=oppTeam.leftWing.name;
			document.getElementById('oppPlayers2').innerHTML=oppTeam.rightWing.name;
			document.getElementById('oppPlayers3').innerHTML=oppTeam.midfielder.name;
			document.getElementById('oppPlayers4').innerHTML=oppTeam.leftBack.name;
			document.getElementById('oppPlayers5').innerHTML=oppTeam.rightBack.name;
			document.getElementById('oppPlayers6').innerHTML=oppTeam.keeper.name;

			var currPrefix;
			for (var playerNo=1; playerNo<7; playerNo++){
				if (playerNo==1){
					playerInfo=oppTeam.leftWing;
					currPrefix='lw';
				} else if (playerNo==2){
					playerInfo=oppTeam.rightWing;
					currPrefix='rw';
				} else if (playerNo==3){
					playerInfo=oppTeam.midfielder;
					currPrefix='mf';
				} else if (playerNo==4){
					playerInfo=oppTeam.leftBack;
					currPrefix='lb';
				} else if (playerNo==5){
					playerInfo=oppTeam.rightBack;
					currPrefix='rb';
				} else if (playerNo==6){
					playerInfo=oppTeam.keeper;
					currPrefix='gk';
				}

				if (playerInfo.level>=30){
					document.getElementById(currPrefix+'TechSlot1').style.visibility='';
					document.getElementById(currPrefix+'TechSlot2').style.visibility='';
					document.getElementById(currPrefix+'TechSlot3').style.visibility='';
					document.getElementById(currPrefix+'TechSlot4').style.visibility='';
					document.getElementById(currPrefix+'TechSlot5').style.visibility='';
					if (playerInfo.tech1==null||playerInfo.tech1==0){
						document.getElementById(currPrefix+'TechSlot1').innerHTML=emptyDashString;
						document.getElementById(currPrefix+'TechID1').innerHTML=0;
					} else {
						document.getElementById(currPrefix+'TechSlot1').innerHTML=techList[playerInfo.tech1-1].techName;
						document.getElementById(currPrefix+'TechID1').innerHTML=playerInfo.tech1;
					}
					if (playerInfo.tech2==null||playerInfo.tech2==0){
						document.getElementById(currPrefix+'TechSlot2').innerHTML=emptyDashString;
						document.getElementById(currPrefix+'TechID2').innerHTML=0;
					} else {
						document.getElementById(currPrefix+'TechSlot2').innerHTML=techList[playerInfo.tech2-1].techName;
						document.getElementById(currPrefix+'TechID2').innerHTML=playerInfo.tech2;
					}
					if (playerInfo.tech3==null||playerInfo.tech3==0){
						document.getElementById(currPrefix+'TechSlot3').innerHTML=emptyDashString;
						document.getElementById(currPrefix+'TechID3').innerHTML=0;
					} else {
						document.getElementById(currPrefix+'TechSlot3').innerHTML=techList[playerInfo.tech3-1].techName;
						document.getElementById(currPrefix+'TechID3').innerHTML=playerInfo.tech3;
					}
					if (playerInfo.tech4==null||playerInfo.tech4==0){
						document.getElementById(currPrefix+'TechSlot4').innerHTML=emptyDashString;
						document.getElementById(currPrefix+'TechID4').innerHTML=0;
					} else {
						document.getElementById(currPrefix+'TechSlot4').innerHTML=techList[playerInfo.tech4-1].techName;
						document.getElementById(currPrefix+'TechID4').innerHTML=playerInfo.tech4;
					}
					if (playerInfo.tech5==null||playerInfo.tech5==0){
						document.getElementById(currPrefix+'TechSlot5').innerHTML=emptyDashString;
						document.getElementById(currPrefix+'TechID5').innerHTML=0;
					} else {
						document.getElementById(currPrefix+'TechSlot5').innerHTML=techList[playerInfo.tech5-1].techName;
						document.getElementById(currPrefix+'TechID5').innerHTML=playerInfo.tech5;
					}
				} else if (playerInfo.level>=20){
					document.getElementById(currPrefix+'TechSlot1').style.visibility='';
					document.getElementById(currPrefix+'TechSlot2').style.visibility='';
					document.getElementById(currPrefix+'TechSlot3').style.visibility='';
					document.getElementById(currPrefix+'TechSlot4').style.visibility='';
					document.getElementById(currPrefix+'TechSlot5').style.visibility='hidden';
					if (playerInfo.tech1==null||playerInfo.tech1==0){
						document.getElementById(currPrefix+'TechSlot1').innerHTML=emptyDashString;
						document.getElementById(currPrefix+'TechID1').innerHTML=0;
					} else {
						document.getElementById(currPrefix+'TechSlot1').innerHTML=techList[playerInfo.tech1-1].techName;
						document.getElementById(currPrefix+'TechID1').innerHTML=playerInfo.tech1;
					}
					if (playerInfo.tech2==null||playerInfo.tech2==0){
						document.getElementById(currPrefix+'TechSlot2').innerHTML=emptyDashString;
						document.getElementById(currPrefix+'TechID2').innerHTML=0;
					} else {
						document.getElementById(currPrefix+'TechSlot2').innerHTML=techList[playerInfo.tech2-1].techName;
						document.getElementById(currPrefix+'TechID2').innerHTML=playerInfo.tech2;
					}
					if (playerInfo.tech3==null||playerInfo.tech3==0){
						document.getElementById(currPrefix+'TechSlot3').innerHTML=emptyDashString;
						document.getElementById(currPrefix+'TechID3').innerHTML=0;
					} else {
						document.getElementById(currPrefix+'TechSlot3').innerHTML=techList[playerInfo.tech3-1].techName;
						document.getElementById(currPrefix+'TechID3').innerHTML=playerInfo.tech3;
					}
					if (playerInfo.tech4==null||playerInfo.tech4==0){
						document.getElementById(currPrefix+'TechSlot4').innerHTML=emptyDashString;
						document.getElementById(currPrefix+'TechID4').innerHTML=0;
					} else {
						document.getElementById(currPrefix+'TechSlot4').innerHTML=techList[playerInfo.tech4-1].techName;
						document.getElementById(currPrefix+'TechID4').innerHTML=playerInfo.tech4;
					}
				} else if (playerInfo.level>=12){
					document.getElementById(currPrefix+'TechSlot1').style.visibility='';
					document.getElementById(currPrefix+'TechSlot2').style.visibility='';
					document.getElementById(currPrefix+'TechSlot3').style.visibility='';
					document.getElementById(currPrefix+'TechSlot4').style.visibility='hidden';
					document.getElementById(currPrefix+'TechSlot5').style.visibility='hidden';
					if (playerInfo.tech1==null||playerInfo.tech1==0){
						document.getElementById(currPrefix+'TechSlot1').innerHTML=emptyDashString;
						document.getElementById(currPrefix+'TechID1').innerHTML=0;
					} else {
						document.getElementById(currPrefix+'TechSlot1').innerHTML=techList[playerInfo.tech1-1].techName;
						document.getElementById(currPrefix+'TechID1').innerHTML=playerInfo.tech1;
					}
					if (playerInfo.tech2==null||playerInfo.tech2==0){
						document.getElementById(currPrefix+'TechSlot2').innerHTML=emptyDashString;
						document.getElementById(currPrefix+'TechID2').innerHTML=0;
					} else {
						document.getElementById(currPrefix+'TechSlot2').innerHTML=techList[playerInfo.tech2-1].techName;
						document.getElementById(currPrefix+'TechID2').innerHTML=playerInfo.tech2;
					}
					if (playerInfo.tech3==null||playerInfo.tech3==0){
						document.getElementById(currPrefix+'TechSlot3').innerHTML=emptyDashString;
						document.getElementById(currPrefix+'TechID3').innerHTML=0;
					} else {
						document.getElementById(currPrefix+'TechSlot3').innerHTML=techList[playerInfo.tech3-1].techName;
						document.getElementById(currPrefix+'TechID3').innerHTML=playerInfo.tech3;
					}
				} else if (playerInfo.level>=7){
					document.getElementById(currPrefix+'TechSlot1').style.visibility='';
					document.getElementById(currPrefix+'TechSlot2').style.visibility='';
					document.getElementById(currPrefix+'TechSlot3').style.visibility='hidden';
					document.getElementById(currPrefix+'TechSlot4').style.visibility='hidden';
					document.getElementById(currPrefix+'TechSlot5').style.visibility='hidden';
					if (playerInfo.tech1==null||playerInfo.tech1==0){
						document.getElementById(currPrefix+'TechSlot1').innerHTML=emptyDashString;
						document.getElementById(currPrefix+'TechID1').innerHTML=0;
					} else {
						document.getElementById(currPrefix+'TechSlot1').innerHTML=techList[playerInfo.tech1-1].techName;
						document.getElementById(currPrefix+'TechID1').innerHTML=playerInfo.tech1;
					}
					if (playerInfo.tech2==null||playerInfo.tech2==0){
						document.getElementById(currPrefix+'TechSlot2').innerHTML=emptyDashString;
						document.getElementById(currPrefix+'TechID2').innerHTML=0;
					} else {
						document.getElementById(currPrefix+'TechSlot2').innerHTML=techList[playerInfo.tech2-1].techName;
						document.getElementById(currPrefix+'TechID2').innerHTML=playerInfo.tech2;
					}
				} else if (playerInfo.level>=3){
					document.getElementById(currPrefix+'TechSlot1').style.visibility='';
					document.getElementById(currPrefix+'TechSlot2').style.visibility='hidden';
					document.getElementById(currPrefix+'TechSlot3').style.visibility='hidden';
					document.getElementById(currPrefix+'TechSlot4').style.visibility='hidden';
					document.getElementById(currPrefix+'TechSlot5').style.visibility='hidden';
					if (playerInfo.tech1==null||playerInfo.tech1==0){
						document.getElementById(currPrefix+'TechSlot1').innerHTML=emptyDashString;
						document.getElementById(currPrefix+'TechID1').innerHTML=0;
					} else {
						document.getElementById(currPrefix+'TechSlot1').innerHTML=techList[playerInfo.tech1-1].techName;
						document.getElementById(currPrefix+'TechID1').innerHTML=playerInfo.tech1;
					}
				} else {
					document.getElementById(currPrefix+'TechSlot1').style.visibility='hidden';
					document.getElementById(currPrefix+'TechSlot2').style.visibility='hidden';
					document.getElementById(currPrefix+'TechSlot3').style.visibility='hidden';
					document.getElementById(currPrefix+'TechSlot4').style.visibility='hidden';
					document.getElementById(currPrefix+'TechSlot5').style.visibility='hidden';
				}
			}

			changeHighlightedPlayer(1);
		}

		function changeHighlightedPlayer(playerNo){
			var playerInfo;
			if (playerNo<7){
				var oppNo = document.getElementById('marks'+playerNo).innerHTML;
				oppPlayerRow=oppNo;
				document.getElementById('oppPlayersDiv').style.visibility='';
				showPlayerInfo(oppNo);
			} else {
				document.getElementById('oppPlayersDiv').style.visibility='hidden';

				document.getElementById('lwTechList').style.display='none';
				document.getElementById('rwTechList').style.display='none';
				document.getElementById('mfTechList').style.display='none';
				document.getElementById('lbTechList').style.display='none';
				document.getElementById('rbTechList').style.display='none';
				document.getElementById('gkTechList').style.display='none';
			}
		}

		</script>

	</body>
</html>
