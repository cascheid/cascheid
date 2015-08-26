<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="css/site.css?test=3"/>
<link rel="stylesheet" type="text/css" href="css/racing.css?test=3"/>
<title>CAScheid Racing Game</title>
</head>
<body>
	<h1>Racing Class: ${raceCar.racingClass.charAt(0)}</h1>
	<div style="text-align:center; width=100%">
	<img src="img/cars/${raceCar.model}" width="400px" height="200px" />
	</div>
	<div class="statsinline">
		<label class="stats">Top Speed: ${raceCar.topSpeed} mph</label>
		<div class="statsPath">
			<div id="speedDisplay" class="statsDisplayBlock"></div>
		</div>
	</div>
	<div class="statsinline">
		<label class="stats">Acceleration: ${raceCar.acceleration} mph/s</label>
		<div class="statsPath">
			<div id="accelDisplay" class="statsDisplayBlock"></div>
		</div>
	</div>
	<div class="statsinline">
		<label class="stats">Reliability: ${raceCar.reliability*100}%</label>
		<div class="statsPath">
			<div id="relDisplay" class="statsDisplayBlock"></div>
		</div>
	</div>
	<div class="statsinline">
		<label class="stats">Lap Efficiency: ${raceCar.lapEfficiency*100}%</label>
		<div class="statsPath">
			<div id="efflDisplay" class="statsDisplayBlock"></div>
		</div>
	</div>
	
	<script>
	document.getElementById("speedDisplay").style.width="${raceCar.topSpeed/4}%";
	document.getElementById("accelDisplay").style.width="${raceCar.acceleration/0.8}%";
	document.getElementById("relDisplay").style.width="${raceCar.reliability*100}%";
	document.getElementById("efflDisplay").style.width="${(raceCar.lapEfficiency/0.8)*100}%";
	</script>
</body>
</html>