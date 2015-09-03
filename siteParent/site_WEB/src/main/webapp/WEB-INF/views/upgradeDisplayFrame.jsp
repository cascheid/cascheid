<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="css/site.css?version=1.00"/>
<link rel="stylesheet" type="text/css" href="css/racing.css?version=1.00"/>
<title>CAScheid Racing Game</title>
</head>
<body>
	<div class="statsinline">
		<label class="stats">Top Speed: ${raceCar.topSpeed} mph</label>
		<div id="speedDisplay" class="statsPath"></div>
	</div>
	<div class="statsinline">
		<label class="stats">Acceleration: ${raceCar.acceleration}
			mph/s</label>
		<div id="accelDisplay" class="statsPath"></div>
	</div>
	<div class="statsinline">
		<label class="stats">Reliability: ${raceCar.reliability*100}%</label>
		<div class="statsPath" id="relDisplay"></div>
	</div>
	<div class="statsinline">
		<label class="stats">Lap Efficiency:
			${raceCar.lapEfficiency*100}%</label>
		<div class="statsPath" id="effDisplay"></div>
	</div>
	<div class="statsinline" style="text-align:center">
		<img id="resultImg" src="img/cars/${raceCar.model}" width="400px" height="200px">
	</div>
	<form:form method="POST" id="buyForm" action="purchaseUpgrade" commandName="upgrade">
		<form:input type="hidden" path="upgradeID" value="${upgrade.upgradeID}" />
		<form:input type="hidden" path="racingClass" value="${upgrade.racingClass}" />
		<form:input type="hidden" path="price" value="${upgrade.price}" />
		<form:input type="hidden" path="topSpeedMod" value="${upgrade.topSpeedMod}" />
		<form:input type="hidden" path="accelerationMod" value="${upgrade.accelerationMod}" />
		<form:input type="hidden" path="reliabilityMod" value="${upgrade.reliabilityMod}" />
		<form:input type="hidden" path="efficiencyMod" value="${upgrade.efficiencyMod}" />
	</form:form>
	<div id="buttondiv">
		<div class="statsinline">
			<div class="statssplit">
				<h1>Price: $<spring:eval expression="upgrade.price" /></h1>
			</div>
			<div class="statssplit">
				<button onclick='purchaseUpgrade()'>Buy upgrade</button>
			</div>
		</div>
	</div>
	<script>
		if (${upgrade.price==null}){
			document.getElementById("buttondiv").style.display='none';
		} else {
			document.getElementById("speedDisplay").style.background='linear-gradient(to right, royalblue 0%, royalblue ${raceCar.topSpeed/4}%, lightgreen ${raceCar.topSpeed/4}%, lightgreen ${(raceCar.topSpeed+upgrade.topSpeedMod)/4}%, white ${(raceCar.topSpeed+upgrade.topSpeedMod)/4}%, white 100%)';
			document.getElementById("accelDisplay").style.background='linear-gradient(to right, royalblue 0%, royalblue ${raceCar.acceleration/.8}%, lightgreen ${raceCar.acceleration/.8}%, lightgreen ${(raceCar.acceleration+upgrade.accelerationMod)/.8}%, white ${(raceCar.acceleration+upgrade.accelerationMod)/.8}%, white 100%)';
			document.getElementById("relDisplay").style.background='linear-gradient(to right, royalblue 0%, royalblue ${raceCar.reliability*100}%, lightgreen ${raceCar.reliability*100}%, lightgreen ${(raceCar.reliability+upgrade.reliabilityMod)*100}%, white ${(raceCar.reliability+upgrade.reliabilityMod)*100}%, white 100%)';
			document.getElementById("effDisplay").style.background='linear-gradient(to right, royalblue 0%, royalblue ${raceCar.lapEfficiency*125}%, lightgreen ${raceCar.lapEfficiency*125}%, lightgreen ${(raceCar.lapEfficiency+upgrade.efficiencyMod)*125}%, white ${(raceCar.lapEfficiency+upgrade.efficiencyMod)*125}%, white 100%)';
		}
		
		function purchaseUpgrade(){
			if (${upgrade.price} <= ${availableCash}){
				buyForm.submit();
			} else {
				window.alert("You cannot afford this upgrade!");
			}
		}
	</script>
</body>
</html>