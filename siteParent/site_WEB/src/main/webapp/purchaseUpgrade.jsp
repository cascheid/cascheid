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
	<jsp:useBean id="upgrade" class="site.racinggame.Upgrade" scope="page"/>
	<jsp:setProperty name="upgrade" property="*"/> 
	<%
	racingGame.setAvailableCash(racingGame.getAvailableCash()-upgrade.getPrice());
	out.println("<h1>Purchase Successful!</h1>");
	for (UserRacecar car : racingGame.getCarList()){
		if (car.getCarID()==racingGame.getCarID()){
			if (car.getUpgrade1()==null){
				car.setUpgrade1(upgrade);
			} else if (car.getUpgrade2()==null){
				car.setUpgrade2(upgrade);
			} else if (car.getUpgrade3()==null){
				car.setUpgrade3(upgrade);
			} else if (car.getUpgrade4()==null){
				car.setUpgrade4(upgrade);
			} else {
				car.setUpgrade5(upgrade);
			}
			out.println("<img src=\"img/cars/"+car.getModel()+"\" width=\"400px\" height=\"200px\">");
			break;
		}
	}
	out.println("<script>window.open('raceMoneyFrame.jsp', 'moneyFrame');</script>");
	%>


</body>
</html>