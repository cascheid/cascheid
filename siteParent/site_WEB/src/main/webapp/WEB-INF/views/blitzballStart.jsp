<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
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
			
			.crossDiv{
				position:absolute;
				background: rgba(0,0,0,.75);
				border: .2vmin solid rgba(255, 255, 255, .75);
				box-shadow: 0 0 2vmin #000000;
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
<div id="contentWindow" class="absoluteCentered" style="position:absolute; width:100vmin; height:100vmin">
	<div style="position:absolute; top:10vmin; left:0vmin; width:30vmin">
		<div class="innerMenu">
			<div class="selectorWrapper">
				<img id="selector" class="selector" src="img/blitzball/arrow.png" />
			</div>
		<c:forEach items="${myTeam.allPlayers}" var="player" varStatus="status">
			<div class="playeritems">
				<label id="players${status.count}">${player.name}</label>
				<label id="hplayers${status.count}" style="display:none">${player.playerID}</label>
			</div>
		</c:forEach>
		</div>
	</div>
		<div class="crossDiv" style="left:30vmin; top:0; width:2vmin; height:100vmax"></div>
		<div id="centerDisplay" style="position:absolute; top:7.5vmin; left:35vmin; width:30vmin">
		<c:forEach items="${myTeam.allPlayers}" var="player" varStatus="status">
		<div id="playerDisplay${status.count}" style="display:none">
			<div>${player.name}</div>
			<div id="displayTable" style="display:table;">
				<div style="display:table-row">
					<div class="stat"></div>
					<div class="stat"></div>
					<div class="stat" style="text-align:right;"><label>Lv</label></div>
					<div class="num" style="text-align:left; padding-left:0.5vmin">${player.level}</div>
				</div>
				<div style="display:table-row">
					<div class="stat"></div>
					<div class="num">${player.experience}/${player.nextExp}</div>
					<div class="stat"><label>EXP</label></div>
					<div class="stat"><label>LEFT</label></div>
				</div>
				<div style="display:table-row">
					<div class="num">${player.speed}</div>
					<div class="stat"><label>SPD</label></div>
					<div class="num">${player.hp}</div>
					<div class="stat"><label>HP</label></div>
				</div>
				<div style="display:table-row">
					<div class="num">${player.endurance}</div>
					<div class="stat"><label >END</label></div>
					<div class="num">${player.attack}</div>
					<div class="stat"><label>ATK</label></div>
				</div>
				<div style="display:table-row">
					<div class="num">${player.pass}</div>
					<div class="stat"><label>PAS</label></div>
					<div class="num">${player.block}</div>
					<div class="stat"><label>BLK</label></div>
				</div>
				<div style="display:table-row">
					<div class="num">${player.shot}</div>
					<div class="stat"><label>SHT</label></div>
					<div class="num">${player.cat}</div>
					<div class="stat"><label>CAT</label></div>
				</div>
			</div>
		</div>
		</c:forEach>
		</div>
		<div class="crossDiv" style="left:66vmin; top:0; width:8vmin; height:47.7vmin"></div>
		<div class="crossDiv" style="position:absolute; left:-50vmax; top:48vmin; width:150vmax; height:2vmin"></div>
		<div style="position:absolute; top:7.5vmin; left:65vmin; width:35vmin">
			<form:form id="rosterForm" action="setBBGameRoster" commandName="blitzballGameRoster">
			<table id="selectedTable">
				<form:hidden id="hselected1" path="leftWing" value=""></form:hidden>
				<form:hidden id="hselected2" path="rightWing" value=""></form:hidden>
				<form:hidden id="hselected3" path="midfielder" value=""></form:hidden>
				<form:hidden id="hselected4" path="leftBack" value=""></form:hidden>
				<form:hidden id="hselected5" path="rightBack" value=""></form:hidden>
				<form:hidden id="hselected6" path="keeper" value=""></form:hidden>
				<tr>
					<td style="width:11vmin"/><td>Positions</td>
				</tr>
				<tr>
					<td style="padding-left:2vmin;">LF</td>
					<td><form:label id="selected1" path="leftWing" value="1"></form:label></td>
				</tr>
				<tr>
					<td style="padding-left:2vmin;">RF</td>
					<td><form:label id="selected2" path="rightWing"></form:label></td>
				</tr>
				<tr>
					<td style="padding-left:2vmin;">MF</td>
					<td><form:label  id="selected3" path="midfielder"></form:label></td>
				</tr>
				<tr>
					<td style="padding-left:2vmin;">LD</td>
					<td><form:label  id="selected4" path="leftBack"></form:label></td>
				</tr>
				<tr>
					<td style="padding-left:2vmin;">RD</td>
					<td><form:label  id="selected5" path="rightBack"></form:label></td>
				</tr>
				<tr>
					<td style="padding-left:2vmin;">GK</td>
					<td><form:label  id="selected6" path="keeper"></form:label></td>
				</tr>
			</table>
			</form:form>
		</div>
		
		<div id="infoDiv" style="position:absolute; top:55vmin; left:35vmin">
		<label class="num">Assign Positions</label>
		<p>Select this game's Left<br/>
		Forward (LF), Right Forward<br/>
		(RF), Midfielder (MF), Left<br/>
		Defender (LD), Right Defender<br/>
		(RD), and Goalkeeper (GK)<br/>
		</p>
		</div>
		
	
	<div id="confirmDiv" class="menu absoluteCentered" style="display:none; top:30vmin">
		<div class="innerMenu">
			<div>Proceed?</div>
			<div class="selectorWrapper" style="top:6.5vmin">
				<img id="confSelector" class="selector" src="img/blitzball/arrow.png" />
			</div>
			<div>Yes</div>
			<div>No</div>
		</div>
	</div>
	
	<div id="returnDiv" class="menu absoluteCentered" style="display:none; top:30vmin">
		<div class="innerMenu">
			<div>Return to Main Menu?</div>
			<div class="selectorWrapper" style="top:6.5vmin">
				<img id="returnSelector" class="selector" src="img/blitzball/arrow.png" />
			</div>
			<div>Yes</div>
			<div>No</div>
		</div>
	</div>
</div>
		<script>

		var menuSelection=1;
		var MAXITEMS=Number('${fn:length(myTeam.allPlayers)}');
		var continuePrompted=false;
		var promptOnOK=true;
		var playersSelected=0;
		var returnPrompted=false;
		var selectingPlayers=true;
		var navMenu = new BBNavMenu('selector', MAXITEMS, 1);

		function upButtonPressed(){
			navMenu.moveUp();
			if (navMenu.getSelector()=='selector'){
				if (document.getElementById('players'+navMenu.getRow()).style.visibility=='hidden'){
					upButtonPressed();
				} else {
					changeHighlightedPlayer(navMenu.getRow());
				}
			}
		}

		function downButtonPressed(){
			navMenu.moveDown();
			if (navMenu.getSelector()=='selector'){
				if (document.getElementById('players'+navMenu.getRow()).style.visibility=='hidden'){
					downButtonPressed();
				} else {
					changeHighlightedPlayer(navMenu.getRow());
				}
			}
		}

		function selectButtonPressed(){
			if (navMenu.getSelector()=='confSelector'){
				if (navMenu.getRow()==1){
					document.getElementById('rosterForm').submit();
				} else {
					resetChoices();
				}
			} else if (navMenu.getSelector()=='returnSelector'){
				if (navMenu.getRow()==1){
					window.open("blitzballMenu", "_self");
				} else {
					document.getElementById('returnDiv').style.display='none';
					navMenu.updateActiveSelector('selector', MAXITEMS, menuSelection);
				}
			} else {
				selectPlayer();
			}
		}

		function cancelButtonPressed(){
			if (navMenu.getSelector()=='selector'){
				if (playersSelected>0){
					unSelectLastPlayer();
				} else {
					menuSelection=navMenu.getRow();
					navMenu.updateActiveSelector('returnSelector', 2, 1);
					document.getElementById('returnDiv').style.display='';
				}
			} else {
				navMenu.updateRow(2);
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

		var myTeam;

		window.onload = function(){
			changeHighlightedPlayer(1);
		}

		function changeHighlightedPlayer(playerNo){
			for (var i=1; i<=MAXITEMS; i++){
				if (i==playerNo){
					document.getElementById('playerDisplay'+i).style.display='';
				} else {
					document.getElementById('playerDisplay'+i).style.display='none';
				}
			}
		}

		function selectPlayer(){
			playersSelected++;
			var selectedRow=navMenu.getRow();
			document.getElementById('selected'+playersSelected).innerHTML=document.getElementById('players'+selectedRow).innerHTML;
			document.getElementById('hselected'+playersSelected).value=document.getElementById('hplayers'+selectedRow).innerHTML;
			document.getElementById('players'+selectedRow).style.visibility='hidden';
			if (playersSelected==6){
				document.getElementById('confirmDiv').style.display='';
				navMenu.updateActiveSelector('confSelector', 2, 1);
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
			try{
				document.getElementById('players7').style.visibility='';
				document.getElementById('players8').style.visibility='';
			} catch (e){}
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
			navMenu.updateActiveSelector('selector', MAXITEMS, 1);
			
			playersSelected=0;
			
			changeHighlightedPlayer(1);
		}

		</script>

	</body>
</html>
