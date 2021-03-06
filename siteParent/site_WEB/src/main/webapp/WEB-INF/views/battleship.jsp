<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"
    %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="css/site.css?version=1.00"/>
<title>CAScheid Battleship</title>
<script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.0.3/sockjs.min.js"></script>
<script src="js/battleship.js?version=1.00"></script>
</head>
<body style="padding:0px; margin:0px;">
	<div class="fullCenter" style="height:50px; padding:0px; margin:0px;">
		<label style="font-size:30px; padding-right:30px;">Battleship vs. ${opponent}</label>
		<a title="Battleship Game List" href="battleship" target="_self">Back to List</a>
	</div>
	<canvas id='canvas' style="padding:0px;"></canvas>
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
	<button id="btnFire" onclick="submitFire()" style="padding:10px; width:100px; box-shadow: -8px 8px 10px 3px rgba(0,0,0,0.2); font-weight: bold; position:absolute;">Fire!</button>
	<script>
		initGame('${pageContext.request.contextPath}', ${gameID}, ${identifier}, ${myTurn}, ${myMoves}, ${oppMoves}, ${mySunkenShips}, ${oppSunkenShips}, '${winState}');
	</script>
</body>
</html>