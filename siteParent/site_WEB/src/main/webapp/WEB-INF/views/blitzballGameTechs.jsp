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
			
			#selector{
				position:absolute;
				left:10vmin;
				top:4vmin;
				width:5vmin;
				height:4vmin;
			}
			
			#listSelector{
				position:absolute;
				left:-5vmin;
				top:0vmin;
				width:5vmin;
				height:4vmin;
			}
			
			#techSelector{
				position:absolute;
				left:0vmin;
				top:0vmin;
				width:5vmin;
				height:4vmin;
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
		<div class="crossDiv" style="left:10%; top:0; width:10vmin; height:47.7vmin"></div>
		<div id="playerMenu">
			<img id="selector" src="img/blitzball/arrow.png" />
			<div style="display:table-row">
				<div style="display: table-cell; width:10vmin"></div>
				<div style="display: table-cell"><label style="padding-left:5vmin">Set Techs</label></div>
			</div>
			<div style="display:table-row">
				<div style="display: table-cell; width:10vmin"><label style="padding-left:2vmin">LF</label></div>
				<div style="display: table-cell"><label style="padding-left:5vmin" id="players1"></label></div>
			</div>
			<div style="display:table-row">
				<div style="display: table-cell; width:10vmin"><label style="padding-left:2vmin">RF</label></div>
				<div style="display: table-cell"><label style="padding-left:5vmin" id="players2"></label></div>
			</div>
			<div style="display:table-row">
				<div style="display: table-cell; width:10vmin"><label style="padding-left:2vmin">MF</label></div>
				<div style="display: table-cell"><label style="padding-left:5vmin" id="players3"></label></div>
			</div>
			<div style="display:table-row">
				<div style="display: table-cell; width:10vmin"><label style="padding-left:2vmin">LD</label></div>
				<div style="display: table-cell"><label style="padding-left:5vmin" id="players4"></label></div>
			</div>
			<div style="display:table-row">
				<div style="display: table-cell; width:10vmin"><label style="padding-left:2vmin">RD</label></div>
				<div style="display: table-cell"><label style="padding-left:5vmin" id="players5"></label></div>
			</div>
			<div style="display:table-row">
				<div style="display: table-cell; width:10vmin"><label style="padding-left:2vmin">GK</label></div>
				<div style="display: table-cell"><label style="padding-left:5vmin" id="players6"></label></div>
			</div>
			<div style="display:table-row">
				<div style="display: table-cell; width:10vmin"></div>
				<div style="display: table-cell"><label style="padding-left:5vmin">Done</label></div>
			</div>
		</div>
		<div class="crossDiv" style="left:38%; top:0; width:2vmin; height:100%"></div>
		<div id="techListDisplay">
			<form:form id="techsForm" action="setBBGameTechs" commandName="blitzballGameTechs">
			<img id="listSelector" src="img/blitzball/arrow.png" style="display:none"/>
			<div id="lwTechList">
				<div style="width:100%">
				<label id="lwTechSlot1" style="color:#ffffff;"></label>
				</div>
				<div style="width:100%">
				<label id="lwTechSlot2" style="color:#ffffff;"></label>
				</div>
				<div style="width:100%">
				<label id="lwTechSlot3" style="color:#ffffff;"></label>
				</div>
				<div style="width:100%">
				<label id="lwTechSlot4" style="color:#ffffff;"></label>
				</div>
				<div style="width:100%">
				<label id="lwTechSlot5" style="color:#ffffff;"></label>
				</div>
				<form:hidden id="lwHTechSlot1" path="leftWingTech1" value=""></form:hidden>
				<form:hidden id="lwHTechSlot2" path="leftWingTech2" value=""></form:hidden>
				<form:hidden id="lwHTechSlot3" path="leftWingTech3" value=""></form:hidden>
				<form:hidden id="lwHTechSlot4" path="leftWingTech4" value=""></form:hidden>
				<form:hidden id="lwHTechSlot5" path="leftWingTech5" value=""></form:hidden>
			</div>
			
			<div id="rwTechList" style="display:none">
				<div style="width:100%">
				<label id="rwTechSlot1" style="color:#ffffff;"></label>
				</div>
				<div style="width:100%">
				<label id="rwTechSlot2" style="color:#ffffff;"></label>
				</div>
				<div style="width:100%">
				<label id="rwTechSlot3" style="color:#ffffff;"></label>
				</div>
				<div style="width:100%">
				<label id="rwTechSlot4" style="color:#ffffff;"></label>
				</div>
				<div style="width:100%">
				<label id="rwTechSlot5" style="color:#ffffff;"></label>
				</div>
				<form:hidden id="rwHTechSlot1" path="rightWingTech1" value=""></form:hidden>
				<form:hidden id="rwHTechSlot2" path="rightWingTech2" value=""></form:hidden>
				<form:hidden id="rwHTechSlot3" path="rightWingTech3" value=""></form:hidden>
				<form:hidden id="rwHTechSlot4" path="rightWingTech4" value=""></form:hidden>
				<form:hidden id="rwHTechSlot5" path="rightWingTech5" value=""></form:hidden>
			</div>
			
			<div id="mfTechList" style="display:none">
				<div style="width:100%">
				<label id="mfTechSlot1" style="color:#ffffff;"></label>
				</div>
				<div style="width:100%">
				<label id="mfTechSlot2" style="color:#ffffff;"></label>
				</div>
				<div style="width:100%">
				<label id="mfTechSlot3" style="color:#ffffff;"></label>
				</div>
				<div style="width:100%">
				<label id="mfTechSlot4" style="color:#ffffff;"></label>
				</div>
				<div style="width:100%">
				<label id="mfTechSlot5" style="color:#ffffff;"></label>
				</div>
				<form:hidden id="mfHTechSlot1" path="midfielderTech1" value=""></form:hidden>
				<form:hidden id="mfHTechSlot2" path="midfielderTech2" value=""></form:hidden>
				<form:hidden id="mfHTechSlot3" path="midfielderTech3" value=""></form:hidden>
				<form:hidden id="mfHTechSlot4" path="midfielderTech4" value=""></form:hidden>
				<form:hidden id="mfHTechSlot5" path="midfielderTech5" value=""></form:hidden>
			</div>
			
			<div id="lbTechList" style="display:none">
				<div style="width:100%">
				<label id="lbTechSlot1" style="color:#ffffff;"></label>
				</div>
				<div style="width:100%">
				<label id="lbTechSlot2" style="color:#ffffff;"></label>
				</div>
				<div style="width:100%">
				<label id="lbTechSlot3" style="color:#ffffff;"></label>
				</div>
				<div style="width:100%">
				<label id="lbTechSlot4" style="color:#ffffff;"></label>
				</div>
				<div style="width:100%">
				<label id="lbTechSlot5" style="color:#ffffff;"></label>
				</div>
				<form:hidden id="lbHTechSlot1" path="leftBackTech1" value=""></form:hidden>
				<form:hidden id="lbHTechSlot2" path="leftBackTech2" value=""></form:hidden>
				<form:hidden id="lbHTechSlot3" path="leftBackTech3" value=""></form:hidden>
				<form:hidden id="lbHTechSlot4" path="leftBackTech4" value=""></form:hidden>
				<form:hidden id="lbHTechSlot5" path="leftBackTech5" value=""></form:hidden>
			</div>
			
			<div id="rbTechList" style="display:none">
				<div style="width:100%">
				<label id="rbTechSlot1" style="color:#ffffff;"></label>
				</div>
				<div style="width:100%">
				<label id="rbTechSlot2" style="color:#ffffff;"></label>
				</div>
				<div style="width:100%">
				<label id="rbTechSlot3" style="color:#ffffff;"></label>
				</div>
				<div style="width:100%">
				<label id="rbTechSlot4" style="color:#ffffff;"></label>
				</div>
				<div style="width:100%">
				<label id="rbTechSlot5" style="color:#ffffff;"></label>
				</div>
				<form:hidden id="rbHTechSlot1" path="rightBackTech1" value=""></form:hidden>
				<form:hidden id="rbHTechSlot2" path="rightBackTech2" value=""></form:hidden>
				<form:hidden id="rbHTechSlot3" path="rightBackTech3" value=""></form:hidden>
				<form:hidden id="rbHTechSlot4" path="rightBackTech4" value=""></form:hidden>
				<form:hidden id="rbHTechSlot5" path="rightBackTech5" value=""></form:hidden>
			</div>
			
			<div id="gkTechList" style="display:none">
				<div style="width:100%">
				<label id="gkTechSlot1" style="color:#ffffff;"></label>
				</div>
				<div style="width:100%">
				<label id="gkTechSlot2" style="color:#ffffff;"></label>
				</div>
				<div style="width:100%">
				<label id="gkTechSlot3" style="color:#ffffff;"></label>
				</div>
				<div style="width:100%">
				<label id="gkTechSlot4" style="color:#ffffff;"></label>
				</div>
				<div style="width:100%">
				<label id="gkTechSlot5" style="color:#ffffff;"></label>
				</div>
				<form:hidden id="gkHTechSlot1" path="keeperTech1" value=""></form:hidden>
				<form:hidden id="gkHTechSlot2" path="keeperTech2" value=""></form:hidden>
				<form:hidden id="gkHTechSlot3" path="keeperTech3" value=""></form:hidden>
				<form:hidden id="gkHTechSlot4" path="keeperTech4" value=""></form:hidden>
				<form:hidden id="gkHTechSlot5" path="keeperTech5" value=""></form:hidden>
			</div>
			</form:form>
		</div>
		<div class="crossDiv" style="left:0; top:48vmin; width:100%; height:2vmin"></div>
		
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
		
		
		document.getElementById('players1').focus();
		document.body.onkeydown = function(e){
		    onKeyDown(e);
		};

		function upButtonPressed(){
			if (pageShowing>0){
				if (techRow<=1){
					techRow=MAXROWS;
				} else {
					techRow--;
				}
				document.getElementById('techSelector').style.top=(techRow-1)*4+'vmin';

				var techID=(techCol-1)*MAXROWS+techRow;
				if (pageShowing==2){
					techID=techID+MAXROWS*MAXCOLS-1;
				}
				showTechInfo(techID);
			} else if (pageShowing==0){
				if (listRow<=1){
					listRow=MAXLISTROWS;
				} else {
					listRow--;
				}
				document.getElementById('listSelector').style.top=(listRow-1)*4+'vmin';
				var techID=document.getElementById(selectedPrefix+'HTechSlot'+listRow).value;
				showTechInfo(techID);
			} else {
				if (menuSelection<=1){
					menuSelection=MAXITEMS;
				} else {
					menuSelection--;
				}
				document.getElementById('selector').style.top=(menuSelection)*4+'vmin';
				changeHighlightedPlayer(menuSelection);
			}
		}

		function downButtonPressed(){
			if (pageShowing>0){
				if (techRow>=MAXROWS){
					techRow=1;
				} else {
					techRow++;
				}
				document.getElementById('techSelector').style.top=(techRow-1)*4+'vmin';

				var techID=(techCol-1)*MAXROWS+techRow;
				if (pageShowing==2){
					techID=techID+MAXROWS*MAXCOLS-1;
				}
				showTechInfo(techID);
			} else if (pageShowing==0){
				if (listRow>=MAXLISTROWS){
					listRow=1;
				} else {
					listRow++;
				}
				document.getElementById('listSelector').style.top=(listRow-1)*4+'vmin';
				var techID=document.getElementById(selectedPrefix+'HTechSlot'+listRow).value;
				showTechInfo(techID);
			} else {
				if (menuSelection>=MAXITEMS){
					menuSelection=1;
				} else {
					menuSelection++;
				}
				document.getElementById('selector').style.top=(menuSelection)*4+'vmin';
				changeHighlightedPlayer(menuSelection);
			}
		}

		function leftButtonPressed(){
			if (pageShowing>0){
				if (techCol<=1){
					techCol=MAXCOLS;
				} else {
					techCol--;
				}
				document.getElementById('techSelector').style.left=(techCol-1)*30+'vw';

				var techID=(techCol-1)*MAXROWS+techRow;
				if (pageShowing==2){
					techID=techID+MAXROWS*MAXCOLS-1;
				}
				showTechInfo(techID);
			}
		}

		function rightButtonPressed(){
			if (pageShowing>0){
				if (techCol>=MAXCOLS){
					techCol=1;
				} else {
					techCol++;
				}
				document.getElementById('techSelector').style.left=(techCol-1)*30+'vw';

				var techID=(techCol-1)*MAXROWS+techRow;
				if (pageShowing==2){
					techID=techID+MAXROWS*MAXCOLS-1;
				}
				showTechInfo(techID);
			}
		}
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
			document.getElementById('keyTechs').innerHTML=techList[currPlayer.keyTech1-1].techName+'&nbsp&nbsp&nbsp&nbsp&nbsp'+techList[currPlayer.keyTech2-1].techName+'&nbsp&nbsp&nbsp&nbsp&nbsp'+techList[currPlayer.keyTech3-1].techName;
			//document.getElementById('keyTech2').innerHTML=techList[currPlayer.keyTech2-1].techName;
			//document.getElementById('keyTech3').innerHTML=techList[currPlayer.keyTech3-1].techName;
			
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

		function selectTech(){
			var techID=(techCol-1)*MAXROWS+techRow;
			if (pageShowing==2){
				techID=techID+MAXROWS*MAXCOLS-1;
			}
			var techString=document.getElementById('tech'+techID).innerHTML;
			if (techString==emptyDashString){//TODO handle hiding already selected techs
				document.getElementById(selectedPrefix+'TechSlot'+listRow).innerHTML=techString;
				document.getElementById(selectedPrefix+'HTechSlot'+listRow).value=0;
				cancelButtonPressed();
			} else if (techString==techList[techID-1].techName){
				document.getElementById(selectedPrefix+'TechSlot'+listRow).innerHTML=techString;
				document.getElementById(selectedPrefix+'HTechSlot'+listRow).value=techID;
				cancelButtonPressed();
			}
		}

		function selectButtonPressed(){
			if (!submitted){
				if (pageShowing<0){
					if (menuSelection==MAXITEMS){
						document.getElementById('techsForm').submit();
						submitted=true;
					} else if (MAXLISTROWS>0){
						pageShowing=0;
						setupTechsForCurrentPlayer();
						document.getElementById('selector').style.display='none';
						document.getElementById('listSelector').style.top='0vmin';
						document.getElementById('listSelector').style.display='';
						var techID=document.getElementById(selectedPrefix+'HTechSlot1').value;
						showTechInfo(techID);
					}
				} else if (pageShowing==0){
					showTechPageCurrPlayer(1);
				} else {
					if (techCol==MAXCOLS&&techRow==MAXROWS){
						if (pageShowing==1){
							showTechPageCurrPlayer(2);
						} else if (pageShowing==2){
							showTechPageCurrPlayer(1);
						}
					} else {
						selectTech();
					}
				}
			}
		}

		function cancelButtonPressed(){
			if (pageShowing>0){
				pageShowing=0;
				document.getElementById('displayedTechsContainer').style.display='none';
				document.getElementById('listSelector').style.display='';
				document.getElementById('techSelector').style.top='0vw';
				document.getElementById('techSelector').style.left='0vw';
				techCol=1;
				techRow=1;
				var techID=document.getElementById(selectedPrefix+'HTechSlot'+listRow).value;
				showTechInfo(techID);
			} else if (pageShowing==0){
				pageShowing=-1;
				listRow=1;
				document.getElementById('listSelector').style.top='0vmin';
				document.getElementById('listSelector').style.display='none';
				document.getElementById('selector').style.display='';
				hideTechInfo();
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
					if (playerInfo.tech1==null||playerInfo.tech1==0){
						document.getElementById(currPrefix+'TechSlot1').innerHTML=emptyDashString;
					} else {
						document.getElementById(currPrefix+'TechSlot1').innerHTML=techList[playerInfo.tech1-1].techName;
					}
					if (playerInfo.tech2==null||playerInfo.tech2==0){
						document.getElementById(currPrefix+'TechSlot2').innerHTML=emptyDashString;
					} else {
						document.getElementById(currPrefix+'TechSlot2').innerHTML=techList[playerInfo.tech2-1].techName;
					}
					if (playerInfo.tech3==null||playerInfo.tech3==0){
						document.getElementById(currPrefix+'TechSlot3').innerHTML=emptyDashString;
					} else {
						document.getElementById(currPrefix+'TechSlot3').innerHTML=techList[playerInfo.tech3-1].techName;
					}
					if (playerInfo.tech4==null||playerInfo.tech4==0){
						document.getElementById(currPrefix+'TechSlot4').innerHTML=emptyDashString;
					} else {
						document.getElementById(currPrefix+'TechSlot4').innerHTML=techList[playerInfo.tech4-1].techName;
					}
					if (playerInfo.tech5==null||playerInfo.tech5==0){
						document.getElementById(currPrefix+'TechSlot5').innerHTML=emptyDashString;
					} else {
						document.getElementById(currPrefix+'TechSlot5').innerHTML=techList[playerInfo.tech5-1].techName;
					}
				} else if (playerInfo.level>=20){
					document.getElementById(currPrefix+'TechSlot1').style.visibility='';
					document.getElementById(currPrefix+'TechSlot2').style.visibility='';
					document.getElementById(currPrefix+'TechSlot3').style.visibility='';
					document.getElementById(currPrefix+'TechSlot4').style.visibility='';
					document.getElementById(currPrefix+'TechSlot5').style.visibility='hidden';
					if (playerInfo.tech1==null||playerInfo.tech1==0){
						document.getElementById(currPrefix+'TechSlot1').innerHTML=emptyDashString;
					} else {
						document.getElementById(currPrefix+'TechSlot1').innerHTML=techList[playerInfo.tech1-1].techName;
					}
					if (playerInfo.tech2==null||playerInfo.tech2==0){
						document.getElementById(currPrefix+'TechSlot2').innerHTML=emptyDashString;
					} else {
						document.getElementById(currPrefix+'TechSlot2').innerHTML=techList[playerInfo.tech2-1].techName;
					}
					if (playerInfo.tech3==null||playerInfo.tech3==0){
						document.getElementById(currPrefix+'TechSlot3').innerHTML=emptyDashString;
					} else {
						document.getElementById(currPrefix+'TechSlot3').innerHTML=techList[playerInfo.tech3-1].techName;
					}
					if (playerInfo.tech4==null||playerInfo.tech4==0){
						document.getElementById(currPrefix+'TechSlot4').innerHTML=emptyDashString;
					} else {
						document.getElementById(currPrefix+'TechSlot4').innerHTML=techList[playerInfo.tech4-1].techName;
					}
				} else if (playerInfo.level>=12){
					document.getElementById(currPrefix+'TechSlot1').style.visibility='';
					document.getElementById(currPrefix+'TechSlot2').style.visibility='';
					document.getElementById(currPrefix+'TechSlot3').style.visibility='';
					document.getElementById(currPrefix+'TechSlot4').style.visibility='hidden';
					document.getElementById(currPrefix+'TechSlot5').style.visibility='hidden';
					if (playerInfo.tech1==null||playerInfo.tech1==0){
						document.getElementById(currPrefix+'TechSlot1').innerHTML=emptyDashString;
					} else {
						document.getElementById(currPrefix+'TechSlot1').innerHTML=techList[playerInfo.tech1-1].techName;
					}
					if (playerInfo.tech2==null||playerInfo.tech2==0){
						document.getElementById(currPrefix+'TechSlot2').innerHTML=emptyDashString;
					} else {
						document.getElementById(currPrefix+'TechSlot2').innerHTML=techList[playerInfo.tech2-1].techName;
					}
					if (playerInfo.tech3==null||playerInfo.tech3==0){
						document.getElementById(currPrefix+'TechSlot3').innerHTML=emptyDashString;
					} else {
						document.getElementById(currPrefix+'TechSlot3').innerHTML=techList[playerInfo.tech3-1].techName;
					}
				} else if (playerInfo.level>=7){
					document.getElementById(currPrefix+'TechSlot1').style.visibility='';
					document.getElementById(currPrefix+'TechSlot2').style.visibility='';
					document.getElementById(currPrefix+'TechSlot3').style.visibility='hidden';
					document.getElementById(currPrefix+'TechSlot4').style.visibility='hidden';
					document.getElementById(currPrefix+'TechSlot5').style.visibility='hidden';
					if (playerInfo.tech1==null||playerInfo.tech1==0){
						document.getElementById(currPrefix+'TechSlot1').innerHTML=emptyDashString;
					} else {
						document.getElementById(currPrefix+'TechSlot1').innerHTML=techList[playerInfo.tech1-1].techName;
					}
					if (playerInfo.tech2==null||playerInfo.tech2==0){
						document.getElementById(currPrefix+'TechSlot2').innerHTML=emptyDashString;
					} else {
						document.getElementById(currPrefix+'TechSlot2').innerHTML=techList[playerInfo.tech2-1].techName;
					}
				} else if (playerInfo.level>=3){
					document.getElementById(currPrefix+'TechSlot1').style.visibility='';
					document.getElementById(currPrefix+'TechSlot2').style.visibility='hidden';
					document.getElementById(currPrefix+'TechSlot3').style.visibility='hidden';
					document.getElementById(currPrefix+'TechSlot4').style.visibility='hidden';
					document.getElementById(currPrefix+'TechSlot5').style.visibility='hidden';
					if (playerInfo.tech1==null||playerInfo.tech1==0){
						document.getElementById(currPrefix+'TechSlot1').innerHTML=emptyDashString;
					} else {
						document.getElementById(currPrefix+'TechSlot1').innerHTML=techList[playerInfo.tech1-1].techName;
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

			document.getElementById(selectedPrefix+'TechList').style.display='none';

			if (playerNo!=MAXITEMS){//DONE button
				if (playerNo==1){
					playerInfo=myTeam.leftWing;
					selectedPrefix='lw';
				} else if (playerNo==2){
					playerInfo=myTeam.rightWing;
					selectedPrefix='rw';
				} else if (playerNo==3){
					playerInfo=myTeam.midfielder;
					selectedPrefix='mf';
				} else if (playerNo==4){
					playerInfo=myTeam.leftBack;
					selectedPrefix='lb';
				} else if (playerNo==5){
					playerInfo=myTeam.rightBack;
					selectedPrefix='rb';
				} else if (playerNo==6){
					playerInfo=myTeam.keeper;
					selectedPrefix='gk';
				}

				if (playerInfo.level>=30){
					MAXLISTROWS=5;
				} else if (playerInfo.level>=20){
					MAXLISTROWS=4;
				} else if (playerInfo.level>=12){
					MAXLISTROWS=3;
				} else if (playerInfo.level>=7){
					MAXLISTROWS=2;
				} else if (playerInfo.level>=3){
					MAXLISTROWS=1;
				} else {
					MAXLISTROWS=0;
				}
				
				document.getElementById(selectedPrefix+'TechList').style.display='';
			}
		}

		</script>

	</body>
</html>
