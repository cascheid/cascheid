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
				width:28%;
				left:10%;
				z-index:1000;
				line-height:4vmin;
				padding:0px;
				display:table;
				table-layout:fixed;
			}
			
			#learnedTechs{
				color:#FFFFFF;
				font-size:3.5vmin;
				position:absolute;
				top:65vmin;
				line-height:4vmin;
				width:50%;
				left:10%;
				background:none transparent;
				z-index:1000;
			}
			
			#expDiv{
				font-size:3.5vmin;
				color: #ffffff;
				position:absolute;
				top:10vmin;
				left:45%;
				z-index:1000;
				line-height:4vmin;
				padding:0px;
			}
			#statsDiv{
				font-size:3.5vmin;
				color: #ffffff;
				position:absolute;
				top:10vmin;
				left:55%;
				z-index:1000;
				line-height:4vmin;
				padding:0px;
				width:30%;
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
				left:-5vmin;
				top:0vmin;
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
			
			.expLabelCell{
				text-align:left;
				color: #87CEFA;
				display: table-cell; 
				width:8vmin;
				padding-left:0.5vmin
			}
			
			.expCell{
				text-align:right;
				color: #FFFF66;
				display: table-cell; 
				width:12vmin;
			}
			
			.breakCell{
				text-align:center;
				color: #87CEFA;
				display: table-cell; 
				width:4vmin;
			}
			
			.playerNameCell{
				text-align:left;
				color: #FFFF66;
				display: table-cell;
				width:60%;
			}
			
			.playerLevelCell{
				text-align:right;
				color: #FFFF66;
				display: table-cell;
				width:40%;
			}
			
			.num{
				text-align:right;
				color: #FFFF66;
				display: table-cell; 
				width:8vmin;
			}
			
			hr { 
  				border : 0;
  				height: 0.8vmin;
  				background-image: linear-gradient(to right, rgba(107, 35, 142, 0.5), rgba(107, 35, 142, 1), rgba(107, 35, 142, 0.5));
			}
		</style>
	</head>

	<body>
		<div class="crossDiv" style="left:5%; top:0; width:5%; height:47.7vmin"></div>
		<div id="playerMenu">
			<img id="selector" style="display:none" src="img/blitzball/arrow.png" />
			<div style="display:table-row">
				<div class="playerNameCell"><span style="padding-left:5vmin" id="lwName">${myTeam.leftWing.name }</span></div>
				<div class="playerLevelCell"><span style="color:#87CEFA">Lv.</span><span style="padding-left:5vmin" id="lwLevel">${myTeam.leftWing.origLevel}</span></div>
			</div>
			<div style="display:table-row">
				<div class="playerNameCell" style="width:60%"><span style="padding-left:5vmin" id="rwName">${myTeam.rightWing.name }</span></div>
				<div class="playerLevelCell"><span style="color:#87CEFA">Lv.</span><span style="padding-left:5vmin" id="rwLevel">${myTeam.rightWing.origLevel}</span></div>
			</div>
			<div style="display:table-row">
				<div class="playerNameCell" style="width:60%"><span style="padding-left:5vmin" id="mfName">${myTeam.midfielder.name }</span></div>
				<div class="playerLevelCell"><span style="color:#87CEFA">Lv.</span><span style="padding-left:5vmin" id="mfLevel">${myTeam.midfielder.origLevel}</span></div>
			</div>
			<div style="display:table-row">
				<div class="playerNameCell" style="width:60%"><span style="padding-left:5vmin" id="lbName">${myTeam.leftBack.name }</span></div>
				<div class="playerLevelCell"><span style="color:#87CEFA">Lv.</span><span style="padding-left:5vmin" id="lbLevel">${myTeam.leftBack.origLevel}</span></div>
			</div>
			<div style="display:table-row">
				<div class="playerNameCell" style="width:60%"><span style="padding-left:5vmin" id="rbName">${myTeam.rightBack.name }</span></div>
				<div class="playerLevelCell"><span style="color:#87CEFA">Lv.</span><span style="padding-left:5vmin" id="rbLevel">${myTeam.rightBack.origLevel}</span></div>
			</div>
			<div style="display:table-row">
				<div class="playerNameCell" style="width:60%"><span style="padding-left:5vmin" id="gkName">${myTeam.keeper.name }</span></div>
				<div class="playerLevelCell"><span style="color:#87CEFA">Lv.</span><span style="padding-left:5vmin" id="gkLevel">${myTeam.keeper.origLevel}</span></div>
			</div>
		</div>
		<div id="learnedTechs">
			<div id="lwTechsLearned" style="display:none">
				<c:forEach items="${blitzballGameInfo.playerStatistics}" var="stat" varStatus="rowStatus">
					<c:if test="${myTeam.leftWing.playerID eq stat.playerID}">
						<c:forEach items="${stat.techsLearned}" var="tech">
							<c:choose>
								<c:when test="${(myTeam.leftWing.keyTech1.techID eq tech.techID)||(myTeam.leftWing.keyTech2.techID eq tech.techID)||(myTeam.leftWing.keyTech3.techID eq tech.techID)}">
									<div>${myTeam.leftWing.name} has learned&nbsp<span style="color:#FFFF66">Key Technique</span>&nbsp${tech.techName}</div>
								</c:when>
								<c:otherwise>
									<div>${myTeam.leftWing.name} has learned Technique ${tech.techName}</div>
								</c:otherwise>
							</c:choose>
						</c:forEach>
					</c:if>
				</c:forEach>
			</div>
			<div id="rwTechsLearned" style="display:none">
				<c:forEach items="${blitzballGameInfo.playerStatistics}" var="stat" varStatus="rowStatus">
					<c:if test="${myTeam.rightWing.playerID eq stat.playerID}">
						<c:forEach items="${stat.techsLearned}" var="tech">
							<c:choose>
								<c:when test="${(myTeam.rightWing.keyTech1.techID eq tech.techID)||(myTeam.rightWing.keyTech2.techID eq tech.techID)||(myTeam.rightWing.keyTech3.techID eq tech.techID)}">
									<div>${myTeam.rightWing.name} has learned&nbsp<span style="color:#FFFF66">Key Technique</span>&nbsp${tech.techName}</div>
								</c:when>
								<c:otherwise>
									<div>${myTeam.rightWing.name} has learned Technique ${tech.techName}</div>
								</c:otherwise>
							</c:choose>
						</c:forEach>
					</c:if>
				</c:forEach>
			</div>
			<div id="mfTechsLearned" style="display:none">
				<c:forEach items="${blitzballGameInfo.playerStatistics}" var="stat" varStatus="rowStatus">
					<c:if test="${myTeam.midfielder.playerID eq stat.playerID}">
						<c:forEach items="${stat.techsLearned}" var="tech">
							<c:choose>
								<c:when test="${(myTeam.midfielder.keyTech1.techID eq tech.techID)||(myTeam.midfielder.keyTech2.techID eq tech.techID)||(myTeam.midfielder.keyTech3.techID eq tech.techID)}">
									<div>${myTeam.midfielder.name} has learned&nbsp<span style="color:#FFFF66">Key Technique</span>&nbsp${tech.techName}</div>
								</c:when>
								<c:otherwise>
									<div>${myTeam.midfielder.name} has learned Technique ${tech.techName}</div>
								</c:otherwise>
							</c:choose>
						</c:forEach>
					</c:if>
				</c:forEach>
			</div>
			<div id="lbTechsLearned" style="display:none">
				<c:forEach items="${blitzballGameInfo.playerStatistics}" var="stat" varStatus="rowStatus">
					<c:if test="${myTeam.leftBack.playerID eq stat.playerID}">
						<c:forEach items="${stat.techsLearned}" var="tech">
							<c:choose>
								<c:when test="${(myTeam.leftBack.keyTech1.techID eq tech.techID)||(myTeam.leftBack.keyTech2.techID eq tech.techID)||(myTeam.leftBack.keyTech3.techID eq tech.techID)}">
									<div>${myTeam.leftBack.name} has learned&nbsp<span style="color:#FFFF66">Key Technique</span>&nbsp${tech.techName}</div>
								</c:when>
								<c:otherwise>
									<div>${myTeam.leftBack.name} has learned Technique ${tech.techName}</div>
								</c:otherwise>
							</c:choose>
						</c:forEach>
					</c:if>
				</c:forEach>
			</div>
			<div id="rbTechsLearned" style="display:none">
				<c:forEach items="${blitzballGameInfo.playerStatistics}" var="stat" varStatus="rowStatus">
					<c:if test="${myTeam.rightBack.playerID eq stat.playerID}">
						<c:forEach items="${stat.techsLearned}" var="tech">
							<c:choose>
								<c:when test="${(myTeam.rightBack.keyTech1.techID eq tech.techID)||(myTeam.rightBack.keyTech2.techID eq tech.techID)||(myTeam.rightBack.keyTech3.techID eq tech.techID)}">
									<div>${myTeam.rightBack.name} has learned&nbsp<span style="color:#FFFF66">Key Technique</span>&nbsp${tech.techName}</div>
								</c:when>
								<c:otherwise>
									<div>${myTeam.rightBack.name} has learned Technique ${tech.techName}</div>
								</c:otherwise>
							</c:choose>
						</c:forEach>
					</c:if>
				</c:forEach>
			</div>
			<div id="gkTechsLearned" style="display:none">
				<c:forEach items="${blitzballGameInfo.playerStatistics}" var="stat" varStatus="rowStatus">
					<c:if test="${myTeam.keeper.playerID eq stat.playerID}">
						<c:forEach items="${stat.techsLearned}" var="tech">
							<c:choose>
								<c:when test="${(myTeam.keeper.keyTech1.techID eq tech.techID)||(myTeam.keeper.keyTech2.techID eq tech.techID)||(myTeam.keeper.keyTech3.techID eq tech.techID)}">
									<div>${myTeam.keeper.name} has learned&nbsp<span style="color:#FFFF66">Key Technique</span>&nbsp${tech.techName}</div>
								</c:when>
								<c:otherwise>
									<div>${myTeam.keeper.name} has learned Technique ${tech.techName}</div>
								</c:otherwise>
							</c:choose>
						</c:forEach>
					</c:if>
				</c:forEach>
			</div>
		</div>
		<div class="crossDiv" style="left:40%; top:0; width:2%; height:47.7vh"></div>		
		<div class="crossDiv" style="left:0; top:48vmin; width:100%; height:2vmin"></div>
		
		<div id="expDiv">
			<div style="display:table-row">
				<div class="expCell">
				<c:forEach items="${blitzballGameInfo.playerStatistics}" var="stat" varStatus="rowStatus">
					<c:if test="${myTeam.leftWing.playerID eq stat.playerID}">
						<span id="lwExpGained">${stat.expGained}</span>
					</c:if>
				</c:forEach>
				<c:forEach items="${blitzballGameInfo.playerStatistics}" var="stat" varStatus="rowStatus">
					<c:if test="${oppTeam.leftWing.playerID eq stat.playerID}">
						<span style="display:none" id="lw2ExpGained">${stat.expGained}</span>
					</c:if>
				</c:forEach>
				</div>
				<div class="breakCell">&nbsp</div>
				<div class="expCell"><span id="lwExp">${myTeam.leftWing.origExp}</span></div>
				<div class="breakCell"><span>/</span></div>
				<div class="expCell"><span id="lwNextExp">${myTeam.leftWing.origNextExp}</span></div>
				<div class="expLabelCell"><span>EXP</span></div>
			</div>
			<div style="display:table-row">
				<div class="num">
				<c:forEach items="${blitzballGameInfo.playerStatistics}" var="stat" varStatus="rowStatus">
					<c:if test="${myTeam.rightWing.playerID eq stat.playerID}">
						<span id="rwExpGained">${stat.expGained}</span>
					</c:if>
				</c:forEach>
				<c:forEach items="${blitzballGameInfo.playerStatistics}" var="stat" varStatus="rowStatus">
					<c:if test="${oppTeam.rightWing.playerID eq stat.playerID}">
						<span style="display:none" id="rw2ExpGained">${stat.expGained}</span>
					</c:if>
				</c:forEach>
				</div>
				<div class="breakCell">&nbsp</div>
				<div class="expCell"><span id="rwExp">${myTeam.rightWing.origExp}</span></div>
				<div class="breakCell"><span>/</span></div>
				<div class="expCell"><span id="rwNextExp">${myTeam.rightWing.origNextExp}</span></div>
				<div class="expLabelCell"><span>EXP</span></div>
			</div>
			<div style="display:table-row">
				<div class="num">
				<c:forEach items="${blitzballGameInfo.playerStatistics}" var="stat" varStatus="rowStatus">
					<c:if test="${myTeam.midfielder.playerID eq stat.playerID}">
						<span id="mfExpGained">${stat.expGained}</span>
					</c:if>
				</c:forEach>
				<c:forEach items="${blitzballGameInfo.playerStatistics}" var="stat" varStatus="rowStatus">
					<c:if test="${oppTeam.midfielder.playerID eq stat.playerID}">
						<span style="display:none" id="mf2ExpGained">${stat.expGained}</span>
					</c:if>
				</c:forEach>
				</div>
				<div class="breakCell">&nbsp</div>
				<div class="expCell"><span id="mfExp">${myTeam.midfielder.origExp}</span></div>
				<div class="breakCell"><span>/</span></div>
				<div class="expCell"><span id="mfNextExp">${myTeam.midfielder.origNextExp}</span></div>
				<div class="expLabelCell"><span>EXP</span></div>
			</div>
			<div style="display:table-row">
				<div class="num">
				<c:forEach items="${blitzballGameInfo.playerStatistics}" var="stat" varStatus="rowStatus">
					<c:if test="${myTeam.leftBack.playerID eq stat.playerID}">
						<span id="lbExpGained">${stat.expGained}</span>
					</c:if>
				</c:forEach>
				<c:forEach items="${blitzballGameInfo.playerStatistics}" var="stat" varStatus="rowStatus">
					<c:if test="${oppTeam.leftBack.playerID eq stat.playerID}">
						<span style="display:none" id="lb2ExpGained">${stat.expGained}</span>
					</c:if>
				</c:forEach>
				</div>
				<div class="breakCell">&nbsp</div>
				<div class="expCell"><span id="lbExp">${myTeam.leftBack.origExp}</span></div>
				<div class="breakCell"><span>/</span></div>
				<div class="expCell"><span id="lbNextExp">${myTeam.leftBack.origNextExp}</span></div>
				<div class="expLabelCell"><span>EXP</span></div>
			</div>
			<div style="display:table-row">
				<div class="num">
				<c:forEach items="${blitzballGameInfo.playerStatistics}" var="stat" varStatus="rowStatus">
					<c:if test="${myTeam.rightBack.playerID eq stat.playerID}">
						<span id="rbExpGained">${stat.expGained}</span>
					</c:if>
				</c:forEach>
				<c:forEach items="${blitzballGameInfo.playerStatistics}" var="stat" varStatus="rowStatus">
					<c:if test="${oppTeam.rightBack.playerID eq stat.playerID}">
						<span style="display:none" id="rb2ExpGained">${stat.expGained}</span>
					</c:if>
				</c:forEach>
				</div>
				<div class="breakCell">&nbsp</div>
				<div class="expCell"><span id="rbExp">${myTeam.rightBack.origExp}</span></div>
				<div class="breakCell"><span>/</span></div>
				<div class="expCell"><span id="rbNextExp">${myTeam.rightBack.origNextExp}</span></div>
				<div class="expLabelCell"><span>EXP</span></div>
			</div>
			<div style="display:table-row">
				<div class="num">
				<c:forEach items="${blitzballGameInfo.playerStatistics}" var="stat" varStatus="rowStatus">
					<c:if test="${myTeam.keeper.playerID eq stat.playerID}">
						<span id="gkExpGained">${stat.expGained}</span>
					</c:if>
				</c:forEach>
				<c:forEach items="${blitzballGameInfo.playerStatistics}" var="stat" varStatus="rowStatus">
					<c:if test="${oppTeam.keeper.playerID eq stat.playerID}">
						<span style="display:none" id="gk2ExpGained">${stat.expGained}</span>
					</c:if>
				</c:forEach>
				</div>
				<div class="breakCell">&nbsp</div>
				<div class="expCell"><span id="gkExp">${myTeam.keeper.origExp}</span></div>
				<div class="breakCell"><span>/</span></div>
				<div class="expCell"><span id="gkNextExp">${myTeam.keeper.origNextExp}</span></div>
				<div class="expLabelCell"><span>EXP</span></div>
			</div>
		</div>
		
		<div id="statsDiv" style = "display:none">
			<div>
				<span id="displayName" style="color:#ffffff; margin-left:2vmin"></span>
			</div>
			<hr />
			<div id="displayTable" style="display:table; visibility:none; width:100%">
				<div style="display:table-row">
					<div class="expCell"><span id="spdDisplay"></span></div>
					<div class="expLabelCell"><span>SPD</span></div>
					<div class="expCell"><span id="hpDisplay"></span></div>
					<div class="expLabelCell"><span>HP</span></div>
				</div>
				<div style="display:table-row">
					<div class="expCell" style=""><span id="endDisplay" ></span></div>
					<div class="expLabelCell"><span >END</span></div>
					<div class="expCell"><span id="atkDisplay"></span></div>
					<div class="expLabelCell"><span>ATK</span></div>
				</div>
				<div style="display:table-row">
					<div class="expCell"><span id="pasDisplay"></span></div>
					<div class="expLabelCell"><span>PAS</span></div>
					<div class="expCell"><span id="blkDisplay"></span></div>
					<div class="expLabelCell"><span>BLK</span></div>
				</div>
				<div style="display:table-row">
					<div class="expCell"><span id="shtDisplay"></span></div>
					<div class="expLabelCell"><span>SHT</span></div>
					<div class="expCell"><span id="catDisplay"></span></div>
					<div class="expLabelCell"><span>CAT</span></div>
				</div>
			</div>
		</div>
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.2/jquery.min.js"></script>
		
		<script>
		//document.getElementById('displayedTechsContainer').style.display='none';
		var menuSelection=1;
		var teamOnDisplay=1;
		var onStats=false;
		var expApplied=false;
		var started=false;
		var oppPlayerRow=7;
		var selectedPrefix='lw';
		var emptyDashString='- - - - - - - -';
		var submitted=false;
		var myTeam = JSON.parse('${myTeamJSON}');
		var oppTeam = JSON.parse('${oppTeamJSON}');
		var prompted=false;
		var promptList=1;
		var expMap=JSON.parse('${expMap}');
		var trackTimer=0;
		var statUpdating;
		
		
		
		function switchTeams(){
			teamOnDisplay=2;
			document.getElementById('lwName').innerHTML='${oppTeam.leftWing.name}';
			document.getElementById('lwLevel').innerHTML=${oppTeam.leftWing.origLevel};
			document.getElementById('lwLevel').style.color='#FFFF66';
			document.getElementById('lwExpGained').innerHTML=document.getElementById('lw2ExpGained').innerHTML;
			document.getElementById('lwExp').innerHTML=${oppTeam.leftWing.origExp};
			document.getElementById('lwNextExp').innerHTML=${oppTeam.leftWing.origNextExp};

			document.getElementById('rwName').innerHTML='${oppTeam.rightWing.name}';
			document.getElementById('rwLevel').innerHTML=${oppTeam.rightWing.origLevel};
			document.getElementById('rwLevel').style.color='#FFFF66';
			document.getElementById('rwExpGained').innerHTML=document.getElementById('rw2ExpGained').innerHTML;
			document.getElementById('rwExp').innerHTML=${oppTeam.rightWing.origExp};
			document.getElementById('rwNextExp').innerHTML=${oppTeam.rightWing.origNextExp};

			document.getElementById('mfName').innerHTML='${oppTeam.midfielder.name}';
			document.getElementById('mfLevel').innerHTML=${oppTeam.midfielder.origLevel};
			document.getElementById('mfLevel').style.color='#FFFF66';
			document.getElementById('mfExpGained').innerHTML=document.getElementById('mf2ExpGained').innerHTML;
			document.getElementById('mfExp').innerHTML=${oppTeam.midfielder.origExp};
			document.getElementById('mfNextExp').innerHTML=${oppTeam.midfielder.origNextExp};

			document.getElementById('lbName').innerHTML='${oppTeam.leftBack.name}';
			document.getElementById('lbLevel').innerHTML=${oppTeam.leftBack.origLevel};
			document.getElementById('lbLevel').style.color='#FFFF66';
			document.getElementById('lbExpGained').innerHTML=document.getElementById('lb2ExpGained').innerHTML;
			document.getElementById('lbExp').innerHTML=${oppTeam.leftBack.origExp};
			document.getElementById('lbNextExp').innerHTML=${oppTeam.leftBack.origNextExp};

			document.getElementById('rbName').innerHTML='${oppTeam.rightBack.name}';
			document.getElementById('rbLevel').innerHTML=${oppTeam.rightBack.origLevel};
			document.getElementById('rbLevel').style.color='#FFFF66';
			document.getElementById('rbExpGained').innerHTML=document.getElementById('rb2ExpGained').innerHTML;
			document.getElementById('rbExp').innerHTML=${oppTeam.rightBack.origExp};
			document.getElementById('rbNextExp').innerHTML=${oppTeam.rightBack.origNextExp};

			document.getElementById('gkName').innerHTML='${oppTeam.keeper.name}';
			document.getElementById('gkLevel').innerHTML=${oppTeam.keeper.origLevel};
			document.getElementById('gkLevel').style.color='#FFFF66';
			document.getElementById('gkExpGained').innerHTML=document.getElementById('gk2ExpGained').innerHTML;
			document.getElementById('gkExp').innerHTML=${oppTeam.keeper.origExp};
			document.getElementById('gkNextExp').innerHTML=${oppTeam.keeper.origNextExp};
		}

		function triggerExpApply(){
			if (!expApplied){
				applyExp();
				setTimeout(triggerExpApply, '10');
			}
		}

		function finishExpApply(){
			while (!expApplied){
				applyExp();
			}
		}

		function triggerStatUpdate(statName, statVal){
			trackTimer=0;
			document.getElementById(statName).innerHTML=statVal;
			document.getElementById(statName).style.color="#FFFFFF";
			if (statUpdating!=null){
				document.getElementById(statUpdating).style.fontSize='2vw';
				statUpdating=statName;
			} else {
				statUpdating=statName;
				updateStat();
			}
		}
		
		function updateStat(){
			trackTimer+=.05;
			if (trackTimer<0.5){
				document.getElementById(statUpdating).style.fontSize=(4-trackTimer)+'vmin';
				setTimeout(updateStat, '10');
			} else {
				document.getElementById(statUpdating).style.fontSize='3.5vmin';
				statUpdating=null;
				trackTimer=0;
			}
		}

		function applyExp(){
			if (selectedPrefix==null){
				selectedPrefix='lw';
				document.getElementById('lwTechsLearned').style.display='';
			}
			var expGained = Number(document.getElementById(selectedPrefix+'ExpGained').innerHTML);
			if (expGained <=0){
				if (selectedPrefix=='lw'){
					selectedPrefix='rw';
					document.getElementById('rwTechsLearned').style.display='';
				} else if (selectedPrefix=='rw'){
					selectedPrefix='mf';
					document.getElementById('mfTechsLearned').style.display='';
				} else if (selectedPrefix=='mf'){
					selectedPrefix='lb';
					document.getElementById('lbTechsLearned').style.display='';
				} else if (selectedPrefix=='lb'){
					selectedPrefix='rb';
					document.getElementById('rbTechsLearned').style.display='';
				} else if (selectedPrefix=='rb'){
					selectedPrefix='gk';
					document.getElementById('gkTechsLearned').style.display='';
				} else if (selectedPrefix=='gk'){
					selectedPrefix=null;
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
					triggerStatUpdate(selectedPrefix+'Level', currLevel);
					document.getElementById(selectedPrefix+'NextExp').innerHTML=expMap[currLevel+1];
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
				document.getElementById('selector').style.top=(menuSelection-1)*4+'vmin';
				showPlayerInfo(menuSelection);
			}
		}

		function downButtonPressed(){
			if (onStats){
				if (menuSelection>=6){
					menuSelection=1;
				} else {
					menuSelection++;
				}
				document.getElementById('selector').style.top=(menuSelection-1)*4+'vmin';
				showPlayerInfo(menuSelection);
			}
		}
		
		function selectButtonPressed(){
			if (!started){
				started=true;
				triggerExpApply();
			} else if (!expApplied){
				finishExpApply();
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
					menuSelection=1;
					document.getElementById('expDiv').style.display='';
					document.getElementById('statsDiv').style.display='none';
					document.getElementById('selector').style.display='none';
					document.getElementById('selector').style.top='0vmin';
				} else {
					window.open("bbProcessHalf", "_self");
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
			document.getElementById('spdDisplay').innerHTML=playerInfo.speed;
			document.getElementById('spdDisplay').style.color="#FFFF66";
			document.getElementById('endDisplay').innerHTML=playerInfo.endurance;
			document.getElementById('endDisplay').style.color="#FFFF66";
			document.getElementById('hpDisplay').innerHTML=playerInfo.hp;
			document.getElementById('hpDisplay').style.color="#FFFF66";
			document.getElementById('atkDisplay').innerHTML=playerInfo.attack;
			document.getElementById('atkDisplay').style.color="#FFFF66";
			document.getElementById('pasDisplay').innerHTML=playerInfo.pass;
			document.getElementById('pasDisplay').style.color="#FFFF66";
			document.getElementById('shtDisplay').innerHTML=playerInfo.shot;
			document.getElementById('shtDisplay').style.color="#FFFF66";
			document.getElementById('blkDisplay').innerHTML=playerInfo.block;
			document.getElementById('blkDisplay').style.color="#FFFF66";
			document.getElementById('catDisplay').innerHTML=playerInfo.cat;
			document.getElementById('catDisplay').style.color="#FFFF66";
			document.getElementById('displayTable').style.visibility='';

			if (playerInfo.updatedStats!=null){
				for (var i=0; i<playerInfo.updatedStats.length; i++){
					document.getElementById(playerInfo.updatedStats[i]+'Display').style.color="#FFFFFF";
				}
			}

		}

		$(document).ready(function(){
			$(document).keydown(function(event){
			    onKeyDown(event);
			});
		});

		</script>

	</body>
</html>
