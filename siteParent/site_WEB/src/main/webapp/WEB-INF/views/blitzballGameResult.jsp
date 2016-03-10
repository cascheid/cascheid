<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
		<div class="crossDiv" style="left:5%; top:0; width:10vmin; height:47.7vmin"></div>
		<div id="playerMenu">
			<img id="selector" style="display:none" src="img/blitzball/arrow.png" />
			<div style="display:table-row">
				<div style="display: table-cell"><label style="padding-left:5vmin" id="players1">${myTeam.leftWing.name }</label></div>
				<div style="display: table-cell"><label class="stat">Lv.</label><label style="padding-left:5vmin" id="playerLevel1">${myTeam.leftWing.level}</label></div>
			</div>
			<div style="display:table-row">
				<div style="display: table-cell"><label style="padding-left:5vmin" id="players2">${myTeam.rightWing.name }</label></div>
				<div style="display: table-cell"><label class="stat">Lv.</label><label style="padding-left:5vmin" id="playerLevel2">${myTeam.rightWing.level}</label></div>
			</div>
			<div style="display:table-row">
				<div style="display: table-cell"><label style="padding-left:5vmin" id="players3">${myTeam.midfielder.name }</label></div>
				<div style="display: table-cell"><label class="stat">Lv.</label><label style="padding-left:5vmin" id="playerLevel3">${myTeam.midfielder.level}</label></div>
			</div>
			<div style="display:table-row">
				<div style="display: table-cell"><label style="padding-left:5vmin" id="players4">${myTeam.leftBack.name }</label></div>
				<div style="display: table-cell"><label class="stat">Lv.</label><label style="padding-left:5vmin" id="playerLevel4">${myTeam.leftBack.level}</label></div>
			</div>
			<div style="display:table-row">
				<div style="display: table-cell"><label style="padding-left:5vmin" id="players5">${myTeam.rightBack.name }</label></div>
				<div style="display: table-cell"><label class="stat">Lv.</label><label style="padding-left:5vmin" id="playerLevel5">${myTeam.rightBack.level}</label></div>
			</div>
			<div style="display:table-row">
				<div style="display: table-cell"><label style="padding-left:5vmin" id="players6">${myTeam.keeper.name }</label></div>
				<div style="display: table-cell"><label class="stat">Lv.</label><label style="padding-left:5vmin" id="playerLevel6">${myTeam.keeper.level}</label></div>
			</div>
		</div>
		<div class="crossDiv" style="left:38%; top:0; width:2vmin; height:47.7vh"></div>		
		<div class="crossDiv" style="left:0; top:48vmin; width:100%; height:2vmin"></div>
		
		<div id="expDiv">
			<div style="display:table-row">
				<div style="display: table-cell">
				<c:forEach items="${blitzballGameInfo.playerStatistics}" var="stat" varStatus="rowStatus">
					<c:if test="${myTeam.leftWing.playerID eq stat.playerID}">
						<label class="num" style="padding-left:5vmin" id="lwExpGained">${stat.expGained}</label>
					</c:if>
				</c:forEach>
				<c:forEach items="${blitzballGameInfo.playerStatistics}" var="stat" varStatus="rowStatus">
					<c:if test="${oppTeam.leftWing.playerID eq stat.playerID}">
						<label class="num" style="padding-left:5vmin" id="lw2ExpGained">${stat.expGained}</label>
					</c:if>
				</c:forEach>
				</div>
				<div style="display: table-cell"><label class="num" id="lwExp">${myTeam.leftWing.experience}</label></div>
				<div style="display: table-cell"><label class="stat" style="padding-left:0.5vmin; padding-right:0.5vmin">/</label></div>
				<div style="display: table-cell"><label class="num" id="lwNextExp">${myTeam.leftWing.nextExp}</label></div>
				<div style="display: table-cell"><label class="stat">EXP</label></div>
			</div>
			<div style="display:table-row">
				<div style="display: table-cell">
				<c:forEach items="${blitzballGameInfo.playerStatistics}" var="stat" varStatus="rowStatus">
					<c:if test="${myTeam.rightWing.playerID eq stat.playerID}">
						<label class="num" style="padding-left:5vmin" id="rwExpGained">${stat.expGained}</label>
					</c:if>
				</c:forEach>
				<c:forEach items="${blitzballGameInfo.playerStatistics}" var="stat" varStatus="rowStatus">
					<c:if test="${oppTeam.rightWing.playerID eq stat.playerID}">
						<label class="num" style="padding-left:5vmin" id="rw2ExpGained">${stat.expGained}</label>
					</c:if>
				</c:forEach>
				</div>
				<div style="display: table-cell"><label class="num" id="rwExp">${myTeam.rightWing.experience}</label></div>
				<div style="display: table-cell"><label class="stat" style="padding-left:0.5vmin; padding-right:0.5vmin">/</label></div>
				<div style="display: table-cell"><label class="num" id="rwNextExp">${myTeam.rightWing.nextExp}</label></div>
				<div style="display: table-cell"><label class="stat">EXP</label></div>
			</div>
			<div style="display:table-row">
				<div style="display: table-cell">
				<c:forEach items="${blitzballGameInfo.playerStatistics}" var="stat" varStatus="rowStatus">
					<c:if test="${myTeam.midfielder.playerID eq stat.playerID}">
						<label class="num" style="padding-left:5vmin" id="mfExpGained">${stat.expGained}</label>
					</c:if>
				</c:forEach>
				<c:forEach items="${blitzballGameInfo.playerStatistics}" var="stat" varStatus="rowStatus">
					<c:if test="${oppTeam.midfielder.playerID eq stat.playerID}">
						<label class="num" style="padding-left:5vmin" id="mf2ExpGained">${stat.expGained}</label>
					</c:if>
				</c:forEach>
				</div>
				<div style="display: table-cell"><label class="num" id="mfExp">${myTeam.midfielder.experience}</label></div>
				<div style="display: table-cell"><label class="stat" style="padding-left:0.5vmin; padding-right:0.5vmin">/</label></div>
				<div style="display: table-cell"><label class="num" id="mfNextExp">${myTeam.midfielder.nextExp}</label></div>
				<div style="display: table-cell"><label class="stat">EXP</label></div>
			</div>
			<div style="display:table-row">
				<div style="display: table-cell">
				<c:forEach items="${blitzballGameInfo.playerStatistics}" var="stat" varStatus="rowStatus">
					<c:if test="${myTeam.leftBack.playerID eq stat.playerID}">
						<label class="num" style="padding-left:5vmin" id="lbExpGained">${stat.expGained}</label>
					</c:if>
				</c:forEach>
				<c:forEach items="${blitzballGameInfo.playerStatistics}" var="stat" varStatus="rowStatus">
					<c:if test="${oppTeam.leftBack.playerID eq stat.playerID}">
						<label class="num" style="padding-left:5vmin" id="lb2ExpGained">${stat.expGained}</label>
					</c:if>
				</c:forEach>
				</div>
				<div style="display: table-cell"><label class="num" id="lbExp">${myTeam.leftBack.experience}</label></div>
				<div style="display: table-cell"><label class="stat" style="padding-left:0.5vmin; padding-right:0.5vmin">/</label></div>
				<div style="display: table-cell"><label class="num" id="lbNextExp">${myTeam.leftBack.nextExp}</label></div>
				<div style="display: table-cell"><label class="stat">EXP</label></div>
			</div>
			<div style="display:table-row">
				<div style="display: table-cell">
				<c:forEach items="${blitzballGameInfo.playerStatistics}" var="stat" varStatus="rowStatus">
					<c:if test="${myTeam.rightBack.playerID eq stat.playerID}">
						<label class="num" style="padding-left:5vmin" id="rbExpGained">${stat.expGained}</label>
					</c:if>
				</c:forEach>
				<c:forEach items="${blitzballGameInfo.playerStatistics}" var="stat" varStatus="rowStatus">
					<c:if test="${oppTeam.rightBack.playerID eq stat.playerID}">
						<label class="num" style="padding-left:5vmin" id="rb2ExpGained">${stat.expGained}</label>
					</c:if>
				</c:forEach>
				</div>
				<div style="display: table-cell"><label class="num" id="rbExp">${myTeam.rightBack.experience}</label></div>
				<div style="display: table-cell"><label class="stat" style="padding-left:0.5vmin; padding-right:0.5vmin">/</label></div>
				<div style="display: table-cell"><label class="num" id="rbNextExp">${myTeam.rightBack.nextExp}</label></div>
				<div style="display: table-cell"><label class="stat">EXP</label></div>
			</div>
			<div style="display:table-row">
				<div style="display: table-cell">
				<c:forEach items="${blitzballGameInfo.playerStatistics}" var="stat" varStatus="rowStatus">
					<c:if test="${myTeam.keeper.playerID eq stat.playerID}">
						<label class="num" style="padding-left:5vmin" id="gkExpGained">${stat.expGained}</label>
					</c:if>
				</c:forEach>
				<c:forEach items="${blitzballGameInfo.playerStatistics}" var="stat" varStatus="rowStatus">
					<c:if test="${oppTeam.keeper.playerID eq stat.playerID}">
						<label class="num" style="padding-left:5vmin" id="gk2ExpGained">${stat.expGained}</label>
					</c:if>
				</c:forEach>
				</div>
				<div style="display: table-cell"><label class="num" id="gkExp">${myTeam.keeper.experience}</label></div>
				<div style="display: table-cell"><label class="stat" style="padding-left:0.5vmin; padding-right:0.5vmin">/</label></div>
				<div style="display: table-cell"><label class="num" id="gkNextExp">${myTeam.keeper.nextExp}</label></div>
				<div style="display: table-cell"><label class="stat">EXP</label></div>
			</div>
		</div>
		
		<div id="statsDiv" style = "display:none">
			<div id="playerDisplay" style="width: 49%;">
			<div>
				<label id="displayName" style="color:#ffffff;"></label>
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
		</div>
		
		<script>
		//document.getElementById('displayedTechsContainer').style.display='none';
		var menuSelection=1;
		var teamOnDisplay=1;
		var onStats=false;
		var expApplied=false;
		var started=false;
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
		
		function switchTeams(){
			teamOnDisplay=2;
			document.getElementById('lwName').innerHTML=${oppTeam.leftWing.name};
			document.getElementById('lwLevel').innerHTML=${oppTeam.leftWing.level};
			document.getElementById('lwExpGained').style.display="none";
			document.getElementById('lw2ExpGained').style.display="";
			document.getElementById('lwExp').innerHTML=${oppTeam.leftWing.experience};
			document.getElementById('lwNextExp').innerHTML=${oppTeam.leftWing.nextExp};

			document.getElementById('rwName').innerHTML=${oppTeam.rightWing.name};
			document.getElementById('rwLevel').innerHTML=${oppTeam.rightWing.level};
			document.getElementById('rwExpGained').style.display="none";
			document.getElementById('rw2ExpGained').style.display="";
			document.getElementById('rwExp').innerHTML=${oppTeam.rightWing.experience};
			document.getElementById('rwNextExp').innerHTML=${oppTeam.rightWing.nextExp};

			document.getElementById('mfName').innerHTML=${oppTeam.midfielder.name};
			document.getElementById('mfLevel').innerHTML=${oppTeam.midfielder.level};
			document.getElementById('mfExpGained').style.display="none";
			document.getElementById('mf2ExpGained').style.display="";
			document.getElementById('mfExp').innerHTML=${oppTeam.midfielder.experience};
			document.getElementById('mfNextExp').innerHTML=${oppTeam.midfielder.nextExp};

			document.getElementById('lbName').innerHTML=${oppTeam.leftBack.name};
			document.getElementById('lbLevel').innerHTML=${oppTeam.leftBack.level};
			document.getElementById('lbExpGained').style.display="none";
			document.getElementById('lb2ExpGained').style.display="";
			document.getElementById('lbExp').innerHTML=${oppTeam.leftBack.experience};
			document.getElementById('lbNextExp').innerHTML=${oppTeam.leftBack.nextExp};

			document.getElementById('rbName').innerHTML=${oppTeam.rightBack.name};
			document.getElementById('rbLevel').innerHTML=${oppTeam.rightBack.level};
			document.getElementById('rbExpGained').style.display="none";
			document.getElementById('rb2ExpGained').style.display="";
			document.getElementById('rbExp').innerHTML=${oppTeam.rightBack.experience};
			document.getElementById('rbNextExp').innerHTML=${oppTeam.rightBack.nextExp};

			document.getElementById('gkName').innerHTML=${oppTeam.keeper.name};
			document.getElementById('gkLevel').innerHTML=${oppTeam.keeper.level};
			document.getElementById('gkExpGained').style.display="none";
			document.getElementById('gk2ExpGained').style.display="";
			document.getElementById('gkExp').innerHTML=${oppTeam.keeper.experience};
			document.getElementById('gkNextExp').innerHTML=${oppTeam.keeper.nextExp};
		}

		function triggerExpApply(){
			if (!expApplied){
				applyExp();
				setTimeout(triggerExpApply, '100');
			}
		}

		function finishExpApply(){
			while (!expApplied){
				applyExp();
			}
		}

		function applyExp(){
			var expGained = Number(document.getElementById(selectedPrefix+'ExpGained').innerHTML);
			if (expGained <=0){
				if (selectedPrefix=='lw'){
					selectedPrefix='rw';
				} else if (selectedPrefix=='rw'){
					selectedPrefix='mf';
				} else if (selectedPrefix=='mf'){
					selectedPrefix='lb';
				} else if (selectedPrefix=='lb'){
					selectedPrefix='rb';
				} else if (selectedPrefix=='rb'){
					selectedPrefix='gk';
				} else if (selectedPrefix=='gk'){
					selectedPrefix='lw';
					expApplied=true;
				}
			} else {
				expGained-=1;
				document.getElementById(selectedPrefix+'ExpGained').innerHTML=expGained;
				var currExp = Number(document.getElementById(selectedPrefix+'Exp').innerHTML);
				currExp+=1;
				document.getElementById(selectedPrefix+'Exp').innerHTML=currExp;
				var nextExp = Number(document.getElementById(selectedPrefix+'NextExp').innerHTML);
				if (currExp>=nextExp){
					var currLevel = Number(document.getElementById(selectedPrefix+'Level').innerHTML);
					currLevel+=1;
					document.getElementById(selectedPrefix+'Level').innerHTML=currLevel;
					document.getElementById(selectedPrefix+'Level').color="#FFFFFF";
					document.getElementById(selectedPrefix+'NextExp').innerHTML=expMap[currLevel];
				}
			}
			
		}

		function upButtonPressed(){
			if (onStats){
				if (menuSelection<=1){
					menuSelection=6;
				} else {
					menuSelection--;
				}
				document.getElementById('selector').style.top=(menuSelection)*4+'vmin';
				showPlayerInfo(menuSelection);
			}
		}

		function downButtonPressed(){
			if (onStats){
				if (menuSelection<=1){
					menuSelection=6;
				} else {
					menuSelection--;
				}
				document.getElementById('selector').style.top=(menuSelection)*4+'vmin';
				showPlayerInfo(menuSelection);
			}
		}
		
		function selectButtonPressed(){
			if (!started){
				triggerExpApply();
			} else if (!expApplied){
				finishExp();
			} else if (!onStats){
				onStats=true;
				document.getElementById('expDiv').style.display='none';
				showPlayerInfo(menuSelection);
				document.getElementById('statsDiv').style.display='';
				document.getElementById('selector').style.display='';
			} else {
				if (teamOnDisplay==1){
					switchTeams();
					started=false;
					expApplied=false;
					onStats=false;
					document.getElementById('expDiv').style.display='';
					document.getElementById('statsDiv').style.display='none';
					document.getElementById('selector').style.display='none';
				} else {
					window.open("bbNextHalf", "_self");
				}
			}
		}

		function cancelButtonPressed(){
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
			var playerInfo;
			var currPrefix='';
			var team;
			if (teamOnDisplay==1){
				team=myTeam;
			} else {
				team=oppTeam;
			}
			if (playerNo==1){
				playerInfo=team.leftWing;
				currPrefix='lw';
			} else if (playerNo==2){
				playerInfo=team.rightWing;
				currPrefix='rw';
			} else if (playerNo==3){
				playerInfo=team.midfielder;
				currPrefix='mf';
			} else if (playerNo==4){
				playerInfo=team.leftBack;
				currPrefix='lb';
			} else if (playerNo==5){
				playerInfo=team.rightBack;
				currPrefix='rb';
			} else if (playerNo==6){
				playerInfo=team.keeper;
				currPrefix='gk';
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

		}

		</script>

	</body>
</html>
