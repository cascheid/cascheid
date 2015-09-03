<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="css/site.css?version=1.00"/>
<style>
	body{overflow:hidden;}
</style>
<title>CAScheid Racing Game</title>
</head>
<body>
	<script>
		window.open("leftRacingFrame", "leftFrame");
		function resetClicked(){
			var bConfirmed = window.confirm("This will reset all of your saved data and start the game over. Proceed?");
			if (bConfirmed){
				window.open("racingparent?identifier=${identifier}&delete=true", "displayFrame");
			}
		}
	</script>
	<div style="margin-top:-10px">
		<label class="large">Money: ${availableCash}</label>
		<label class="large">Class: ${racingClass}</label>
		<button style="margin-left:70px"onclick='resetClicked()'>Reset Game Data</button>
	</div>
</body>
</html>