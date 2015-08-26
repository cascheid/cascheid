<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"
    %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="css/site.css?test=3"/>
<title>CAScheid Battleship</title>
<script src="js/battleship.js?version=3.5"></script>
</head>
<body>
	<h1>Battleship vs. ${opponent}</h1>
	<canvas id='canvas'></canvas>
	<form:form id="boardForm" action="startBattleship" commandName="battleshipBoard">
		<form:input id="carrierLoc" type="hidden" path="carrierLoc"/>
		<form:input id="carrierVertical" type="hidden" path="carrierVertical"/>
		<form:input id="battleshipLoc" type="hidden" path="battleshipLoc"/>
		<form:input id="battleshipVertical" type="hidden" path="battleshipVertical"/>
		<form:input id="destroyerLoc" type="hidden" path="destroyerLoc"/>
		<form:input id="destroyerVertical" type="hidden" path="destroyerVertical"/>
		<form:input id="submarineLoc" type="hidden" path="submarineLoc"/>
		<form:input id="submarineVertical" type="hidden" path="submarineVertical"/>
		<form:input id="patrolLoc" type="hidden" path="patrolLoc"/>
		<form:input id="patrolVertical" type="hidden" path="patrolVertical"/>
	</form:form>
	<script>
		initGame(Math.min(window.innerWidth, window.innerHeight), ${gameID}, ${identifier}, ${myTurn}, ${myMoves}, ${oppMoves}, ${mySunkenShips}, ${oppSunkenShips}, '${winState}');
	</script>
	<button onclick="submitFire()">Fire!</button>
</body>
</html>