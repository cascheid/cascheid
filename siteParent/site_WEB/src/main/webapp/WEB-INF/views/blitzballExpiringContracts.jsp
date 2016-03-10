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
		<iframe id="playerStatFrame" style="position:absolute; top:20%; left:50%; width:50%; height:60%" frameborder=0></iframe>
		<iframe id="playerTechFrame" style="position:absolute; top:0; left:0; width:100%; height:100%" frameborder=0></iframe>
		
		<div style="position:absolute; top:40%; margin:auto; left:0; right:0;">
		<div id="expireMessage" class="menu"  style="margin:0 auto; visibility:hidden">
			<span id="expirePName"></span>'s Contract with the &nbsp<span id="expireTName"></span>&nbsp has expired.
		</div>
		<div id="signMessage" class="menu" style="visibility:hidden">
			<span id="signPName"></span>&nbsp has signed with the &nbsp<span id="signTName"></span>&nbsp for &nbsp<span id="numGames"></span>&nbsp games.
		</div>
		</div>
		
		<div id="confirmDiv" class="menu" style="display:none">
			<img id="confSelector" class="selector" src="img/blitzball/arrow.png" />
			<div class="promptLabel">Resign &nbsp<span id='pName'></span>?</div>
			<div class="promptOptions">View Techs</div>
			<div class="promptOptions">Sign</div>
			<div class="promptOptions">Release</div>
		</div>
		
		<div id="signNumGamesDiv" class="menu" style="display:none">
			<div class="promptLabel">Resign for how many games?</div>
			<div id="numGames"></div>
		</div>
		
		<script>
		var menuSelection=1;
		var MAXITEMS=3;
		var expiringPlayers=${expiringPlayers};
		var renewedPlayers=${expiringPlayers};
		var myExpiredPlayers=${myExpiredPlayers};
		var playerNum=0;
		var nextCall=loadNextPlayer;
		var prompted=false;
		var signPrompted=false;
		var numGames=0;
		var displayingTechs=false;
		var currPlayer;

		function loadNextPlayer(){
			parent.unloadPlayer();
			if (expiringPlayers.length>playerNum){
				var player = expiringPlayers[playerNum];
				parent.loadPlayer(player.model);
				document.getElementById('signMessage').style.visibility='hidden';
				document.getElementById('expirePName').innerHTML=player.name;
				document.getElementById('expireTName').innerHTML=player.teamName;
				document.getElementById('expireMessage').style.visibility='';
				nextCall=loadSignedPlayer;
			} else {
				playerNum=0;
				loadNextMyExpiredPlayer();
			}
		}

		function loadNextMyExpiredPlayer(){
			if (myExpiredPlayers.length>playerNum){
				var prompted=false;
				currPlayer = myExpiredPlayers[playerNum];
				parent.loadPlayer(currPlayer.model);
				document.getElementById('signMessage').style.visibility='hidden';
				document.getElementById('playerStatFrame').style.display='none';
				document.getElementById('playerTechFrame').style.display='none';
				document.getElementById('expirePName').innerHTML=currPlayer.name;
				document.getElementById('expireTName').innerHTML=currPlayer.teamName;
				document.getElementById('expireMessage').style.visibility='';
				document.getElementById('pName').innerHTML=currPlayer.name;
				document.getElementById('playerStatFrame').src='bbStatDisplay?id='+currPlayer.playerID;
				document.getElementById('playerTechFrame').src='bbTechDisplay?id='+currPlayer.playerID;
				nextCall=loadPlayerSignOption;
				playerNum++;
			} else {
				window.open("blitzballMenu", "_self");
			}
		}

		function loadPlayerSignOption(){
			document.getElementById('playerStatFrame').style.display='';
			document.getElementById('playerTechFrame').style.display='';
			document.getElementById('confirmDiv').style.display='';
			document.getElementById('confSelector').style.display="";
			nextCall=loadNextMyExpiredPlayer;
			prompted=true;
		}

		function loadSignedPlayer(){
			parent.unloadPlayer();
			var player = renewedPlayers[playerNum];
			parent.loadPlayer(player.model);
			document.getElementById('expireMessage').style.visibility='hidden';
			document.getElementById('signPName').innerHTML=player.name;
			document.getElementById('signTName').innerHTML=player.teamName;
			document.getElementById('signMessage').style.visibility='';
			nextCall=loadNextPlayer;
			playerNum++;
		}

		top.document.onkeydown = function(e){
		    onKeyDown(e);
		}
		document.body.onkeydown = function(e){
		    onKeyDown(e);
		};
		window.onload = function(){
			nextCall();
		};
		//document.body.focus();
		
		function upButtonPressed(){
			if (prompted){
				if (signPrompted){
					numGames++;
					document.getElementById('numGames').innerHTML=numGames;
				} else if (displayingTechs){
						document.getElementById('playerTechFrame').contentWindow.upButtonPressed();
				} else {
					if (menuSelection<=1){
						menuSelection=MAXITEMS;
					} else {
						menuSelection--;
					}
				}
				document.getElementById('confSelector').style.top=(menuSelection)*4+'vmin';
			}
		}

		function downButtonPressed(){
			if (prompted){
				if (signPrompted){
					if (numGames>1){
						numGames--;
						document.getElementById('numGames').innerHTML=numGames;
					}
				} else if (displayingTechs){
						document.getElementById('playerTechFrame').contentWindow.downButtonPressed();
				} else {
					if (menuSelection>=MAXITEMS){
						menuSelection=1;
					} else {
						menuSelection++;
					}
				}
				document.getElementById('confSelector').style.top=(menuSelection)*4+'vmin';
			}
		}

		function selectButtonPressed(){
			if (!prompted){
				nextCall();
			} else if (signPrompted){
				var req = new XMLHttpRequest();
				req.open("GET", "bbSignPlayer?playerId="+currPlayer.playerID+"&contractLength="+numGames, true);
				req.send();
			} else if (displayingTechs){
				document.getElementById('playerTechFrame').contentWindow.selectButtonPressed();
			} else if (menuSelection==1){
				displayingTechs=true;
				document.getElementById('confSelector').style.display="none";
				document.getElementById('playerTechFrame').contentWindow.selectButtonPressed();
			} else if (menuSelection==2){
				document.getElementById('confirmDiv').style.display='none';
				document.getElementById('signNumGamesDiv').style.display='';
				numGames=5;
				document.getElementById('numGames').innerHTML=numGames;
				signPrompted=true;
			} else {
				loadNextMyExpiredPlayer();
			}
		}

		function cancelButtonPressed(){
			if (prompted){
				if (signPrompted){
					document.getElementById('confirmDiv').style.display='';
					document.getElementById('signNumGamesDiv').style.display='none';
					signPrompted=false;
				} else if (displayingTechs){
					displayingTechs=false;
					document.getElementById('confirmDiv').style.display='';
				}
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
				if (displayingTechs){
					document.getElementById('playerTechFrame').contentWindow.rightButtonPressed();
				}
			} else if (event.keyCode==37){
				if (displayingTechs){
					document.getElementById('playerTechFrame').contentWindow.leftButtonPressed();
				}
			} else if (event.keyCode==90){
				event.preventDefault();
				selectButtonPressed();
			} else if (event.keyCode==88){
				event.preventDefault();
				if (displayingTechs){
					document.getElementById('playerTechFrame').contentWindow.cancelButtonPressed();
				} else {
					cancelButtonPressed();
				}
			}
		}

		</script>

	</body>
</html>