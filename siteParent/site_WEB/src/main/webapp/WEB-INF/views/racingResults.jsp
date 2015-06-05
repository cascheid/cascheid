<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
	<c:choose>
    	<c:when test="${finish == 1}">
			<h1>You win!</h1>
			<img src="img/misc/firstplace.gif" width="150px" height="200px" />
    	</c:when>
    	<c:when test="${finish == 2}">
			<h1>Second Place!</h1>
			<img src="img/misc/secondplace.gif" width="150px" height="200px" />
    	</c:when>
    	<c:when test="${finish == 3}">
			<h1>Third Place!</h1>
			<img src="img/misc/thirdplace.gif" width="150px" height="200px" />
    	</c:when>
    	<c:otherwise>
        	<h1>You lose...</h1>
    	</c:otherwise>
	</c:choose>
	<h2>Class: ${raceResult.racingClass}</h2>
	<h3>First Place: ${raceResult.place1}  Time: ${raceResult.place1Time}</h3>
	<h3>Second Place: ${raceResult.place2}  Time: ${raceResult.place2Time}</h3>
	<h3>Third Place: ${raceResult.place3}  Time: ${raceResult.place3Time}</h3>
		
	<script>window.open('raceMoneyFrame', 'moneyFrame');</script>
</body>
</html>