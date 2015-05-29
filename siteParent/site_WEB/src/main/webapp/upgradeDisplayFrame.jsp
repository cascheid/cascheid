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
		background:linear-gradient(to right, royalblue 0%, royalblue 50%, lightgreen 50%, lightgreen 80%, white 80%, white 100%);
	}
	div.upgradedBlock{
		width:10%;
		height:20px;
		background-color:lightgreen;
	}
	
	label {font-size: 22px; font-weight:bold; display:inline-block; width:40%; float:left;}
</style>
</head>
<body>
	<jsp:useBean id="racingGame" class="site.racinggame.RacingGame" scope="session"/>
	<jsp:useBean id="upgrade" class="site.racinggame.Upgrade" scope="session"/>
	<jsp:setProperty name="upgrade" property="*"/> 
<%
	Integer option=null;
	UserRacecar myCar=racingGame.getCarList().get(0);
	if(request.getParameter("option")==null){
		out.println("<h1> You have "+RacingGameUtils.formatMoney(racingGame.getAvailableCash())+" to spend</h1>");
	} else {
		option = Integer.parseInt(request.getParameter("option"));
		//select info from database based on option
		for (UserRacecar car : racingGame.getCarList()){
			if (car.getCarID()==racingGame.getCarID()){
				myCar=car;
				break;
			}
		}
		upgrade = RacingGameUtils.getUpgradeByID(option, myCar.getRacingClass());
		out.println("<div class=\"inline\">");
		out.println("<label>Top Speed: " + myCar.getTopSpeed() + " mph</label>");
		out.println("<div id=\"speedDisplay\" class=\"path\"></div>"); 
		//out.println("<div class=\"path\"><div id=\"speedDisplay\" class=\"displayBlock\"></div></div>");
		//out.println("<div class=\"path\"><div id=\"speedUpgDisplay\" class=\"upgradedBlock\"></div></div>");
		out.println("</div>");
		out.println("<div class=\"inline\">");
		out.println("<label>Acceleration: " + myCar.getAcceleration() + " mph/s</label>");
		out.println("<div id=\"accelDisplay\" class=\"path\"></div>");
		out.println("</div>");
		out.println("<div class=\"inline\">");
		out.println("<label>Reliability: " + myCar.getReliability()*100 + "%</label>");
		out.println("<div class=\"path\" id=\"relDisplay\"></div>");
		out.println("</div>");
		out.println("<div class=\"inline\">");
		out.println("<label>Lap Efficiency: " + myCar.getLapEfficiency()*100 + "%</label>");
		out.println("<div class=\"path\" id=\"effDisplay\"></div>");
		out.println("</div>");
		out.println("<img src=\"img/cars/"+myCar.getModel()+".png\" width=\"400px\" height=\"200px\">");
		out.println("<form method=\"POST\" id=\"buyForm\" action=\"purchaseUpgrade.jsp\">");
		out.println("<input id=\"upgradeID\" type=\"hidden\" name=\"upgradeID\"/>");
		out.println("<input id=\"accelerationMod\" type=\"hidden\" name=\"accelerationMod\"/>");
		out.println("<input id=\"topSpeedMod\" type=\"hidden\" name=\"topSpeedMod\"/>");
		out.println("<input id=\"reliabilityMod\" type=\"hidden\" name=\"reliabilityMod\"/>");
		out.println("<input id=\"efficiencyMod\" type=\"hidden\" name=\"efficiencyMod\"/>");
		out.println("</form>");
		/*out.println("<input id=\"firstPlaceForm\" type=\"hidden\" name=\"firstPlace\"/>");
				<input id="firstPlaceTimeForm" type="hidden" name="firstPlaceTime"/>
				<input id="secondPlaceForm" type="hidden" name="secondPlace"/>
				<input id="secondPlaceTimeForm" type="hidden" name="secondPlaceTime"/>
				<input id="thirdPlaceForm" type="hidden" name="thirdPlace"/>
				<input id="thirdPlaceTimeForm" type="hidden" name="thirdPlaceTime"/>
			</form>")*/
		out.println("<h1>Price: $"+upgrade.getPrice()+"</h><button onclick='purchaseUpgrade()'>Buy upgrade</button>");
	}
	
%>
	<script>
			
		document.getElementById("speedDisplay").style.background='linear-gradient(to right, royalblue 0%, royalblue <%=myCar.getTopSpeed()/5%>%, lightgreen <%=myCar.getTopSpeed()/5%>%, lightgreen <%=(myCar.getTopSpeed()+upgrade.getTopSpeedMod())/5%>%, white <%=(myCar.getTopSpeed()+upgrade.getTopSpeedMod())/5%>%, white 100%)';
		document.getElementById("accelDisplay").style.background='linear-gradient(to right, royalblue 0%, royalblue <%=myCar.getAcceleration()/1.5%>%, lightgreen <%=myCar.getAcceleration()/1.5%>%, lightgreen <%=(myCar.getAcceleration()+upgrade.getAccelerationMod())/1.5%>%, white <%=(myCar.getAcceleration()+upgrade.getAccelerationMod())/5%>%, white 100%)';
		document.getElementById("relDisplay").style.background='linear-gradient(to right, royalblue 0%, royalblue <%=myCar.getReliability()*100%>%, lightgreen <%=myCar.getReliability()*100%>%, lightgreen <%=(myCar.getReliability()+upgrade.getReliabilityMod())*100%>%, white <%=(myCar.getReliability()+upgrade.getReliabilityMod())*100%>%, white 100%)';
		document.getElementById("effDisplay").style.background='linear-gradient(to right, royalblue 0%, royalblue <%=myCar.getLapEfficiency()*100%>%, lightgreen <%=myCar.getLapEfficiency()*100%>%, lightgreen <%=(myCar.getLapEfficiency()+upgrade.getEfficiencyMod())*100%>%, white <%=(myCar.getLapEfficiency()+upgrade.getEfficiencyMod())*100%>%, white 100%)';
		
	</script>
	
	<script>
		function purchaseUpgrade(){
			if (<%=upgrade.getPrice()%>>0&&<%=racingGame.getAvailableCash()%>>=<%=upgrade.getPrice()%>){
				
				document.getElementById("upgradeID").value=<%=upgrade.getUpgradeID()%>;
				document.getElementById("accelerationMod").value=<%=upgrade.getAccelerationMod()%>;
				document.getElementById("topSpeedMod").value=<%=upgrade.getTopSpeedMod()%>;
				document.getElementById("reliabilityMod").value=<%=upgrade.getReliabilityMod()%>;
				document.getElementById("efficiencyMod").value=<%=upgrade.getEfficiencyMod()%>;
				buyForm.submit();
				//window.open("purchaseCar.jsp","rightRacingFrame");
			} else {
				window.alert("You cannot afford this upgrade!");
			}
		}
	</script>


</body>
</html>