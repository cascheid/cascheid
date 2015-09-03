<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="site.racinggame.*" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="css/site.css?version=1.00"/>
<title>CAScheid Racing Game</title>
</head>
<body>
	<h1>Purchase Successful!</h1>
	<div class="fullCenter">
		<img id="resultImg" src="img/cars/${carModel}" width="400px" height="200px" />
	</div>
	<script>window.open('raceMoneyFrame', 'moneyFrame');</script>
</body>
</html>