<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="css/site.css?version=1.00"/>
<link rel="stylesheet" type="text/css" href="css/racing.css?version=1.00">
<style>
	body{overflow:hidden;}
	div.tracklap1 {z-index:-1; position:relative; overflow:hidden; float:left;}
	div.tracklap2 {z-index:-1; position:relative; overflow:hidden; float:left;}
	div.tracklap3 {z-index:-1; position:relative; overflow:hidden; float:left;}
	div.tracklap4 {z-index:-1; position:relative; overflow:hidden; float:left;}
	div.tracklap5 {z-index:-1; position:relative; overflow:hidden; float:left;}
	div.tracklap6 {z-index:-1; position:relative; overflow:hidden; float:left;}
	div.tracklap7 {z-index:-1; position:relative; overflow:hidden; float:left;}
	div.tracklap8 {z-index:-1; position:relative; overflow:hidden; float:left;}
</style>
<title>CAScheid Racing Game</title>
</head>
<body>
	<div id="topBanner">
		<label id="topLabel">Class: ${raceInfo.racingClass}  Lap Length: ${raceInfo.lapDistance}  Number of Laps: ${raceInfo.noLaps}</label>
	</div>
	
	<script>

	</script>
	

	<form:form method="POST" id="resultForm" action="spectateResults" commandName="raceResult">
		<form:input id="classForm" type="hidden" path="racingClass" value="${raceInfo.racingClass}"/>
		<form:input id="raceType" type="hidden" path="raceType" value="spectate"/>
		<form:input id="firstPlaceForm" type="hidden" path="place1"/>
		<form:input id="firstPlaceTimeForm" type="hidden" path="place1Time"/>
		<form:input id="secondPlaceForm" type="hidden" path="place2"/>
		<form:input id="secondPlaceTimeForm" type="hidden" path="place2Time"/>
		<form:input id="thirdPlaceForm" type="hidden" path="place3"/>
		<form:input id="thirdPlaceTimeForm" type="hidden" path="place3Time"/>
		<form:input id="fourthPlaceForm" type="hidden" path="place4"/>
		<form:input id="fourthPlaceTimeForm" type="hidden" path="place4Time"/>
	</form:form>
	<script>
		startRace();
	</script>
</body>
</html>