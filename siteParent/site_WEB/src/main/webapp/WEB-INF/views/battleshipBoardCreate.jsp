<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"
    %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<style>
	h1{text-align: center;}
	select {font-weight: bold; font-size: 22px; float:left; padding-right:10px;}
	div.inline{display:inline-block; width: 100%; padding-bottom:10px; text-align:left;}
	label.large {font-weight: bold; font-size: 22px; float:left; padding-right:10px;}
	label.small {float:left; padding-left:30%;}
	div.panel{float:left; width:49%; height:100%; text-align:left;}
	div.master{width:100%;float:left; width: 100%; padding-bottom:10px; text-align:center;}
	button{
		width: 150px;
		padding: 10px;
		box-shadow: -8px 8px 10px 3px rgba(0,0,0,0.2);
		font-weight: bold;
		text-decoration: none;
		vertical-align:middle;
		margin:auto;
	}
</style>
<script src="js/battleship.js"></script>
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
	<button id="btnSubmit" onclick='submitBoard()'>Finish and Submit</button>
	<script>
		initBattleship(Math.min(window.innerWidth, window.innerHeight), false);

		function submitBoard(){
			for (var i=0; i<nameArray.length; i++){
				if (document.getElementById(nameArray[i]+'Loc').value==''){
					alert("Please place all ships before continuing.");
					return;
				}
			}
			boardForm.submit();
		}

		window.onload=function(){
			drawTopGrid();
			drawTopText();
			drawTopShips();
		}
	</script>
</body>
</html>