<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="css/site.css?test=3"/>
<link rel="stylesheet" type="text/css" href="css/racing.css?test=3">
<style>
	body{overflow-x:hidden;}
</style>
<title>CAScheid Racing Game</title>
</head>
<body>
	<div id="topBanner">
		<label id="topLabel">Class: ${raceInfo.racingClass}  Lap Length: ${raceInfo.lapDistance}  Number of Laps: ${raceInfo.noLaps}</label>
	</div>
	<script>
		var finishedRace=false;
		function startRace(){
			var distance=${raceInfo.lapDistance*raceInfo.noLaps};
			var lapDistance=${raceInfo.lapDistance};
			var elapsedTime=0;
			var firstPlace=null;
			var secondPlace=null;
			var thirdPlace=null;
			var car1Accel=${racecar.acceleration};
			var car2Accel=${racer2.acceleration};
			var car3Accel=${racer3.acceleration};
			var car4Accel=${racer4.acceleration};
			var car5Accel=${racer5.acceleration};
			var car6Accel=${racer6.acceleration};
			var car1TopSpeed=${racecar.topSpeed*(1-((1-racecar.reliability)*Math.random()))};
			var car2TopSpeed=${racer2.topSpeed*(1-((1-racer2.reliability)*Math.random()))};
			var car3TopSpeed=${racer3.topSpeed*(1-((1-racer3.reliability)*Math.random()))};
			var car4TopSpeed=${racer4.topSpeed*(1-((1-racer4.reliability)*Math.random()))};
			var car5TopSpeed=${racer5.topSpeed*(1-((1-racer5.reliability)*Math.random()))};
			var car6TopSpeed=${racer6.topSpeed*(1-((1-racer6.reliability)*Math.random()))};
			var car1LapEfficiency=${racecar.lapEfficiency};
			var car2LapEfficiency=${racer2.lapEfficiency};
			var car3LapEfficiency=${racer3.lapEfficiency};
			var car4LapEfficiency=${racer4.lapEfficiency};
			var car5LapEfficiency=${racer5.lapEfficiency};
			var car6LapEfficiency=${racer6.lapEfficiency};

			var car1Location=0;
			var car2Location=0;
			var car3Location=0;
			var car4Location=0;
			var car5Location=0;
			var car6Location=0;

			var car1Lap=1;
			var car2Lap=1;
			var car3Lap=1;
			var car4Lap=1;
			var car5Lap=1;
			var car6Lap=1;

			var car1CurVelocity=0;
			var car2CurVelocity=0;
			var car3CurVelocity=0;
			var car4CurVelocity=0;
			var car5CurVelocity=0;
			var car6CurVelocity=0;
			
			function moveAllCars(){
				elapsedTime += .01;
				if (car1Location < distance) {
					car1CurVelocity = car1CurVelocity + 0.01*car1Accel;//not exact, but close enough
					if (car1CurVelocity > car1TopSpeed) {
						car1CurVelocity=car1TopSpeed;
					}
					car1Location = car1Location + car1CurVelocity * .01;
					
					if (car1Location >= distance) {
						if (firstPlace == null) {
							firstPlace = "user";
							document.getElementById("firstPlaceTimeForm").value=elapsedTime;
						} else if (secondPlace == null) {
							secondPlace = "user";
							document.getElementById("secondPlaceTimeForm").value=elapsedTime;
						} else if (thirdPlace == null) {
							thirdPlace = "user";
							document.getElementById("thirdPlaceTimeForm").value=elapsedTime;
							finishedRace = true;
						}
					} else {
						car1.style.left = 100*(car1Location%lapDistance)/lapDistance+"%";
						if (car1Location/lapDistance>car1Lap){
							car1Lap+=1;
							car1CurVelocity=car1CurVelocity*car1LapEfficiency;
							track1.className="tracklap"+car1Lap;
							car1TopSpeed=${racecar.topSpeed * (1-((1-racecar.reliability)*Math.random()))};
							car1Acceleration=${racecar.acceleration * (1-((1-racecar.reliability)*Math.random()))};
						}
					}
				}

				if (car2Location < distance) {
					car2CurVelocity = car2CurVelocity + 0.01*car2Accel;
					if (car2CurVelocity > car2TopSpeed) {
						car2CurVelocity=car2TopSpeed;
					}
					car2Location = car2Location + car2CurVelocity * .01;
					
					if (car2Location >= distance) {
						if (firstPlace == null) {
							firstPlace = "${racer2.name}";
							document.getElementById("firstPlaceTimeForm").value=elapsedTime;
						} else if (secondPlace == null) {
							secondPlace = "${racer2.name}";
							document.getElementById("secondPlaceTimeForm").value=elapsedTime;
						} else if (thirdPlace == null) {
							thirdPlace = "${racer2.name}";
							document.getElementById("thirdPlaceTimeForm").value=elapsedTime;
							finishedRace = true;
						}
					} else {
						car2.style.left = 100*(car2Location%lapDistance)/lapDistance+"%";
						if (car2Location/lapDistance>car2Lap){
							car2Lap+=1;
							car2CurVelocity=car2CurVelocity*car2LapEfficiency;
							track2.className="tracklap"+car2Lap;
							car2TopSpeed=${racer2.topSpeed * (1-((1-racer2.reliability)*Math.random()))};
							car2Acceleration=${racer2.acceleration * (1-((1-racer2.reliability)*Math.random()))};
						}
					}
				}

				if (car3Location < distance) {
					car3CurVelocity = car3CurVelocity + 0.01*car3Accel;//not exact, but close enough
					if (car3CurVelocity > car3TopSpeed) {
						car3CurVelocity=car3TopSpeed;
					}
					car3Location = car3Location + car3CurVelocity * .01;
					
					if (car3Location >= distance) {
						if (firstPlace == null) {
							firstPlace = "${racer3.name}";
							document.getElementById("firstPlaceTimeForm").value=elapsedTime;
						} else if (secondPlace == null) {
							secondPlace = "${racer3.name}";
							document.getElementById("secondPlaceTimeForm").value=elapsedTime;
						} else if (thirdPlace == null) {
							thirdPlace = "${racer3.name}";
							document.getElementById("thirdPlaceTimeForm").value=elapsedTime;
							finishedRace = true;
						}
					} else {
						car3.style.left = 100*(car3Location%lapDistance)/lapDistance+"%";
						if (car3Location/lapDistance>car3Lap){
							car3Lap+=1;
							car3CurVelocity=car3CurVelocity*car3LapEfficiency;
							track3.className="tracklap"+car3Lap;
							car3TopSpeed=${racer3.topSpeed * (1-((1-racer3.reliability)*Math.random()))};
							car3Acceleration=${racer3.acceleration * (1-((1-racer3.reliability)*Math.random()))};
						}
					}
				}

				if (car4Location < distance) {
					car4CurVelocity = car4CurVelocity + 0.01*car4Accel;//not exact, but close enough
					if (car4CurVelocity > car4TopSpeed) {
						car4CurVelocity=car4TopSpeed;
					}
					car4Location = car4Location + car4CurVelocity * .01;
					
					if (car4Location >= distance) {
						if (firstPlace == null) {
							firstPlace = "${racer4.name}";
							document.getElementById("firstPlaceTimeForm").value=elapsedTime;
						} else if (secondPlace == null) {
							secondPlace = "${racer4.name}";
							document.getElementById("secondPlaceTimeForm").value=elapsedTime;
						} else if (thirdPlace == null) {
							thirdPlace = "${racer4.name}";
							document.getElementById("thirdPlaceTimeForm").value=elapsedTime;
							finishedRace = true;
						}
					} else {
						car4.style.left = 100*(car4Location%lapDistance)/lapDistance+"%";
						if (car4Location/lapDistance>car4Lap){
							car4Lap+=1;
							car4CurVelocity=car4CurVelocity*car4LapEfficiency;
							track4.className="tracklap"+car4Lap;
							car4TopSpeed=${racer4.topSpeed * (1-((1-racer4.reliability)*Math.random()))};
							car4Acceleration=${racer4.acceleration * (1-((1-racer4.reliability)*Math.random()))};
						}
					}
				}

				if (car5Location < distance) {
					car5CurVelocity = car5CurVelocity + 0.01*car5Accel;//not exact, but close enough
					if (car5CurVelocity > car5TopSpeed) {
						car5CurVelocity=car5TopSpeed;
					}
					car5Location = car5Location + car5CurVelocity * .01;
					
					if (car5Location >= distance) {
						if (firstPlace == null) {
							firstPlace = "${racer5.name}";
							document.getElementById("firstPlaceTimeForm").value=elapsedTime;
						} else if (secondPlace == null) {
							secondPlace = "${racer5.name}";
							document.getElementById("secondPlaceTimeForm").value=elapsedTime;
						} else if (thirdPlace == null) {
							thirdPlace = "${racer5.name}";
							document.getElementById("thirdPlaceTimeForm").value=elapsedTime;
							finishedRace = true;
						}
					} else {
						car5.style.left = 100*(car5Location%lapDistance)/lapDistance+"%";
						if (car5Location/lapDistance>car5Lap){
							car5Lap+=1;
							car5CurVelocity=car5CurVelocity*car5LapEfficiency;
							track5.className="tracklap"+car5Lap;
							car5TopSpeed=${racer5.topSpeed * (1-((1-racer5.reliability)*Math.random()))};
							car5Acceleration=${racer5.acceleration * (1-((1-racer5.reliability)*Math.random()))};
						}
					}
				}

				if (car6Location < distance) {
					car6CurVelocity = car6CurVelocity + 0.01*car6Accel;//not exact, but close enough
					if (car6CurVelocity > car6TopSpeed) {
						car6CurVelocity=car6TopSpeed;
					}
					car6Location = car6Location + car6CurVelocity * .01;
					
					if (car6Location >= distance) {
						if (firstPlace == null) {
							firstPlace = "${racer6.name}";
							document.getElementById("firstPlaceTimeForm").value=elapsedTime;
						} else if (secondPlace == null) {
							secondPlace = "${racer6.name}";
							document.getElementById("secondPlaceTimeForm").value=elapsedTime;
						} else if (thirdPlace == null) {
							thirdPlace = "${racer6.name}";
							document.getElementById("thirdPlaceTimeForm").value=elapsedTime;
							finishedRace = true;
						}
					} else {
						car6.style.left = 100*(car6Location%lapDistance)/lapDistance+"%";
						if (car6Location/lapDistance>car6Lap){
							car6Lap+=1;
							car6CurVelocity=car6CurVelocity*car6LapEfficiency;
							track6.className="tracklap"+car6Lap;
							car6TopSpeed=${racer6.topSpeed * (1-((1-racer6.reliability)*Math.random()))};
							car6Acceleration=${racer6.acceleration * (1-((1-racer6.reliability)*Math.random()))};
						}
					}
				}
				
				if (finishedRace) {
					clearInterval(raceid);
					document.getElementById("firstPlaceForm").value=firstPlace;
					document.getElementById("secondPlaceForm").value=secondPlace;
					document.getElementById("thirdPlaceForm").value=thirdPlace;
					resultForm.submit();
				}
			}

			var raceid = setInterval(moveAllCars, 10);

		}
	</script>
	<div class="trackboundary">
	</div>
	<div class="tracklap1" id="track1">
		<img class="car" id="car1" src="img/cars/${racecar.model}" width="100px" height="50px">
	</div>
	<div class="trackboundary">
	</div>
	<div class="tracklap1" id="track2">
		<img class="car" id="car2" src="img/cars/${racer2.model}" width="100px" height="50px">
	</div>
	<div class="trackboundary">
	</div>
	<div class="tracklap1" id="track3">
		<img class="car" id="car3" src="img/cars/${racer3.model}" width="100px" height="50px">
	</div>
	<div class="trackboundary">
	</div>
	<div class="tracklap1" id="track4">
		<img class="car" id="car4" src="img/cars/${racer4.model}" width="100px" height="50px">
	</div>
	<div class="trackboundary">
	</div>
	<div class="tracklap1" id="track5">
		<img class="car" id="car5" src="img/cars/${racer5.model}" width="100px" height="50px">
	</div>
	<div class="trackboundary">
	</div>
	<div class="tracklap1" id="track6">
		<img class="car" id="car6" src="img/cars/${racer6.model}" width="100px" height="50px">
	</div>
	<form:form method="POST" id="resultForm" action="racingResults" commandName="raceResult">
		<form:input id="classForm" type="hidden" path="racingClass" value="${raceInfo.racingClass}"/>
		<form:input id="firstPlaceForm" type="hidden" path="place1"/>
		<form:input id="firstPlaceTimeForm" type="hidden" path="place1Time"/>
		<form:input id="secondPlaceForm" type="hidden" path="place2"/>
		<form:input id="secondPlaceTimeForm" type="hidden" path="place2Time"/>
		<form:input id="thirdPlaceForm" type="hidden" path="place3"/>
		<form:input id="thirdPlaceTimeForm" type="hidden" path="place3Time"/>
	</form:form>
	<script>
	var dist=${raceInfo.lapDistance};
	var scale=500/dist;//Setting 500 as average scale
	var trackHeight=Math.ceil(scale*56);//56 average track height
	var carHeight=Math.floor(scale*50);
	var carWidth=Math.floor(scale*100);
	var tracks=document.getElementsByClassName('tracklap1');
	for (var i=0; i<tracks.length; i++){
		tracks[i].style.height=trackHeight+'px';
	}
	var cars=document.getElementsByClassName('car');
	for (var i=0; i<cars.length; i++){
		cars[i].style.height=carHeight+'px';
		cars[i].style.width=carWidth+'px';
	}
	var boundaries = document.getElementsByClassName('trackboundary');
	var remainder=window.innerHeight-(25+6*trackHeight);//total height minus 25 for top label, minus height*6 cars
	if (remainder>0){
		var boundHeight=Math.floor(remainder/7);
		for (var i=0; i<boundaries.length; i++){
			boundaries[i].style.height=Math.min(boundHeight, Math.round(trackHeight/4))+'px';
		}
	}
	startRace();
	</script>
</body>
</html>