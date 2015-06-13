<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<style>
h1{text-align: center;}
h2{text-align: center;}
h3{text-align: center;}
img{
	display: block;
	margin-left: auto;
	margin-right: auto;
}
</style>
<title>Race Results</title>
</head>
<body>
	<h2>Class: ${raceResult.racingClass}</h2>
	<table border="1" style="width:50%; margin:10px auto; font-size: 22px; font-weight:bold;">
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
</body>
</html>