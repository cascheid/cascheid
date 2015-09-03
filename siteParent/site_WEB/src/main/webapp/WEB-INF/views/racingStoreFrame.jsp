<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="css/site.css?version=1.00"/>
<style>
body{
	width:100%;
	margin:0px;
	padding:0px;
}
</style>
<title>CAScheid Racing Game</title>
</head>
<body>
	<c:forEach items="${carOptions}" var="car" varStatus="status">
			<a target="rightRacingFrame" href="carDisplayFrame?carID=${car.carID}"><h4>${car.name}</h4></a>
	</c:forEach>
</body>
</html>