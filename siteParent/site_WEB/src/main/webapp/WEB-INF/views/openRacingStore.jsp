<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href="css/site.css?version=1.00"/>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1"/>
<style>
	body{overflow:hidden; border:0px; margin:0px; padding:0px;}
</style>
<title>CAScheid Racing Game</title>
</head>
<body>
	<iframe id="centerRacingFrame" name="centerRacingFrame" width="19%" src="racingStoreFrame" frameBorder="0" style="visibility:hidden" onload="this.style.visibility='visible';"></iframe>
	<iframe id="rightRacingFrame" name="rightRacingFrame" width="79%" src="carDisplayFrame" frameBorder="0" style="visibility:hidden" onload="this.style.visibility='visible';"></iframe>
	<script>
	document.onreadystatechange = function(e){
	    if (document.readyState === 'complete'){
			document.getElementById('centerRacingFrame').height=(window.innerHeight)+'px';
			document.getElementById('centerRacingFrame').src='racingStoreFrame';
			document.getElementById('rightRacingFrame').height=(window.innerHeight)+'px';
			document.getElementById('rightRacingFrame').src='carDisplayFrame';
	    }
	};
	</script>
</body>
</html>