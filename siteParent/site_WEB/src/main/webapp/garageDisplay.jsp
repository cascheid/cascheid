<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="site.racinggame.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<style>
	h1 {
		position:center;
	}
	div.inline{float:left; width: 100%; padding-bottom:5px;}
	div.inlinesplit{float:left; width: 49%;}
	
	div.path{
		float:left;
		position:relative;
		overflow:hidden;
		width:49%;
		height:20px;
		border:3px solid #000;
	}
	div.displayBlock{
		width:80%;
		height:20px;
		background-color:royalblue;
	}
	
	label {font-size: 22px; font-weight:bold; display:inline-block; width:40%; float:left;}
</style>
</head>
<body>
	<jsp:useBean id="racingGame" class="site.racinggame.RacingGame" scope="session"/>
	<%
	Integer selectedGarage = Integer.parseInt(request.getParameter("garage"));
	UserRacecar car = racingGame.getCarList().get(selectedGarage-1);
	racingGame.setCarID(car.getCarID());
	out.println("<h1>Racing Class: " + car.getRacingClass() +"</h2>");
	out.println("<img src=\"img/cars/"+car.getModel()+".png\" width=\"400px\" height=\"200px\">");
	out.println("<div class=\"inline\">");
	out.println("<label>Top Speed: " + car.getTopSpeed() + " mph</label>");
	out.println("<div class=\"path\"><div id=\"speedDisplay\" class=\"displayBlock\"></div></div>");
	out.println("</div>");
	out.println("<div class=\"inline\">");
	out.println("<label>Acceleration: " + car.getAcceleration() + " mph/s</label>");
	out.println("<div class=\"path\"><div id=\"accelDisplay\" class=\"displayBlock\"></div></div>");
	out.println("</div>");
	out.println("<div class=\"inline\">");
	out.println("<label>Reliability: " + car.getReliability()*100 + "%</label>");
	out.println("<div class=\"path\"><div id=\"relDisplay\" class=\"displayBlock\"></div></div>");
	out.println("</div>");
	out.println("<div class=\"inline\">");
	out.println("<label>Lap Efficiency: " + car.getLapEfficiency()*100 + "%</label>");
	out.println("<div class=\"path\"><div id=\"efflDisplay\" class=\"displayBlock\"></div></div>");
	out.println("</div>");
	%>
	
	<script>
	document.getElementById("speedDisplay").style.width="<%=car.getTopSpeed()/5%>%";
	document.getElementById("accelDisplay").style.width="<%=car.getAcceleration()/1.5%>%";
	document.getElementById("relDisplay").style.width="<%=car.getReliability()*100%>%";
	document.getElementById("efflDisplay").style.width="<%=car.getLapEfficiency()*100%>%";
	</script>
</body>
</html>