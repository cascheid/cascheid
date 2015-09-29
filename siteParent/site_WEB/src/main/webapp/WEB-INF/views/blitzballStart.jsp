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
				font-size:3.5vh;
				color: #ffffff;
				position:absolute;
				top:15vh;
				width:20%;
				left:20%;
				z-index:1000;
				line-height:4vh;
				padding:0px;
			}
			
			#centerDisplay{
				font-size:3.5vh;
				position:absolute;
				top:15vh;
				width:20%;
				left:40%;
				background:none transparent;
				z-index:1000;
			}
			
			#rightDisplay{
				font-size:3.5vh;
				color: #ffffff;
				position:absolute;
				top:15vh;
				width:20%;
				left:60%;
				background:none transparent;
				z-index:1000;
			}
			
			#infoDiv{
				font-size:3.5vh;
				line-height:4vh;
				color: #ffffff;
				position:absolute;
				top:55vh;
				left:40%;
				background:none transparent;
				z-index:1000;
			}
			
			#selector{
				position:absolute;
				left:-5vh;
				top:0vh;
				width:5vh;
				height:3.5vh;
			}
			
			#confSelector{
				position:absolute;
				left:0vh;
				top:4vh;
				width:5vh;
				height:3.5vh;
			}
			
			#confirmDiv{
				position:absolute;
				color: #ffffff;
				font-size:3.5vh;
				line-height:4vh;
				top:40%;
				width:10%;
				height:15%;
				left:45%;
				background-color:#6B238E;
				background-image: url("img/blitzball/cracks.png");
				border: 5px double white;
				z-index:1001;
			}
			
			.crossDiv{
				position:absolute;
				background: rgba(0,0,0,.75);
				border: .2vh solid rgba(255, 255, 255, .75);
				box-shadow: 0 0 2vh #000000;
			}
			
			.stat{
				text-align:left;
				color: #87CEFA;
			}
			
			.num{
				text-align:right;
				color: #FFFF66;
			}
		</style>
	</head>

	<body>
		<div id="playerMenu">
			<img id="selector" src="img/blitzball/arrow.png" />
			<div class="playeritems">
				<label id="players1"></label>
				<label id="hplayers1" style="display:none"></label>
			</div>
			<div class="playeritems">
				<label id="players2"></label>
				<label id="hplayers2" style="display:none"></label>
			</div>
			<div class="playeritems">
				<label id="players3"></label>
				<label id="hplayers3" style="display:none"></label>
			</div>
			<div class="playeritems">
				<label id="players4"></label>
				<label id="hplayers4" style="display:none"></label>
			</div>
			<div class="playeritems">
				<label id="players5"></label>
				<label id="hplayers5" style="display:none"></label>
			</div>
			<div class="playeritems">
				<label id="players6"></label>
				<label id="hplayers6" style="display:none"></label>
			</div>
			<div class="playeritems">
				<label id="players7"></label>
				<label id="hplayers7" style="display:none"></label>
			</div>
			<div class="playeritems" style="top:310px">
				<label id="players8"></label>
				<label id="hplayers8" style="display:none"></label>
			</div>
		</div>
		<div class="crossDiv" style="left:38%; top:0; width:2vh; height:100%"></div>
		<div id="centerDisplay">
			<div>
				<label id="displayName" style="color:#ffffff;"></label>
			</div>
			<table id="displayTable">
				<tr>
					<td/><td/>
					<td class="stat" style="text-align:right;">Lv</td>
					<td id="lvlDisplay" class="num"  style="text-align:left;"></td>
				</tr>
				<tr>
				<td />
					<td id="expDisplay" class="num"></td>
					<td colspan="2" class="stat">EXP LEFT</td>
				</tr>
				<tr>
					<td id="spdDisplay" class="num"></td>
					<td class="stat">SPD</td>
					<td id="hpDisplay" class="num"></td>
					<td class="stat">HP</td>
				</tr>
				<tr>
					<td id="endDisplay" class="num"></td>
					<td class="stat">END</td>
					<td id="atkDisplay" class="num"></td>
					<td class="stat">ATK</td>
				</tr>
				<tr>
					<td id="pasDisplay" class="num"></td>
					<td class="stat">PAS</td>
					<td id="blkDisplay" class="num"></td>
					<td class="stat">BLK</td>
				</tr>
				<tr>
					<td id="shtDisplay" class="num"></td>
					<td class="stat">SHT</td>
					<td id="catDisplay" class="num"></td>
					<td class="stat">CAT</td>
				</tr>
			</table>
		</div>
		<div class="crossDiv" style="left:60%; top:0; width:10vh; height:47.7vh"></div>
		<div class="crossDiv" style="left:0; top:48vh; width:100%; height:2vh"></div>
		<div id="rightDisplay">
			<form:form id="rosterForm" action="setBBGameTechs" commandName="blitzballGameRoster">
			<table id="selectedTable">
				<form:hidden id="hselected1" path="leftWing" value=""></form:hidden>
				<form:hidden id="hselected2" path="rightWing" value=""></form:hidden>
				<form:hidden id="hselected3" path="midfielder" value=""></form:hidden>
				<form:hidden id="hselected4" path="leftBack" value=""></form:hidden>
				<form:hidden id="hselected5" path="rightBack" value=""></form:hidden>
				<form:hidden id="hselected6" path="keeper" value=""></form:hidden>
				<tr>
					<td style="width:10vh"/><td>Positions</td>
				</tr>
				<tr>
					<td style="padding-left:2vh;">LF</td>
					<td><form:label id="selected1" path="leftWing" value="1"></form:label></td>
				</tr>
				<tr>
					<td style="padding-left:2vh;">RF</td>
					<td><form:label id="selected2" path="rightWing"></form:label></td>
				</tr>
				<tr>
					<td style="padding-left:2vh;">MF</td>
					<td><form:label  id="selected3" path="midfielder"></form:label></td>
				</tr>
				<tr>
					<td style="padding-left:2vh;">LD</td>
					<td><form:label  id="selected4" path="leftBack"></form:label></td>
				</tr>
				<tr>
					<td style="padding-left:2vh;">RD</td>
					<td><form:label  id="selected5" path="rightBack"></form:label></td>
				</tr>
				<tr>
					<td style="padding-left:2vh;">GK</td>
					<td><form:label  id="selected6" path="keeper"></form:label></td>
				</tr>
			</table>
			</form:form>
		</div>
		
		<div id="infoDiv">
		<label class="num">Assign Positions</label>
		<p>Select this game's Left<br/>
		Forward (LF), Right Forward<br/>
		(RF), Midfielder (MF), Left<br/>
		Defender (LD), Right Defender<br/>
		(RD), and Goalkeeper (GK)<br/>
		</p>
		
		<div id="confirmDiv">
			<img id="confSelector" src="img/blitzball/arrow.png" />
			<div style="width:100%; padding-left:2.5vh">
			<label>Proceed?</label>
			</div>
			<div style="width:100%; padding-left:5vh">
			<label>Yes</label>
			</div>
			<div style="width:100%; padding-left:5vh">
			<label>No</label>
			</div>
		</div>
		
		<script>

		document.getElementById('confirmDiv').style.display='none';
		var menuSelection=1;
		var MAXITEMS=6;
		var prompted=false;
		var promptOnOK=true;
		var playersSelected=0;
		
		document.getElementById('players1').focus();
		document.body.onkeydown = function(e){
		    onKeyDown(e);
		};

		function upButtonPressed(){
			if (prompted){
				if (promptOnOK){
					promptOnOK=false;
					document.getElementById('confSelector').style.top='8vh';
				} else {
					promptOnOK=true;
					document.getElementById('confSelector').style.top='4vh';
				}
			} else {
				if (menuSelection<=1){
					menuSelection=MAXITEMS;
				} else {
					menuSelection--;
				}
				if (document.getElementById('players'+menuSelection).style.visibility=='hidden'){
					upButtonPressed();
				} else {
					document.getElementById('selector').style.top=(menuSelection-1)*4+'vh';
					changeHighlightedPlayer(menuSelection);
				}
			}
		}

		function downButtonPressed(){
			if (prompted){
				if (promptOnOK){
					promptOnOK=false;
					document.getElementById('confSelector').style.top='8vh';
				} else {
					promptOnOK=true;
					document.getElementById('confSelector').style.top='4vh';
				}
			} else {
				if (menuSelection>=MAXITEMS){
					menuSelection=1;
				} else {
					menuSelection++;
				}
				if (document.getElementById('players'+menuSelection).style.visibility=='hidden'){
					downButtonPressed();
				} else {
					document.getElementById('selector').style.top=(menuSelection-1)*4+'vh';
					changeHighlightedPlayer(menuSelection);
				}
			}
		}

		function selectButtonPressed(){
			if (prompted){
				if (promptOnOK){
					document.getElementById('rosterForm').submit();
				} else {
					resetChoices();
				}
			} else {
				selectPlayer();
			}
		}

		function cancelButtonPressed(){
			if (prompted){
				promptOnOK=false;
				document.getElementById('confSelector').style.top='8vh';
			} else {
				unSelectLastPlayer();
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
				cancelButtonPressed();
			}
		}

		var myTeam;

		window.onload = function(){
			myTeam=JSON.parse('${myTeam}');
			if (myTeam.bench1!=null){
				MAXITEMS++;
				document.getElementById('players7').style.display='';
				document.getElementById('players7').innerHTML=myTeam.bench1.name;
				document.getElementById('hplayers7').innerHTML=myTeam.bench1.playerID;
				if (myTeam.bench2!=null){
					MAXITEMS++;
					document.getElementById('players8').style.display='';
					document.getElementById('players8').innerHTML=myTeam.bench2.name;
					document.getElementById('hplayers8').innerHTML=myTeam.bench2.playerID;
				}
			}
			document.getElementById('players1').innerHTML=myTeam.leftWing.name;
			document.getElementById('hplayers1').innerHTML=myTeam.leftWing.playerID;
			document.getElementById('players2').innerHTML=myTeam.rightWing.name;
			document.getElementById('hplayers2').innerHTML=myTeam.rightWing.playerID;
			document.getElementById('players3').innerHTML=myTeam.midfielder.name;
			document.getElementById('hplayers3').innerHTML=myTeam.midfielder.playerID;
			document.getElementById('players4').innerHTML=myTeam.leftBack.name;
			document.getElementById('hplayers4').innerHTML=myTeam.leftBack.playerID;
			document.getElementById('players5').innerHTML=myTeam.rightBack.name;
			document.getElementById('hplayers5').innerHTML=myTeam.rightBack.playerID;
			document.getElementById('players6').innerHTML=myTeam.keeper.name;
			document.getElementById('hplayers6').innerHTML=myTeam.keeper.playerID;

			changeHighlightedPlayer(1);
		}

		function changeHighlightedPlayer(playerNo){
			var playerInfo;
			if (playerNo==1){
				playerInfo=myTeam.leftWing;
			} else if (playerNo==2){
				playerInfo=myTeam.rightWing;
			} else if (playerNo==3){
				playerInfo=myTeam.midfielder;
			} else if (playerNo==4){
				playerInfo=myTeam.leftBack;
			} else if (playerNo==5){
				playerInfo=myTeam.rightBack;
			} else if (playerNo==6){
				playerInfo=myTeam.keeper;
			} else if (playerNo==7){
				playerInfo=myTeam.bench1;
			} else if (playerNo==8){
				playerInfo=myTeam.bench2;
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
		}

		function selectPlayer(){
			playersSelected++;
			document.getElementById('selected'+playersSelected).innerHTML=document.getElementById('players'+menuSelection).innerHTML;
			document.getElementById('hselected'+playersSelected).value=document.getElementById('hplayers'+menuSelection).innerHTML;
			document.getElementById('players'+menuSelection).style.visibility='hidden';
			if (playersSelected==6){
				prompted=true;
				document.getElementById('confirmDiv').style.display='';
				document.getElementById('selector').style.display='none';
			} else {
				downButtonPressed();
			}
		}

		function unSelectLastPlayer(){
			if (playersSelected>0){
				var lastSelName=document.getElementById('selected'+playersSelected).innerHTML;
				for (var i=1; i<MAXITEMS; i++){
					if (lastSelName==document.getElementById('players'+i).innerHTML){
						document.getElementById('players'+i).style.visibility='';
						break;
					}
				}
				document.getElementById('selected'+playersSelected).innerHTML='';
				playersSelected--;
			}
		}

		function resetChoices(){

			document.getElementById('players1').style.visibility='';
			document.getElementById('players2').style.visibility='';
			document.getElementById('players3').style.visibility='';
			document.getElementById('players4').style.visibility='';
			document.getElementById('players5').style.visibility='';
			document.getElementById('players6').style.visibility='';
			document.getElementById('players7').style.visibility='';
			document.getElementById('players8').style.visibility='';

			document.getElementById('selected1').innerHTML='';
			document.getElementById('selected2').innerHTML='';
			document.getElementById('selected3').innerHTML='';
			document.getElementById('selected4').innerHTML='';
			document.getElementById('selected5').innerHTML='';
			document.getElementById('selected6').innerHTML='';

			document.getElementById('hselected1').value='';
			document.getElementById('hselected2').value='';
			document.getElementById('hselected3').value='';
			document.getElementById('hselected4').value='';
			document.getElementById('hselected5').value='';
			document.getElementById('hselected6').value='';

			document.getElementById('confirmDiv').style.display='none';
			document.getElementById('selector').style.display='';
			document.getElementById('selector').style.top='0vh';
			document.getElementById('confSelector').style.top='4vh';
			
			menuSelection=1;
			prompted=false;
			promptOnOK=true;
			playersSelected=0;
			
			changeHighlightedPlayer(1);
		}

		</script>

	</body>
</html>
