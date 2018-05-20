<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="css/site.css?version=1.00"/>
<title>CAScheid Racing Game</title>
</head>
<body>
	<div class="fullCenter">
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
		var scale=window.innerHeight/400;
		document.getElementById('classLabel').style.fontSize=Math.floor(30*scale)+'px';
		document.getElementById('resultTab').style.fontSize=Math.floor(22*scale)+'px';
		window.open('raceMoneyFrame', 'moneyFrame');
	</script>
</body>
</html>