<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0">
		<link rel="stylesheet" type="text/css" href="css/blitzball.css?version=1.00"/>
		<style>
			body{
			font-size:10.5vmin;
			line-height:12vmin;
			}
			.stat{
				text-align:left;
				color: #87CEFA;
				display: table-cell; 
				width:24vmin;
				padding-left:1.5vmin
			}
			
			.num{
				text-align:right;
				color: #FFFF66;
				display: table-cell; 
				width:24vmin;
			}
		</style>
	</head>

	<body>
			<div>
				<label id="displayName" style="color:#ffffff;"></label>
			</div>
			<div id="displayTable" style="display:table;">
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
			<script>

			document.body.onkeydown = function(e){
			    parent.onKeyDown(e);
			};

			var playerInfo=JSON.parse('${player}');
			
			//parent.parent.loadPlayer(playerInfo.name);

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

			
			</script>
	</body>
</html>