<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link href="css/site.css?version=1.00" rel="stylesheet">
<link href="css/index.css?version=1.00" rel="stylesheet">
<title>CAScheid Home</title>
<script src="js/mist.js"></script>
<script src="js/rain.js"></script>
</head>
<body>
	<canvas id="bodyCanvas"></canvas>
	<script src="js/index.js"></script>
	<div class="master">
	<nav id="nav01">
		<ul id='menu'>
			<li><a href='index'>Home</a></li>
			<li><a href='gamesIndex'>Games</a></li>
			<li><a href='about'>About</a></li>
		</ul>
	</nav>
  	<div id="main">
  		<button id='btnAnim' style="margin:auto" onclick="toggleAnim()">Animations On</button>
	</div>
	</div>
	<img id="fish1" class="fish" src="img/sprites/fish.png">
	<img id="fish2" class="fish" src="img/sprites/fish.png">
	<img id="top" src="img/misc/top.png" style='display:none'>
	
</body>
</html>