<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="site.racinggame.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
</head>
<body>
	<jsp:useBean id="racingGame" class="site.racinggame.RacingGame" scope="session"/>
	<jsp:useBean id="raceCar" class="site.racinggame.Racecar" scope="session"/>
	<jsp:setProperty name="raceCar" property="*"/> 
	<%
	racingGame.setAvailableCash(racingGame.getAvailableCash()-raceCar.getPrice());
	racingGame.addNewCar(raceCar);
	out.println("<h1>Purchase Successful!</h1>");
	out.println("<img src=\"img/cars/"+raceCar.getModel()+".png\" width=\"400px\" height=\"200px\">");
	out.println("<script>window.open('raceMoneyFrame.jsp', 'moneyFrame');</script>");
	%>


</body>
</html>