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
	<%out.println("identifier: " + racingGame.getRacingIdentifier()); %>
	<%out.println("car ID: " + racingGame.getCarID()); %>
	<%out.println("cash: " + racingGame.getAvailableCash()); %>
<%
	Racecar raceCar=null;
	Integer option=null;
	if(request.getParameter("option")==null){
		out.println("<h1> You have "+RacingGameUtils.formatMoney(racingGame.getAvailableCash())+" to spend</h1>");
	} else {
		option = Integer.parseInt(request.getParameter("option"));
		//select info from database based on option
		raceCar = RacingGameUtils.getRacecarByID(option);
		out.println("<h2>Top Speed: " + raceCar.getTopSpeed() + " mph</h2>");
		out.println("<h2>Acceleration: " + raceCar.getAcceleration() + " mph/s</h2>");
		out.println("<h2>Reliability: " + raceCar.getReliability()*100 + "%</h2>");
		out.println("<img src=\"img/cars/"+raceCar.getModel()+".png\" width=\"400px\" height=\"200px\">");
		out.println("<h1>Price: $"+raceCar.getPrice()+"</h><button onclick='purchaseCar()'>Buy it now</button>");
	}
	
%>
	<script>
		function purchaseCar(){
			<%
			if (raceCar!=null){
				double availableCash=racingGame.getAvailableCash();
				if (availableCash<raceCar.getPrice()){%>
					window.alert("You can't afford this car! Make more money!");
				<%
				} else {
					racingGame.setAvailableCash(availableCash-raceCar.getPrice());
					racingGame.addNewCar(raceCar);
					//TODO push to save
					%>
					window.alert("Purchase successful!");
					window.open("racingParentFrame.jsp", "displayFrame");
					<%
				}
			}
			%>
		}
	</script>


</body>
</html>