<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="css/site.css?version=1.00"/>
<link rel="stylesheet" type="text/css" href="css/racing.css?version=1.00"/>
<title>CAScheid Racing Game</title>
</head>
<body>
	<div class="fullCenter" id="resultsTop">
	<c:choose>
    	<c:when test="${finish == 1}">
			<label id="resultLabel" class="bold">You win!</label>
			<img id="resultImg" src="img/misc/firstplace.png" width="150px" height="200px" />
    	</c:when>
    	<c:when test="${finish == 2}">
			<label id="resultLabel" class="bold">Second Place!</label>
			<img id="resultImg" src="img/misc/secondplace.png" width="150px" height="200px" />
    	</c:when>
    	<c:when test="${finish == 3}">
			<label id="resultLabel" class="bold">Third Place!</label>
			<img id="resultImg" src="img/misc/thirdplace.png" width="150px" height="200px" />
    	</c:when>
    	<c:otherwise>
        	<label id="resultLabel" class="bold">You lose...</label>
			<img id="resultImg" src="img/misc/youtried.png" width="150px" height="200px" />
    	</c:otherwise>
	</c:choose>
	<label id="classLabel">Class: ${raceResult.racingClass}</label>
	</div>
	<table id="resultTab" border="1" style="width:50%; margin:10px auto; font-size: 22px; font-weight:bold;">
  	<tr>
    	<td>First Place: ${raceResult.place1}</td>
    	<td>Time: ${raceResult.place1Time}</td>	
  	</tr>
  	<tr>
    	<td>Second Place: ${raceResult.place2}</td>
    	<td>Time: ${raceResult.place2Time}</td>
  	</tr>
  	<tr>
    	<td>Third Place: ${raceResult.place3}</td>
    	<td>Time: ${raceResult.place3Time}</td>
  	</tr>
	</table>
		
	<script>
		var scale=window.innerHeight/500;
		document.getElementById('resultsTop').style.paddingBottom=Math.floor(20*scale)+'px';
		document.getElementById('resultLabel').style.fontSize=Math.floor(38*scale)+'px';
		document.getElementById('resultImg').style.height=Math.floor(200*scale)+'px';
		document.getElementById('resultImg').style.width=Math.floor(150*scale)+'px';
		document.getElementById('classLabel').style.fontSize=Math.floor(30*scale)+'px';
		document.getElementById('resultTab').style.fontSize=Math.floor(22*scale)+'px';
		window.open('raceMoneyFrame', 'moneyFrame');
	</script>
</body>
</html>