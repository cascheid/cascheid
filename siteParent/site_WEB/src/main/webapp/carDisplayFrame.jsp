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
		out.println("<h2>Lap Efficiency: " + raceCar.getLapEfficiency()*100 + "%</h2>");
		out.println("<img src=\"img/cars/"+raceCar.getModel()+".png\" width=\"400px\" height=\"200px\">");
		out.println("<form method=\"POST\" id=\"buyForm\" action=\"purchaseCar.jsp\">");
		out.println("<input id=\"carID\" type=\"hidden\" name=\"carID\"/>");
		out.println("<input id=\"acceleration\" type=\"hidden\" name=\"acceleration\"/>");
		out.println("<input id=\"topSpeed\" type=\"hidden\" name=\"topSpeed\"/>");
		out.println("<input id=\"reliability\" type=\"hidden\" name=\"reliability\"/>");
		out.println("<input id=\"lapEfficiency\" type=\"hidden\" name=\"lapEfficiency\"/>");
		out.println("<input id=\"racingClass\" type=\"hidden\" name=\"racingClass\"/>");
		out.println("<input id=\"price\" type=\"hidden\" name=\"price\"/>");
		out.println("<input id=\"model\" type=\"hidden\" name=\"model\"/>");
		out.println("</form>");
		/*out.println("<input id=\"firstPlaceForm\" type=\"hidden\" name=\"firstPlace\"/>");
				<input id="firstPlaceTimeForm" type="hidden" name="firstPlaceTime"/>
				<input id="secondPlaceForm" type="hidden" name="secondPlace"/>
				<input id="secondPlaceTimeForm" type="hidden" name="secondPlaceTime"/>
				<input id="thirdPlaceForm" type="hidden" name="thirdPlace"/>
				<input id="thirdPlaceTimeForm" type="hidden" name="thirdPlaceTime"/>
			</form>")*/
		out.println("<h1>Price: $"+raceCar.getPrice()+"</h><button onclick='purchaseCar()'>Buy it now</button>");
	}
	
%>
	
	<script>
		function purchaseCar(){
			if (<%=raceCar.getPrice()%>>0&&<%=racingGame.getAvailableCash()%>>=<%=raceCar.getPrice()%>){
				
				document.getElementById("carID").value=<%=raceCar.getCarID()%>;
				document.getElementById("acceleration").value=<%=raceCar.getAcceleration()%>;
				document.getElementById("topSpeed").value=<%=raceCar.getTopSpeed()%>;
				document.getElementById("reliability").value=<%=raceCar.getReliability()%>;
				document.getElementById("lapEfficiency").value=<%=raceCar.getLapEfficiency()%>;
				document.getElementById("racingClass").value='<%=raceCar.getRacingClass()%>';
				document.getElementById("price").value=<%=raceCar.getPrice()%>;
				document.getElementById("model").value="<%=raceCar.getModel()%>";
				buyForm.submit();
				//window.open("purchaseCar.jsp","rightRacingFrame");
			} else {
				window.alert("You cannot afford this car!");
			}
		}
	</script>


</body>
</html>