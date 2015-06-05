<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="css/racing.css">
<style>
	body{overflow:hidden;}
</style>
</head>
<body>
	<h3>Class: ${raceInfo.racingClass}  Lap Length: ${raceInfo.lapDistance}  Number of Laps: ${raceInfo.noLaps}</h3>
	
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
			var car2Accel=${opponent2.acceleration};
			var car3Accel=${opponent3.acceleration};
			var car4Accel=${opponent4.acceleration};
			var car5Accel=${opponent5.acceleration};
			var car6Accel=${opponent6.acceleration};
			var car1TopSpeed=${racecar.topSpeed*(1-((1-racecar.reliability)*Math.random()))};
			var car2TopSpeed=${opponent2.topSpeed*(1-((1-opponent2.reliability)*Math.random()))};
			var car3TopSpeed=${opponent3.topSpeed*(1-((1-opponent3.reliability)*Math.random()))};
			var car4TopSpeed=${opponent4.topSpeed*(1-((1-opponent4.reliability)*Math.random()))};
			var car5TopSpeed=${opponent5.topSpeed*(1-((1-opponent5.reliability)*Math.random()))};
			var car6TopSpeed=${opponent6.topSpeed*(1-((1-opponent6.reliability)*Math.random()))};
			var car1LapEfficiency=${racecar.lapEfficiency};
			var car2LapEfficiency=${opponent2.lapEfficiency};
			var car3LapEfficiency=${opponent3.lapEfficiency};
			var car4LapEfficiency=${opponent4.lapEfficiency};
			var car5LapEfficiency=${opponent5.lapEfficiency};
			var car6LapEfficiency=${opponent6.lapEfficiency};

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
							firstPlace = "car1";
							document.getElementById("firstPlaceTimeForm").value=elapsedTime;
						} else if (secondPlace == null) {
							secondPlace = "car1";
							document.getElementById("secondPlaceTimeForm").value=elapsedTime;
						} else if (thirdPlace == null) {
							thirdPlace = "car1";
							document.getElementById("thirdPlaceTimeForm").value=elapsedTime;
							finishedRace = true;
						}
					} else {
						car1.style.left = 100*(car1Location%lapDistance)/lapDistance+"%";
						if (car1Location/lapDistance>car1Lap){
							car1Lap+=1;
							car1CurVelocity=car1CurVelocity*car1LapEfficiency;
							if (car1Lap==2){
								track1.className="tracklap2";
								car1TopSpeed=${racecar.topSpeed * (1-((1-racecar.reliability)*Math.random()))};
								car1Acceleration=${racecar.acceleration * (1-((1-racecar.reliability)*Math.random()))};
							} else if (car1Lap==3){
								track1.className="tracklap3";
								car1TopSpeed=${racecar.topSpeed * (1-((1-racecar.reliability)*Math.random()))};
								car1Acceleration=${racecar.acceleration * (1-((1-racecar.reliability)*Math.random()))};
							} else if (car1Lap==4){
								track1.className="tracklap4";
								car1TopSpeed=${racecar.topSpeed * (1-((1-racecar.reliability)*Math.random()))};
								car1Acceleration=${racecar.acceleration * (1-((1-racecar.reliability)*Math.random()))};
							} else if (car1Lap==5){
								track1.className="tracklap5";
								car1TopSpeed=${racecar.topSpeed * (1-((1-racecar.reliability)*Math.random()))};
								car1Acceleration=${racecar.acceleration * (1-((1-racecar.reliability)*Math.random()))};
							}
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
							firstPlace = "car2";
							document.getElementById("firstPlaceTimeForm").value=elapsedTime;
						} else if (secondPlace == null) {
							secondPlace = "car2";
							document.getElementById("secondPlaceTimeForm").value=elapsedTime;
						} else if (thirdPlace == null) {
							thirdPlace = "car2";
							document.getElementById("thirdPlaceTimeForm").value=elapsedTime;
							finishedRace = true;
						}
					} else {
						car2.style.left = 100*(car2Location%lapDistance)/lapDistance+"%";
						if (car2Location/lapDistance>car2Lap){
							car2Lap+=1;
							car2CurVelocity=car2CurVelocity*car2LapEfficiency;
							if (car2Lap==2){
								track2.className="tracklap2";
								car2TopSpeed=${opponent2.topSpeed * (1-((1-opponent2.reliability)*Math.random()))};
								car2Acceleration=${opponent2.acceleration * (1-((1-opponent2.reliability)*Math.random()))};
							} else if (car2Lap==3){
								track2.className="tracklap3";
								car2TopSpeed=${opponent2.topSpeed * (1-((1-opponent2.reliability)*Math.random()))};
								car2Acceleration=${opponent2.acceleration * (1-((1-opponent2.reliability)*Math.random()))};
							} else if (car2Lap==4){
								track2.className="tracklap4";
								car2TopSpeed=${opponent2.topSpeed * (1-((1-opponent2.reliability)*Math.random()))};
								car2Acceleration=${opponent2.acceleration * (1-((1-opponent2.reliability)*Math.random()))};
							} else if (car2Lap==5){
								track2.className="tracklap5";
								car2TopSpeed=${opponent2.topSpeed * (1-((1-opponent2.reliability)*Math.random()))};
								car2Acceleration=${opponent2.acceleration * (1-((1-opponent2.reliability)*Math.random()))};
							}
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
							firstPlace = "car3";
							document.getElementById("firstPlaceTimeForm").value=elapsedTime;
						} else if (secondPlace == null) {
							secondPlace = "car3";
							document.getElementById("secondPlaceTimeForm").value=elapsedTime;
						} else if (thirdPlace == null) {
							thirdPlace = "car3";
							document.getElementById("thirdPlaceTimeForm").value=elapsedTime;
							finishedRace = true;
						}
					} else {
						car3.style.left = 100*(car3Location%lapDistance)/lapDistance+"%";
						if (car3Location/lapDistance>car3Lap){
							car3Lap+=1;
							car3CurVelocity=car3CurVelocity*car3LapEfficiency;
							if (car3Lap==2){
								track3.className="tracklap2";
								car3TopSpeed=${opponent3.topSpeed * (1-((1-opponent3.reliability)*Math.random()))};
								car3Acceleration=${opponent3.acceleration * (1-((1-opponent3.reliability)*Math.random()))};
							} else if (car3Lap==3){
								track3.className="tracklap3";
								car3TopSpeed=${opponent3.topSpeed * (1-((1-opponent3.reliability)*Math.random()))};
								car3Acceleration=${opponent3.acceleration * (1-((1-opponent3.reliability)*Math.random()))};
							} else if (car3Lap==4){
								track3.className="tracklap4";
								car3TopSpeed=${opponent3.topSpeed * (1-((1-opponent3.reliability)*Math.random()))};
								car3Acceleration=${opponent3.acceleration * (1-((1-opponent3.reliability)*Math.random()))};
							} else if (car3Lap==5){
								track3.className="tracklap5";
								car3TopSpeed=${opponent3.topSpeed * (1-((1-opponent3.reliability)*Math.random()))};
								car3Acceleration=${opponent3.acceleration * (1-((1-opponent3.reliability)*Math.random()))};
							}
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
							firstPlace = "car4";
							document.getElementById("firstPlaceTimeForm").value=elapsedTime;
						} else if (secondPlace == null) {
							secondPlace = "car4";
							document.getElementById("secondPlaceTimeForm").value=elapsedTime;
						} else if (thirdPlace == null) {
							thirdPlace = "car4";
							document.getElementById("thirdPlaceTimeForm").value=elapsedTime;
							finishedRace = true;
						}
					} else {
						car4.style.left = 100*(car4Location%lapDistance)/lapDistance+"%";
						if (car4Location/lapDistance>car4Lap){
							car4Lap+=1;
							car4CurVelocity=car4CurVelocity*car4LapEfficiency;
							if (car4Lap==2){
								track4.className="tracklap2";
								car4TopSpeed=${opponent4.topSpeed * (1-((1-opponent4.reliability)*Math.random()))};
								car4Acceleration=${opponent4.acceleration * (1-((1-opponent4.reliability)*Math.random()))};
							} else if (car4Lap==3){
								track4.className="tracklap3";
								car4TopSpeed=${opponent4.topSpeed * (1-((1-opponent4.reliability)*Math.random()))};
								car4Acceleration=${opponent4.acceleration * (1-((1-opponent4.reliability)*Math.random()))};
							} else if (car4Lap==4){
								track4.className="tracklap4";
								car4TopSpeed=${opponent4.topSpeed * (1-((1-opponent4.reliability)*Math.random()))};
								car4Acceleration=${opponent4.acceleration * (1-((1-opponent4.reliability)*Math.random()))};
							} else if (car4Lap==5){
								track4.className="tracklap5";
								car4TopSpeed=${opponent4.topSpeed * (1-((1-opponent4.reliability)*Math.random()))};
								car4Acceleration=${opponent4.acceleration * (1-((1-opponent4.reliability)*Math.random()))};
							}
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
							firstPlace = "car5";
							document.getElementById("firstPlaceTimeForm").value=elapsedTime;
						} else if (secondPlace == null) {
							secondPlace = "car5";
							document.getElementById("secondPlaceTimeForm").value=elapsedTime;
						} else if (thirdPlace == null) {
							thirdPlace = "car5";
							document.getElementById("thirdPlaceTimeForm").value=elapsedTime;
							finishedRace = true;
						}
					} else {
						car5.style.left = 100*(car5Location%lapDistance)/lapDistance+"%";
						if (car5Location/lapDistance>car5Lap){
							car5Lap+=1;
							car5CurVelocity=car5CurVelocity*car5LapEfficiency;
							if (car5Lap==2){
								track5.className="tracklap2";
								car5TopSpeed=${opponent5.topSpeed * (1-((1-opponent5.reliability)*Math.random()))};
								car5Acceleration=${opponent5.acceleration * (1-((1-opponent5.reliability)*Math.random()))};
							} else if (car5Lap==3){
								track5.className="tracklap3";
								car5TopSpeed=${opponent5.topSpeed * (1-((1-opponent5.reliability)*Math.random()))};
								car5Acceleration=${opponent5.acceleration * (1-((1-opponent5.reliability)*Math.random()))};
							} else if (car5Lap==4){
								track5.className="tracklap4";
								car5TopSpeed=${opponent5.topSpeed * (1-((1-opponent5.reliability)*Math.random()))};
								car5Acceleration=${opponent5.acceleration * (1-((1-opponent5.reliability)*Math.random()))};
							} else if (car5Lap==5){
								track5.className="tracklap5";
								car5TopSpeed=${opponent5.topSpeed * (1-((1-opponent5.reliability)*Math.random()))};
								car5Acceleration=${opponent5.acceleration * (1-((1-opponent5.reliability)*Math.random()))};
							}
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
							firstPlace = "car6";
							document.getElementById("firstPlaceTimeForm").value=elapsedTime;
						} else if (secondPlace == null) {
							secondPlace = "car6";
							document.getElementById("secondPlaceTimeForm").value=elapsedTime;
						} else if (thirdPlace == null) {
							thirdPlace = "car6";
							document.getElementById("thirdPlaceTimeForm").value=elapsedTime;
							finishedRace = true;
						}
					} else {
						car6.style.left = 100*(car6Location%lapDistance)/lapDistance+"%";
						if (car6Location/lapDistance>car6Lap){
							car6Lap+=1;
							car6CurVelocity=car6CurVelocity*car6LapEfficiency;
							if (car6Lap==2){
								track6.className="tracklap2";
								car6TopSpeed=${opponent6.topSpeed * (1-((1-opponent6.reliability)*Math.random()))};
								car6Acceleration=${opponent6.acceleration * (1-((1-opponent6.reliability)*Math.random()))};
							} else if (car6Lap==3){
								track6.className="tracklap3";
								car6TopSpeed=${opponent6.topSpeed * (1-((1-opponent6.reliability)*Math.random()))};
								car6Acceleration=${opponent6.acceleration * (1-((1-opponent6.reliability)*Math.random()))};
							} else if (car6Lap==4){
								track6.className="tracklap4";
								car6TopSpeed=${opponent6.topSpeed * (1-((1-opponent6.reliability)*Math.random()))};
								car6Acceleration=${opponent6.acceleration * (1-((1-opponent6.reliability)*Math.random()))};
							} else if (car6Lap==5){
								track6.className="tracklap5";
								car6TopSpeed=${opponent6.topSpeed * (1-((1-opponent6.reliability)*Math.random()))};
								car6Acceleration=${opponent6.acceleration * (1-((1-opponent6.reliability)*Math.random()))};
							}
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
	
	<div class="tracklap1" id="track1">
		<hr/>
			<img class="car" id="car1" src="img/cars/${racecar.model}" width="100px" height="50px">
		<hr/>
	</div>
	<div class="tracklap1" id="track2">
		<hr/>
			<img class="car" id="car2" src="img/cars/${opponent2.model}" width="100px" height="50px">
		<hr/>
	</div>
	<div class="tracklap1" id="track3">
		<hr/>
			<img class="car" id="car3" src="img/cars/${opponent3.model}" width="100px" height="50px">
		<hr/>
	</div>
	<div class="tracklap1" id="track4">
		<hr/>
			<img class="car" id="car4" src="img/cars/${opponent4.model}" width="100px" height="50px">
		<hr/>
	</div>
	<div class="tracklap1" id="track5">
		<hr/>
			<img class="car" id="car5" src="img/cars/${opponent5.model}" width="100px" height="50px">
		<hr/>
	</div>
	<div class="tracklap1" id="track6">
		<hr/>
			<img class="car" id="car6" src="img/cars/${opponent6.model}" width="100px" height="50px">
		<hr/>
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
	startRace();
	</script>
</body>
</html>