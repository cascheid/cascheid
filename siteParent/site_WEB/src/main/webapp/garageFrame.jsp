<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="site.racinggame.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<style>
	select {font-weight: bold; font-size: 22px; float:left}
	div.inline{float:left; width: 100%; padding-bottom:10px;}
	label.large {font-weight: bold; font-size: 22px; float:left; padding-right:10px;}
</style>
</head>
<body>
	<jsp:useBean id="racingGame" class="site.racinggame.RacingGame" scope="session"/>
	<div class="inline">
	<label class="large">Select Another Car:</label>
	<select onchange="selectGarage(this.value)">
	<%
	Integer selectedGarage=1;
	int num=0;
	for (Racecar car : racingGame.getCarList()){
		num++;
		if (car.getCarID()==racingGame.getCarID()){
			selectedGarage=num;
	  		out.println("<option selected=\"selected\" value=\""+num+"\">Garage "+num+"</option>");
		} else {
			out.println("<option value=\""+num+"\">Garage "+num+"</option>");
		}
	}
	%>
	</select>
	</div>
	<script>
		function selectGarage(selectedGarage){
			window.open("garageDisplay.jsp?garage="+selectedGarage, "garageDisplay");
		}
	</script>
	<iframe name="garageDisplay" src="garageDisplay.jsp?garage=<%=selectedGarage%>" width="100%" height="500px"></iframe>
</body>
</html>