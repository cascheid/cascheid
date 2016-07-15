<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html>
<html lang="en">
<head>
	<title>Blitzball!</title>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0">
	<link rel="stylesheet" type="text/css" href="css/blitzball.css?version=1.00"/>
	<script src="js/BBNavMenu.js?version=0.1"></script>
		<style>
			
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
			
			#techInfoDiv{
				font-size:3.5vmin;
				line-height:4vmin;
				color: #ffffff;
				position:absolute;
				top:10vmin;
				left:40%;
				background:none transparent;
				z-index:1000;
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
		</style>
	</head>

<body>
	<div id="contentWindow" class="absoluteCentered" style="position:absolute; width:100vmin; height:100vmin">
		<div class="crossDiv" style="left:0; top:0; width:8vmin; height:47.7vmin"></div>
		<div style="position:absolute; top:0; left:0">
			<div class="selectorWrapper" style="left:8vmin; top:4vmin">
				<img id="selector" class="selector" src="img/blitzball/arrow.png" />
			</div>
			<div style="display:table-row">
				<div style="display: table-cell; width:8vmin"></div>
				<div style="display: table-cell"><label style="padding-left:5vmin">Set Techs</label></div>
			</div>
			<div style="display:table-row">
				<div style="display: table-cell; width:8vmin"><label style="padding-left:2vmin">LF</label></div>
				<div style="display: table-cell"><label style="padding-left:5vmin" id="players1">${myTeam.leftWing.name}</label></div>
				<div style="display:none" id="playerID1">${myTeam.leftWing.playerID}</div>
				<div style="display:none" id="level1">${myTeam.leftWing.level}</div>
			</div>
			<div style="display:table-row">
				<div style="display: table-cell; width:8vmin"><label style="padding-left:2vmin">RF</label></div>
				<div style="display: table-cell"><label style="padding-left:5vmin" id="players2">${myTeam.rightWing.name}</label></div>
				<div style="display:none" id="playerID2">${myTeam.rightWing.playerID}</div>
				<div style="display:none" id="level2">${myTeam.rightWing.level}</div>
			</div>
			<div style="display:table-row">
				<div style="display: table-cell; width:8vmin"><label style="padding-left:2vmin">MF</label></div>
				<div style="display: table-cell"><label style="padding-left:5vmin" id="players3">${myTeam.midfielder.name}</label></div>
				<div style="display:none" id="playerID3">${myTeam.midfielder.playerID}</div>
				<div style="display:none" id="level3">${myTeam.midfielder.level}</div>
			</div>
			<div style="display:table-row">
				<div style="display: table-cell; width:8vmin"><label style="padding-left:2vmin">LD</label></div>
				<div style="display: table-cell"><label style="padding-left:5vmin" id="players4">${myTeam.leftBack.name}</label></div>
				<div style="display:none" id="playerID4">${myTeam.leftBack.playerID}</div>
				<div style="display:none" id="level4">${myTeam.leftBack.level}</div>
			</div>
			<div style="display:table-row">
				<div style="display: table-cell; width:8vmin"><label style="padding-left:2vmin">RD</label></div>
				<div style="display: table-cell"><label style="padding-left:5vmin" id="players5">${myTeam.rightBack.name}</label></div>
				<div style="display:none" id="playerID5">${myTeam.rightBack.playerID}</div>
				<div style="display:none" id="level5">${myTeam.rightBack.level}</div>
			</div>
			<div style="display:table-row">
				<div style="display: table-cell; width:8vmin"><label style="padding-left:2vmin">GK</label></div>
				<div style="display: table-cell"><label style="padding-left:5vmin" id="players6">${myTeam.keeper.name}</label></div>
				<div style="display:none" id="playerID6">${myTeam.keeper.playerID}</div>
				<div style="display:none" id="level6">${myTeam.keeper.level}</div>
			</div>
			<div style="display:table-row">
				<div style="display: table-cell; width:8vmin"></div>
				<div style="display: table-cell"><label style="padding-left:5vmin">Done</label></div>
			</div>
		</div>
		<div class="crossDiv" style="left:50vmin; top:0; width:2vmin; height:100vmin"></div>
		<div id="techListDisplay">
			<form:form id="techsForm" action="setBBGameTechs" commandName="blitzballGameTechs">
			<img id="listSelector" src="img/blitzball/arrow.png" style="display:none"/>
			<div id="p1TechList">
				<div style="width:100%">
				<label id="p1TechSlot1" style="color:#ffffff;"></label>
				</div>
				<div style="width:100%">
				<label id="p1TechSlot2" style="color:#ffffff;"></label>
				</div>
				<div style="width:100%">
				<label id="p1TechSlot3" style="color:#ffffff;"></label>
				</div>
				<div style="width:100%">
				<label id="p1TechSlot4" style="color:#ffffff;"></label>
				</div>
				<div style="width:100%">
				<label id="p1TechSlot5" style="color:#ffffff;"></label>
				</div>
				<form:hidden id="p1HTechSlot1" path="leftWingTech1" value=""></form:hidden>
				<form:hidden id="p1HTechSlot2" path="leftWingTech2" value=""></form:hidden>
				<form:hidden id="p1HTechSlot3" path="leftWingTech3" value=""></form:hidden>
				<form:hidden id="p1HTechSlot4" path="leftWingTech4" value=""></form:hidden>
				<form:hidden id="p1HTechSlot5" path="leftWingTech5" value=""></form:hidden>
			</div>
			
			<div id="p2TechList" style="display:none">
				<div style="width:100%">
				<label id="p2TechSlot1" style="color:#ffffff;"></label>
				</div>
				<div style="width:100%">
				<label id="p2TechSlot2" style="color:#ffffff;"></label>
				</div>
				<div style="width:100%">
				<label id="p2TechSlot3" style="color:#ffffff;"></label>
				</div>
				<div style="width:100%">
				<label id="p2TechSlot4" style="color:#ffffff;"></label>
				</div>
				<div style="width:100%">
				<label id="p2TechSlot5" style="color:#ffffff;"></label>
				</div>
				<form:hidden id="p2HTechSlot1" path="rightWingTech1" value=""></form:hidden>
				<form:hidden id="p2HTechSlot2" path="rightWingTech2" value=""></form:hidden>
				<form:hidden id="p2HTechSlot3" path="rightWingTech3" value=""></form:hidden>
				<form:hidden id="p2HTechSlot4" path="rightWingTech4" value=""></form:hidden>
				<form:hidden id="p2HTechSlot5" path="rightWingTech5" value=""></form:hidden>
			</div>
			
			<div id="p3TechList" style="display:none">
				<div style="width:100%">
				<label id="p3TechSlot1" style="color:#ffffff;"></label>
				</div>
				<div style="width:100%">
				<label id="p3TechSlot2" style="color:#ffffff;"></label>
				</div>
				<div style="width:100%">
				<label id="p3TechSlot3" style="color:#ffffff;"></label>
				</div>
				<div style="width:100%">
				<label id="p3TechSlot4" style="color:#ffffff;"></label>
				</div>
				<div style="width:100%">
				<label id="p3TechSlot5" style="color:#ffffff;"></label>
				</div>
				<form:hidden id="p3HTechSlot1" path="midfielderTech1" value=""></form:hidden>
				<form:hidden id="p3HTechSlot2" path="midfielderTech2" value=""></form:hidden>
				<form:hidden id="p3HTechSlot3" path="midfielderTech3" value=""></form:hidden>
				<form:hidden id="p3HTechSlot4" path="midfielderTech4" value=""></form:hidden>
				<form:hidden id="p3HTechSlot5" path="midfielderTech5" value=""></form:hidden>
			</div>
			
			<div id="p4TechList" style="display:none">
				<div style="width:100%">
				<label id="p4TechSlot1" style="color:#ffffff;"></label>
				</div>
				<div style="width:100%">
				<label id="p4TechSlot2" style="color:#ffffff;"></label>
				</div>
				<div style="width:100%">
				<label id="p4TechSlot3" style="color:#ffffff;"></label>
				</div>
				<div style="width:100%">
				<label id="p4TechSlot4" style="color:#ffffff;"></label>
				</div>
				<div style="width:100%">
				<label id="p4TechSlot5" style="color:#ffffff;"></label>
				</div>
				<form:hidden id="p4HTechSlot1" path="leftBackTech1" value=""></form:hidden>
				<form:hidden id="p4HTechSlot2" path="leftBackTech2" value=""></form:hidden>
				<form:hidden id="p4HTechSlot3" path="leftBackTech3" value=""></form:hidden>
				<form:hidden id="p4HTechSlot4" path="leftBackTech4" value=""></form:hidden>
				<form:hidden id="p4HTechSlot5" path="leftBackTech5" value=""></form:hidden>
			</div>
			
			<div id="p5TechList" style="display:none">
				<div style="width:100%">
				<label id="p5TechSlot1" style="color:#ffffff;"></label>
				</div>
				<div style="width:100%">
				<label id="p5TechSlot2" style="color:#ffffff;"></label>
				</div>
				<div style="width:100%">
				<label id="p5TechSlot3" style="color:#ffffff;"></label>
				</div>
				<div style="width:100%">
				<label id="p5TechSlot4" style="color:#ffffff;"></label>
				</div>
				<div style="width:100%">
				<label id="p5TechSlot5" style="color:#ffffff;"></label>
				</div>
				<form:hidden id="p5HTechSlot1" path="rightBackTech1" value=""></form:hidden>
				<form:hidden id="p5HTechSlot2" path="rightBackTech2" value=""></form:hidden>
				<form:hidden id="p5HTechSlot3" path="rightBackTech3" value=""></form:hidden>
				<form:hidden id="p5HTechSlot4" path="rightBackTech4" value=""></form:hidden>
				<form:hidden id="p5HTechSlot5" path="rightBackTech5" value=""></form:hidden>
			</div>
			
			<div id="p6TechList" style="display:none">
				<div style="width:100%">
				<label id="p6TechSlot1" style="color:#ffffff;"></label>
				</div>
				<div style="width:100%">
				<label id="p6TechSlot2" style="color:#ffffff;"></label>
				</div>
				<div style="width:100%">
				<label id="p6TechSlot3" style="color:#ffffff;"></label>
				</div>
				<div style="width:100%">
				<label id="p6TechSlot4" style="color:#ffffff;"></label>
				</div>
				<div style="width:100%">
				<label id="p6TechSlot5" style="color:#ffffff;"></label>
				</div>
				<form:hidden id="p6HTechSlot1" path="keeperTech1" value=""></form:hidden>
				<form:hidden id="p6HTechSlot2" path="keeperTech2" value=""></form:hidden>
				<form:hidden id="p6HTechSlot3" path="keeperTech3" value=""></form:hidden>
				<form:hidden id="p6HTechSlot4" path="keeperTech4" value=""></form:hidden>
				<form:hidden id="p6HTechSlot5" path="keeperTech5" value=""></form:hidden>
			</div>
			</form:form>
		</div>
		<div class="crossDiv" style="left:-100vmax; top:48vmin; width:200vmax; height:2vmin"></div>
		
		<div id="techInfoDiv">
		<label id="techInfoName" style="color: #FFFF66"></label><br/>
		<label id="techInfoStats"></label>
		<p id="techInfoDescription"></p>
		</div>
		<div id="displayedTechsContainer" style="display:none"> 
			<img id="techSelector" src="img/blitzball/arrow.png" />
			<div id="techPage1" style="display:table; width:100%;">
				<div style="display:table-row">
					<div style="display:table-cell; padding-left:5vmin; width:30vw"><label id="tech1">Jecht Shot</label></div>
					<div style="display:table-cell; padding-left:5vmin; width:30vw"><label id="tech12">Wither Shot 2</label></div>
					<div style="display:table-cell; padding-left:5vmin; width:20vw"><label id="tech23">Volley Shot</label></div>
				</div>
				<div style="display:table-row">
					<div style="display:table-cell; padding-left:5vmin; width:30vw"><label id="tech2">Jecht Shot 2</label></div>
					<div style="display:table-cell; padding-left:5vmin; width:30vw"><label id="tech13">Wither Shot 3</label></div>
					<div style="display:table-cell; padding-left:5vmin; width:20vw"><label id="tech24">Volley Shot 2</label></div>
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
		
		<div id="infoDiv">
		<label style="color:#FFFF66">Set Player Techniques</label>
		<p>Players level three and up<br/>
		can use techniques.<br/>
		Available slots increase as<br/>
		a player levels up, up to<br/>
		a maximum of five slots.<br/>
		</p>
		</div>
	</div>
		
		<script>
		//document.getElementById('displayedTechsContainer').style.display='none';
		var menuSelection=1;
		var MAXITEMS=7;//6 players, plus done
		var pageShowing=-1;
		var techRow=1;
		var techCol=1;
		var MAXCOLS=3;
		var MAXROWS=11;
		var MAXLISTROWS=0;
		var listRow=1;
		var selectedPrefix='lw';
		var techList=${techList};
		var emptyDashString='- - - - - - - -';
		var submitted=false;
		var navMenu = new BBNavMenu('selector', MAXITEMS, 1);
		

		function upButtonPressed(){
			navMenu.moveUp();
		}

		function downButtonPressed(){
			navMenu.moveDown();
		}

		function leftButtonPressed(){}

		function rightButtonPressed(){}
		var currPlayer;

		function hideTechInfo(){
			document.getElementById('techInfoName').innerHTML='';
			document.getElementById('techInfoStats').innerHTML='';
			document.getElementById('techInfoDescription').innerHTML='';
		}
		
		function showTechInfo(techNum){
			if (techNum>0){
				var tech = techList[techNum-1];

				if (document.getElementById('tech'+techNum).innerHTML==tech.techName){
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

			if (menuSelection==1){
				currPlayer=myTeam.leftWing;
			} else if (menuSelection==2){
				currPlayer=myTeam.rightWing;
			} else if (menuSelection==3){
				currPlayer=myTeam.midfielder;
			} else if (menuSelection==4){
				currPlayer=myTeam.leftBack;
			} else if (menuSelection==5){
				currPlayer=myTeam.rightBack;
			} else if (menuSelection==6){
				currPlayer=myTeam.keeper;
			}
			
			var techsPerPage=(MAXCOLS*MAXROWS)-1;

			document.getElementById('currHP').innerHTML=currPlayer.hp;
			document.getElementById('keyTechs').innerHTML=techList[currPlayer.keyTech1.techID-1].techName+'&nbsp&nbsp&nbsp&nbsp&nbsp'+techList[currPlayer.keytech2.techID-1].techName+'&nbsp&nbsp&nbsp&nbsp&nbsp'+techList[currPlayer.keytech3.techID-1].techName;
			//document.getElementById('keyTech2').innerHTML=techList[currPlayer.keytech2.techID-1].techName;
			//document.getElementById('keyTech3').innerHTML=techList[currPlayer.keytech3.techID-1].techName;
			
			for (var i=1; i<=2*techsPerPage; i++){
				//document.getElementById('learnable'+i).style.display='';
				//document.getElementById('learnable'+i).style.visibility='hidden';
				document.getElementById('tech'+i).innerHTML='&nbsp';
			}

			for (var i=0; i<currPlayer.learnableTechs.length; i++){
				//document.getElementById('learnable'+currPlayer.learnableTechs[i]).style.visibility='';
				document.getElementById('tech'+currPlayer.learnableTechs[i]).innerHTML=emptyDashString;
			}
			for (var i=0; i<currPlayer.learnedTechs.length; i++){
				//document.getElementById('learnable'+currPlayer.learnedTechs[i]).style.visibility='hidden';
				//document.getElementById('tech'+currPlayer.learnedTechs[i]).style.visibility='';
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

		function selectTech(techID, techString){
			document.getElementById('p'+menuSelection+'TechSlot'+listSelection).innerHTML=techString;
			document.getElementById('p'+menuSelection+'HTechSlot'+listSelection).value=techID;
			cancelButtonPressed();
		}

		function selectButtonPressed(){
			if (navMenu.getSelector()=='listSelector'){
				displayingTechs=true;
				listSelection=navMenu.getRow();
				var playerID=document.getElementById('playerID'+menuSelection).innerHTML;
				var techID=document.getElementById('p'+menuSelection+'HTechSlot'+listSelection).innerHtml;
				navMenu.updateActiveSelector(null, 1, 1);
				document.getElementById('playerTechMenu').src='bbTechDisplay?id='+playerID+'&tech='+techID;
			} else if (navMenu.getSelector()=='selector'){
				if (numTechs>0){
					menuSelection=navMenu.getRow();
					navMenu.updateActiveSelector('listSelector', numTechs, 1);
				}
			} else if (navMenu.getSelector()=='confSelector'){
				if (navMenu.getRow()==1){
					document.getElementById('techsForm').submit();
					submitted=true;
				} else {
					navMenu.updateActiveSelector('selector', MAXITEMS, MAXITEMS);
				}
			}
		}

		function cancelButtonPressed(){
			if (navMenu.getSelector()=='listSelector'){
				navMenu.updateActiveSelector('selector', MAXITEMS, menuSelection);
			} else if (navMenu.getSelector()=='selector'){
				navMenu.updateRow(MAXITEMS);
			} else if (navMenu.getSelector()=='confSelector'){
				navMenu.updateRow(2);
			}
		}

		function onKeyDown(event){
			if (displayingTechs){
				try{
					document.getElementById('playerTechFrame').contentWindow.onKeyDown(event);
				} catch (e){
					displayingPlayerInfo=false;
				}
			} else if (submitted){
				event.preventDefault();
			} else {
			if (event.keyCode==40){
				event.preventDefault();
				downButtonPressed();
			} else if (event.keyCode==38){
				event.preventDefault();
				upButtonPressed();
			} else if (event.keyCode==37){
				event.preventDefault();
				leftButtonPressed();
			} else if (event.keyCode==39){
				event.preventDefault();
				rightButtonPressed();
			} else if (event.keyCode==90){
				event.preventDefault();
				selectButtonPressed();
			} else if (event.keyCode==88){
				event.preventDefault();
				cancelButtonPressed();
			}
			}
		}

		var myTeam;

		window.onload = function(){
			myTeam=JSON.parse('${myTeam}');
			
			document.getElementById('players1').innerHTML=myTeam.leftWing.name;
			document.getElementById('players2').innerHTML=myTeam.rightWing.name;
			document.getElementById('players3').innerHTML=myTeam.midfielder.name;
			document.getElementById('players4').innerHTML=myTeam.leftBack.name;
			document.getElementById('players5').innerHTML=myTeam.rightBack.name;
			document.getElementById('players6').innerHTML=myTeam.keeper.name;

			var currPrefix;
			for (var playerNo=1; playerNo<7; playerNo++){
				if (playerNo==1){
					playerInfo=myTeam.leftWing;
					currPrefix='lw';
				} else if (playerNo==2){
					playerInfo=myTeam.rightWing;
					currPrefix='rw';
				} else if (playerNo==3){
					playerInfo=myTeam.midfielder;
					currPrefix='mf';
				} else if (playerNo==4){
					playerInfo=myTeam.leftBack;
					currPrefix='lb';
				} else if (playerNo==5){
					playerInfo=myTeam.rightBack;
					currPrefix='rb';
				} else if (playerNo==6){
					playerInfo=myTeam.keeper;
					currPrefix='gk';
				}

				if (playerInfo.level>=30){
					document.getElementById(currPrefix+'TechSlot1').style.visibility='';
					document.getElementById(currPrefix+'TechSlot2').style.visibility='';
					document.getElementById(currPrefix+'TechSlot3').style.visibility='';
					document.getElementById(currPrefix+'TechSlot4').style.visibility='';
					document.getElementById(currPrefix+'TechSlot5').style.visibility='';
					if (playerInfo.tech1==null||playerInfo.tech1.techID==0){
						document.getElementById(currPrefix+'TechSlot1').innerHTML=emptyDashString;
					} else {
						document.getElementById(currPrefix+'TechSlot1').innerHTML=techList[playerInfo.tech1.techID-1].techName;
					}
					if (playerInfo.tech2==null||playerInfo.tech2.techID==0){
						document.getElementById(currPrefix+'TechSlot2').innerHTML=emptyDashString;
					} else {
						document.getElementById(currPrefix+'TechSlot2').innerHTML=techList[playerInfo.tech2.techID-1].techName;
					}
					if (playerInfo.tech3==null||playerInfo.tech3.techID==0){
						document.getElementById(currPrefix+'TechSlot3').innerHTML=emptyDashString;
					} else {
						document.getElementById(currPrefix+'TechSlot3').innerHTML=techList[playerInfo.tech3.techID-1].techName;
					}
					if (playerInfo.tech4==null||playerInfo.tech4.techID==0){
						document.getElementById(currPrefix+'TechSlot4').innerHTML=emptyDashString;
					} else {
						document.getElementById(currPrefix+'TechSlot4').innerHTML=techList[playerInfo.tech4.techID-1].techName;
					}
					if (playerInfo.tech5==null||playerInfo.tech5.techID==0){
						document.getElementById(currPrefix+'TechSlot5').innerHTML=emptyDashString;
					} else {
						document.getElementById(currPrefix+'TechSlot5').innerHTML=techList[playerInfo.tech5.techID-1].techName;
					}
				} else if (playerInfo.level>=20){
					document.getElementById(currPrefix+'TechSlot1').style.visibility='';
					document.getElementById(currPrefix+'TechSlot2').style.visibility='';
					document.getElementById(currPrefix+'TechSlot3').style.visibility='';
					document.getElementById(currPrefix+'TechSlot4').style.visibility='';
					document.getElementById(currPrefix+'TechSlot5').style.visibility='hidden';
					if (playerInfo.tech1==null||playerInfo.tech1.techID==0){
						document.getElementById(currPrefix+'TechSlot1').innerHTML=emptyDashString;
					} else {
						document.getElementById(currPrefix+'TechSlot1').innerHTML=techList[playerInfo.tech1.techID-1].techName;
					}
					if (playerInfo.tech2==null||playerInfo.tech2.techID==0){
						document.getElementById(currPrefix+'TechSlot2').innerHTML=emptyDashString;
					} else {
						document.getElementById(currPrefix+'TechSlot2').innerHTML=techList[playerInfo.tech2.techID-1].techName;
					}
					if (playerInfo.tech3==null||playerInfo.tech3.techID==0){
						document.getElementById(currPrefix+'TechSlot3').innerHTML=emptyDashString;
					} else {
						document.getElementById(currPrefix+'TechSlot3').innerHTML=techList[playerInfo.tech3.techID-1].techName;
					}
					if (playerInfo.tech4==null||playerInfo.tech4.techID==0){
						document.getElementById(currPrefix+'TechSlot4').innerHTML=emptyDashString;
					} else {
						document.getElementById(currPrefix+'TechSlot4').innerHTML=techList[playerInfo.tech4.techID-1].techName;
					}
				} else if (playerInfo.level>=12){
					document.getElementById(currPrefix+'TechSlot1').style.visibility='';
					document.getElementById(currPrefix+'TechSlot2').style.visibility='';
					document.getElementById(currPrefix+'TechSlot3').style.visibility='';
					document.getElementById(currPrefix+'TechSlot4').style.visibility='hidden';
					document.getElementById(currPrefix+'TechSlot5').style.visibility='hidden';
					if (playerInfo.tech1==null||playerInfo.tech1.techID==0){
						document.getElementById(currPrefix+'TechSlot1').innerHTML=emptyDashString;
					} else {
						document.getElementById(currPrefix+'TechSlot1').innerHTML=techList[playerInfo.tech1.techID-1].techName;
					}
					if (playerInfo.tech2==null||playerInfo.tech2.techID==0){
						document.getElementById(currPrefix+'TechSlot2').innerHTML=emptyDashString;
					} else {
						document.getElementById(currPrefix+'TechSlot2').innerHTML=techList[playerInfo.tech2.techID-1].techName;
					}
					if (playerInfo.tech3==null||playerInfo.tech3.techID==0){
						document.getElementById(currPrefix+'TechSlot3').innerHTML=emptyDashString;
					} else {
						document.getElementById(currPrefix+'TechSlot3').innerHTML=techList[playerInfo.tech3.techID-1].techName;
					}
				} else if (playerInfo.level>=7){
					document.getElementById(currPrefix+'TechSlot1').style.visibility='';
					document.getElementById(currPrefix+'TechSlot2').style.visibility='';
					document.getElementById(currPrefix+'TechSlot3').style.visibility='hidden';
					document.getElementById(currPrefix+'TechSlot4').style.visibility='hidden';
					document.getElementById(currPrefix+'TechSlot5').style.visibility='hidden';
					if (playerInfo.tech1==null||playerInfo.tech1.techID==0){
						document.getElementById(currPrefix+'TechSlot1').innerHTML=emptyDashString;
					} else {
						document.getElementById(currPrefix+'TechSlot1').innerHTML=techList[playerInfo.tech1.techID-1].techName;
					}
					if (playerInfo.tech2==null||playerInfo.tech2.techID==0){
						document.getElementById(currPrefix+'TechSlot2').innerHTML=emptyDashString;
					} else {
						document.getElementById(currPrefix+'TechSlot2').innerHTML=techList[playerInfo.tech2.techID-1].techName;
					}
				} else if (playerInfo.level>=3){
					document.getElementById(currPrefix+'TechSlot1').style.visibility='';
					document.getElementById(currPrefix+'TechSlot2').style.visibility='hidden';
					document.getElementById(currPrefix+'TechSlot3').style.visibility='hidden';
					document.getElementById(currPrefix+'TechSlot4').style.visibility='hidden';
					document.getElementById(currPrefix+'TechSlot5').style.visibility='hidden';
					if (playerInfo.tech1==null||playerInfo.tech1.techID==0){
						document.getElementById(currPrefix+'TechSlot1').innerHTML=emptyDashString;
					} else {
						document.getElementById(currPrefix+'TechSlot1').innerHTML=techList[playerInfo.tech1.techID-1].techName;
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
			document.getElementById('p'+menuSelection+'TechList').style.display='none';
			menuSelection=playerNo;
			if (playerNo!=MAXITEMS){
				var playerLevel = Number(document.getElementById('level'+menuSelection).innerHTML);
				if (playerLevel>=30){
					MAXLISTROWS=5;
				} else if (playerLevel>=20){
					MAXLISTROWS=4;
				} else if (playerLevel>=12){
					MAXLISTROWS=3;
				} else if (playerLevel>=7){
					MAXLISTROWS=2;
				} else if (playerLevel>=3){
					MAXLISTROWS=1;
				} else {
					MAXLISTROWS=0;
				}
				
				document.getElementById('p'+menuSelection+'TechList').style.display='';
			}
		}

		</script>

	</body>
</html>
