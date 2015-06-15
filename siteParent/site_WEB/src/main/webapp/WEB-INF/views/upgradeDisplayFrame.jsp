<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
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
	
	button {padding-left: 10px;}
</style>
</head>
<body>
	<div class="inline">
	<label>Top Speed: ${raceCar.topSpeed} mph</label>
	<div id="speedDisplay" class="path"></div>
	</div>	
	<div class="inline">
	<label>Acceleration: ${raceCar.acceleration} mph/s</label>
	<div id="accelDisplay" class="path"></div>
	</div>
	<div class="inline">
	<label>Reliability: ${raceCar.reliability*100}%</label>
	<div class="path" id="relDisplay"></div>
	</div>
	<div class="inline">
	<label>Lap Efficiency: ${raceCar.lapEfficiency*100}%</label>
	<div class="path" id="effDisplay"></div>
	</div>
	<img src="img/cars/${raceCar.model}" width="400px" height="200px">
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
	<h1>Price: $${upgrade.price}</h1><button onclick='purchaseUpgrade()'>Buy upgrade</button>
	</div>
	<script>
		if (${upgrade.price==null}){
			document.getElementById("buttondiv").style.display='none';
		} else {
			document.getElementById("speedDisplay").style.background='linear-gradient(to right, royalblue 0%, royalblue ${raceCar.topSpeed/4}%, lightgreen ${raceCar.topSpeed/4}%, lightgreen ${(raceCar.topSpeed+upgrade.topSpeedMod)/4}%, white ${(raceCar.topSpeed+upgrade.topSpeedMod)/4}%, white 100%)';
			document.getElementById("accelDisplay").style.background='linear-gradient(to right, royalblue 0%, royalblue ${raceCar.acceleration/.8}%, lightgreen ${raceCar.acceleration/.8}%, lightgreen ${(raceCar.acceleration+upgrade.accelerationMod)/.8}%, white ${(raceCar.acceleration+upgrade.accelerationMod)/.8}%, white 100%)';
			document.getElementById("relDisplay").style.background='linear-gradient(to right, royalblue 0%, royalblue ${raceCar.reliability*100}%, lightgreen ${raceCar.reliability*100}%, lightgreen ${(raceCar.reliability+upgrade.reliabilityMod)*100}%, white ${(raceCar.reliability+upgrade.reliabilityMod)*100}%, white 100%)';
			document.getElementById("effDisplay").style.background='linear-gradient(to right, royalblue 0%, royalblue ${raceCar.lapEfficiency*100}%, lightgreen ${raceCar.lapEfficiency*100}%, lightgreen ${(raceCar.lapEfficiency+upgrade.efficiencyMod)*100}%, white ${(raceCar.lapEfficiency+upgrade.efficiencyMod)*100}%, white 100%)';
		}
		
	</script>
	
	<script>
		function purchaseUpgrade(){
			if (${upgrade.price} <= ${availableCash}){
				
				//document.getElementById("upgradeID").value=${upgrade.upgradeID};
				//document.getElementById("accelerationMod").value=${upgrade.accelerationMod};
				//document.getElementById("topSpeedMod").value=${upgrade.accelerationMod};
				//document.getElementById("reliabilityMod").value=${upgrade.accelerationMod};
				//document.getElementById("efficiencyMod").value=${upgrade.accelerationMod};
				//document.getElementById("efficiencyMod").value=${upgrade.accelerationMod};
				//document.getElementById("price").value=${upgrade.accelerationMod};
				buyForm.submit();
				//window.open("purchaseUpgrade?upgradeID=${upgrade.upgradeID}","_self");
			} else {
				window.alert("You cannot afford this upgrade!");
			}
		}
	</script>


</body>
</html>