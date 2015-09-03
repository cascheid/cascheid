<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="css/site.css?version=1.00"/>
<style>
html{border:0px; margin:0px; padding:0px;}
body{overflow:hidden; border:0px; margin:0px; padding:0px;}
</style>
<title>CAScheid Racing Game</title>
</head>
<body>
	<iframe name="moneyFrame" width="100%" height="40px" frameborder='0' class="underline" src="raceMoneyFrame"></iframe>
	<iframe id="mainRacingFrame" name="mainRacingFrame" width="100%" src="openRacingStore" frameBorder="0"></iframe>
	<script>
	document.onreadystatechange = function(e){
	    if (document.readyState === 'complete'){
			document.getElementById('mainRacingFrame').height=(window.innerHeight-40)+'px';
			document.getElementById('mainRacingFrame').src="openRacingStore";
	    }
	};
	</script>
</body>
</html>