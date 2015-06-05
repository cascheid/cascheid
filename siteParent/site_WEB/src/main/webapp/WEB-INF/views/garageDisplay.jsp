<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
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
	<h1>Racing Class: ${raceCar.racingClass}</h1>
	<img src="img/cars/${raceCar.model}" width="400px" height="200px" />
	<div class="inline">
		<label>Top Speed: ${raceCar.topSpeed} mph</label>
		<div class="path">
			<div id="speedDisplay" class="displayBlock"></div>
		</div>
	</div>
	<div class="inline">
		<label>Acceleration: ${raceCar.acceleration} mph/s</label>
		<div class="path">
			<div id="accelDisplay" class="displayBlock"></div>
		</div>
	</div>
	<div class="inline">
		<label>Reliability: ${raceCar.reliability*100}%</label>
		<div class="path">
			<div id="relDisplay" class="displayBlock"></div>
		</div>
	</div>
	<div class="inline">
		<label>Lap Efficiency: ${raceCar.lapEfficiency*100}%</label>
		<div class="path">
			<div id="efflDisplay" class="displayBlock"></div>
		</div>
	</div>
	
	<script>
	document.getElementById("speedDisplay").style.width="${raceCar.topSpeed/4}%";
	document.getElementById("accelDisplay").style.width="${raceCar.acceleration}%";
	document.getElementById("relDisplay").style.width="${raceCar.reliability*100}%";
	document.getElementById("efflDisplay").style.width="${raceCar.lapEfficiency*100}%";
	</script>
</body>
</html>