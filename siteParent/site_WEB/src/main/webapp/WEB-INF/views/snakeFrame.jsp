<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="css/site.css?version=1.00"/>
<link rel="stylesheet" type="text/css" href="css/snake.css?version=1.00"/>
<title>CAScheid Snake Game</title>
</head>
<body>
	<div id="topDiv">
		<div id="highScoreDiv" class="topElem">
		<label>High Score: ${highScore}</label>
		</div>
		<div id="scoreDiv" class="topElem">
			<label>Score:</label>
			<label id="score" >0</label>
		</div>
	</div>
	<div id="master">
		<div id="snakeContainer" tabindex="-1">
			<div id="firstblock" class="block"></div>
			<div id="firstfood" class="block"></div>
			<img id="background" class="backgroundPicture" src='img/snake/bvi.jpg'>
			<div id="blank1" class="blankDiv"></div>
			<div id="blank2" class="blankDiv"></div>
			<div id="blank3" class="blankDiv"></div>
			<div id="blank4" class="blankDiv"></div>
			<div id="blank5" class="blankDiv"></div>
			<div id="blank6" class="blankDiv"></div>
			<div id="blank7" class="blankDiv"></div>
			<div id="blank8" class="blankDiv"></div>
			<div id="blank9" class="blankDiv"></div>
			<div id="blank10" class="blankDiv"></div>
			<div id="blank11" class="blankDiv"></div>
			<div id="blank12" class="blankDiv"></div>
			<div id="blank13" class="blankDiv"></div>
			<div id="blank14" class="blankDiv"></div>
			<div id="blank15" class="blankDiv"></div>
			<div id="blank16" class="blankDiv"></div>
			<div id="blank17" class="blankDiv"></div>
			<div id="blank18" class="blankDiv"></div>
			<div id="blank19" class="blankDiv"></div>
			<div id="blank20" class="blankDiv"></div>
			<div id="blank21" class="blankDiv"></div>
			<div id="blank22" class="blankDiv"></div>
			<div id="blank23" class="blankDiv"></div>
			<div id="blank24" class="blankDiv"></div>
		</div>
	</div>

	<script src="js/snake.js?version=1.00"></script>
	<script>
		var iframes = parent.document.getElementsByName('leftFrame');
		for (var i = 0; i < iframes.length; i++) {
			iframes[i].parentNode.removeChild(iframes[i]);
		}

		iframes = parent.document.getElementsByName('displayFrame');
		for (var i = 0; i < iframes.length; i++) {
			iframes[i].style.width="100%";
		}

		var margin=Math.floor(window.innerWidth-600)/2;
		document.getElementById('highScoreDiv').style.marginLeft=margin+'px';
		document.getElementById('master').style.marginLeft=margin+'px';
		document.getElementById('snakeContainer').focus();
	</script>
</body>
</html>