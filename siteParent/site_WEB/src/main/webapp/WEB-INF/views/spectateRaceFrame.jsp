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
	div.tracklap1 {float:left; width:80px; height:100%; background-color: lightblue; background-image: url("../img/misc/one.png"); background-position:center; background-repeat: no-repeat; background-size:contain; }
	div.tracklap2 {float:left; width:80px; height:100%; background-color: seagreen; background-image: url("../img/misc/two.png"); background-position:center; background-repeat: no-repeat; background-size:contain; }
	div.tracklap3 {float:left; width:80px; height:100%; background-color: royalblue; background-image: url("../img/misc/three.png"); background-position:center; background-repeat: no-repeat; background-size:contain; }
	div.tracklap4 {float:left; width:80px; height:100%; background-color: lightsalmon; background-image: url("../img/misc/four.png"); background-position:center; background-repeat: no-repeat; background-size:contain; }
	div.tracklap5 {float:left; width:80px; height:100%; background-color: indianred; background-image: url("../img/misc/five.png"); background-position:center; background-repeat: no-repeat; background-size:contain; }
	div.middle {float:left; margin-left:0px; width:70px; height:100%; background-color: lightgreen; background-image: url("../img/misc/one.png"); background-position:center; background-repeat: no-repeat; background-size:contain; }
	img.car {position:absolute;
	bottom:0;
    -webkit-transform: rotate(270deg);
    -moz-transform: rotate(270deg);
    -o-transform: rotate(270deg);
    -ms-transform: rotate(270deg);
    transform: rotate(270deg);
	}
	
	img.yoshi{position:absolute;
	bottom:200px;
	margin-left:-50px;}
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
			
			var car1Accel=${racer1.acceleration};
			var car2Accel=${racer2.acceleration};
			var car3Accel=${racer3.acceleration};
			var car4Accel=${racer4.acceleration};
			
			var car1TopSpeed=${racer1.topSpeed*(1-((1-racer1.reliability)*Math.random()))};
			var car2TopSpeed=${racer2.topSpeed*(1-((1-racer2.reliability)*Math.random()))};
			var car3TopSpeed=${racer3.topSpeed*(1-((1-racer3.reliability)*Math.random()))};
			var car4TopSpeed=${racer4.topSpeed*(1-((1-racer4.reliability)*Math.random()))};
			
			var car1LapEfficiency=${racer1.lapEfficiency};
			var car2LapEfficiency=${racer2.lapEfficiency};
			var car3LapEfficiency=${racer3.lapEfficiency};
			var car4LapEfficiency=${racer4.lapEfficiency};

			var car1Location=0;
			var car2Location=0;
			var car3Location=0;
			var car4Location=0;

			var car1Lap=1;
			var car2Lap=1;
			var car3Lap=1;
			var car4Lap=1;

			var car1CurVelocity=0;
			var car2CurVelocity=0;
			var car3CurVelocity=0;
			var car4CurVelocity=0;

			var car1Egged=false;
			var car2Egged=false;
			var car3Egged=false;
			var car4Egged=false;
			
			function moveAllCars(){
				elapsedTime += .01;
				if (car1Location < distance) {
					car1CurVelocity = car1CurVelocity + 0.01*car1Accel;//not exact, but close enough
					if (car1Egged){
						car1CurVelocity=0;
					}
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
						car1.style.bottom = 100*(car1Location%lapDistance)/lapDistance+"%";
						if (car1Location/lapDistance>car1Lap){
							car1Lap+=1;
							car1CurVelocity=car1CurVelocity*car1LapEfficiency;
							if (car1Lap==2){
								track1.className="tracklap2";
								car1TopSpeed=${racer1.topSpeed * (1-((1-racer1.reliability)*Math.random()))};
								car1Acceleration=${racer1.acceleration * (1-((1-racer1.reliability)*Math.random()))};
							} else if (car1Lap==3){
								track1.className="tracklap3";
								car1TopSpeed=${racer1.topSpeed * (1-((1-racer1.reliability)*Math.random()))};
								car1Acceleration=${racer1.acceleration * (1-((1-racer1.reliability)*Math.random()))};
							} else if (car1Lap==4){
								track1.className="tracklap4";
								car1TopSpeed=${racer1.topSpeed * (1-((1-racer1.reliability)*Math.random()))};
								car1Acceleration=${racer1.acceleration * (1-((1-racer1.reliability)*Math.random()))};
							} else if (car1Lap==5){
								track1.className="tracklap5";
								car1TopSpeed=${racer1.topSpeed * (1-((1-racer1.reliability)*Math.random()))};
								car1Acceleration=${racer1.acceleration * (1-((1-racer1.reliability)*Math.random()))};
							}
						}
					}
				}

				if (car2Location < distance) {
					car2CurVelocity = car2CurVelocity + 0.01*car2Accel;
					if (car2Egged){
						car2CurVelocity=0;
					}
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
						car2.style.bottom = 100*(car2Location%lapDistance)/lapDistance+"%";
						if (car2Location/lapDistance>car2Lap){
							car2Lap+=1;
							car2CurVelocity=car2CurVelocity*car2LapEfficiency;
							if (car2Lap==2){
								track2.className="tracklap2";
								car2TopSpeed=${racer2.topSpeed * (1-((1-racer2.reliability)*Math.random()))};
								car2Acceleration=${racer2.acceleration * (1-((1-racer2.reliability)*Math.random()))};
							} else if (car2Lap==3){
								track2.className="tracklap3";
								car2TopSpeed=${racer2.topSpeed * (1-((1-racer2.reliability)*Math.random()))};
								car2Acceleration=${racer2.acceleration * (1-((1-racer2.reliability)*Math.random()))};
							} else if (car2Lap==4){
								track2.className="tracklap4";
								car2TopSpeed=${racer2.topSpeed * (1-((1-racer2.reliability)*Math.random()))};
								car2Acceleration=${racer2.acceleration * (1-((1-racer2.reliability)*Math.random()))};
							} else if (car2Lap==5){
								track2.className="tracklap5";
								car2TopSpeed=${racer2.topSpeed * (1-((1-racer2.reliability)*Math.random()))};
								car2Acceleration=${racer2.acceleration * (1-((1-racer2.reliability)*Math.random()))};
							}
						}
					}
				}

				if (car3Location < distance) {
					car3CurVelocity = car3CurVelocity + 0.01*car3Accel;//not exact, but close enough
					if (car3Egged){
						car3CurVelocity=0;
					}
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
						car3.style.bottom = 100*(car3Location%lapDistance)/lapDistance+"%";
						if (car3Location/lapDistance>car3Lap){
							car3Lap+=1;
							car3CurVelocity=car3CurVelocity*car3LapEfficiency;
							if (car3Lap==2){
								track3.className="tracklap2";
								car3TopSpeed=${racer3.topSpeed * (1-((1-racer3.reliability)*Math.random()))};
								car3Acceleration=${racer3.acceleration * (1-((1-racer3.reliability)*Math.random()))};
							} else if (car3Lap==3){
								track3.className="tracklap3";
								car3TopSpeed=${racer3.topSpeed * (1-((1-racer3.reliability)*Math.random()))};
								car3Acceleration=${racer3.acceleration * (1-((1-racer3.reliability)*Math.random()))};
							} else if (car3Lap==4){
								track3.className="tracklap4";
								car3TopSpeed=${racer3.topSpeed * (1-((1-racer3.reliability)*Math.random()))};
								car3Acceleration=${racer3.acceleration * (1-((1-racer3.reliability)*Math.random()))};
							} else if (car3Lap==5){
								track3.className="tracklap5";
								car3TopSpeed=${racer3.topSpeed * (1-((1-racer3.reliability)*Math.random()))};
								car3Acceleration=${racer3.acceleration * (1-((1-racer3.reliability)*Math.random()))};
							}
						}
					}
				}

				if (car4Location < distance) {
					car4CurVelocity = car4CurVelocity + 0.01*car4Accel;//not exact, but close enough
					if (car4Egged){
						car4CurVelocity=0;
					}
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
						car4.style.bottom = 100*(car4Location%lapDistance)/lapDistance+"%";
						if (car4Location/lapDistance>car4Lap){
							car4Lap+=1;
							car4CurVelocity=car4CurVelocity*car4LapEfficiency;
							if (car4Lap==2){
								track4.className="tracklap2";
								car4TopSpeed=${racer4.topSpeed * (1-((1-racer4.reliability)*Math.random()))};
								car4Acceleration=${racer4.acceleration * (1-((1-racer4.reliability)*Math.random()))};
							} else if (car4Lap==3){
								track4.className="tracklap3";
								car4TopSpeed=${racer4.topSpeed * (1-((1-racer4.reliability)*Math.random()))};
								car4Acceleration=${racer4.acceleration * (1-((1-racer4.reliability)*Math.random()))};
							} else if (car4Lap==4){
								track4.className="tracklap4";
								car4TopSpeed=${racer4.topSpeed * (1-((1-racer4.reliability)*Math.random()))};
								car4Acceleration=${racer4.acceleration * (1-((1-racer4.reliability)*Math.random()))};
							} else if (car4Lap==5){
								track4.className="tracklap5";
								car4TopSpeed=${racer4.topSpeed * (1-((1-racer4.reliability)*Math.random()))};
								car4Acceleration=${racer4.acceleration * (1-((1-racer4.reliability)*Math.random()))};
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
			<img class="car" id="car1" src="img/cars/${racer1.model}" width="100px" height="50px">
	</div>
	<div class="middle" id="dktrack">
		<img class="yoshi" id="yoshi1" src='img/misc/yoshi-eat-14.png' width="108px" height="78px"/>
	</div>
	<div class="tracklap1" id="track2">
		<img class="car" id="car2" src="img/cars/${racer2.model}" width="100px" height="50px">
	</div>
	<div class="middle" id="dktrack">
	</div>
	<div class="tracklap1" id="track3">
		<img class="car" id="car3" src="img/cars/${racer3.model}" width="100px" height="50px">
	</div>
	<div class="middle" id="dktrack">
		<img class="yoshi" id="yoshi2" src='img/misc/yoshi-eat-14.png' width="108px" height="78px"/>
	</div>
	<div class="tracklap1" id="track4">
		<img class="car" id="car4" src="img/cars/${racer4.model}" width="100px" height="50px">
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
	<button onclick="startAnimation()"> Start!</button>
	<script>
	//startRace();
	function startAnimation(){
		startRace();
		
	var animationLoop=0;
	var bReturn=false;
	function yoshiEat(carNum){
		animationLoop+=1;
		var yoshiElem;
		if (carNum==1 || carNum==2){
			yoshiElem = document.getElementById("yoshi1");
		} else {
			yoshiElem = document.getElementById("yoshi2");
		}
		var carElem = document.getElementById("car"+carNum);
		if (animationLoop==1){
			yoshiElem.src='img/misc/yoshi-eat-1.png';
		} else if (animationLoop==2){
			yoshiElem.src='img/misc/yoshi-eat-2.png';
		} else if (animationLoop==3){
			yoshiElem.src='img/misc/yoshi-eat-3.png';
		} else if (animationLoop==4){
			yoshiElem.src='img/misc/yoshi-eat-4.png';
		} else if (animationLoop==5){
			yoshiElem.src='img/misc/yoshi-eat-5.png';
		} else if (animationLoop==6){
			yoshiElem.src='img/misc/yoshi-eat-6.png';
			carElem.style.visibility='hidden';
			car4Egged=true;
		} else if (animationLoop==7){
			yoshiElem.src='img/misc/yoshi-eat-7.png';
		} else if (animationLoop==8){
			yoshiElem.src='img/misc/yoshi-eat-8.png';
		} else if (animationLoop==9){
			yoshiElem.src='img/misc/yoshi-eat-9.png';
		} else if (animationLoop==10){
			yoshiElem.src='img/misc/yoshi-eat-10.png';
		} else if (animationLoop==11){
			yoshiElem.src='img/misc/yoshi-eat-11.png';
		} else if (animationLoop==12){
			yoshiElem.src='img/misc/yoshi-eat-12.png';
		} else if (animationLoop==13){
			yoshiElem.src='img/misc/yoshi-eat-13.png';
		} else if (animationLoop==14){
			yoshiElem.src='img/misc/yoshi-eat-14.png';
		} else if (animationLoop==15){
			yoshiElem.src='img/misc/yoshi-eat-15.png';
		} else if (animationLoop==16){
			yoshiElem.src='img/misc/yoshi-eat-16.png';
		} else if (animationLoop==17){
			yoshiElem.src='img/misc/yoshi-eat-15.png';
		} else if (animationLoop==18){
			yoshiElem.src='img/misc/yoshi-eat-14.png';
			carElem.src='img/misc/yoshi-egg-lb2.png';
			carElem.style.visibility='';
		} else if (animationLoop%8==3){
			carElem.style.webkitTransform='rotate(260deg)';
			carElem.style.MozTransform='rotate(260deg)';
			carElem.style.transform='rotate(260deg)';
		} else if (animationLoop%8==4){
			carElem.style.webkitTransform='rotate(250deg)';
			carElem.style.MozTransform='rotate(250deg)';
			carElem.style.transform='rotate(250deg)';
		} else if (animationLoop%8==5){
			carElem.style.webkitTransform='rotate(260deg)';
			carElem.style.MozTransform='rotate(260deg)';
			carElem.style.transform='rotate(260deg)';
		} else if (animationLoop%8==6){
			carElem.style.webkitTransform='rotate(270deg)';
			carElem.style.MozTransform='rotate(270deg)';
			carElem.style.transform='rotate(270deg)';
		} else if (animationLoop%8==7){
			carElem.style.webkitTransform='rotate(280deg)';
			carElem.style.MozTransform='rotate(280deg)';
			carElem.style.transform='rotate(280deg)';
		} else if (animationLoop%8==0){
			carElem.style.webkitTransform='rotate(290deg)';
			carElem.style.MozTransform='rotate(290deg)';
			carElem.style.transform='rotate(290deg)';
		} else if (animationLoop%8==1){
			carElem.style.webkitTransform='rotate(280deg)';
			carElem.style.MozTransform='rotate(280deg)';
			carElem.style.transform='rotate(280deg)';
		} else if (animationLoop%8==2){
			carElem.style.webkitTransform='rotate(270deg)';
			carElem.style.MozTransform='rotate(270deg)';
			carElem.style.transform='rotate(270deg)';
		}
		if (animationLoop>24){
			if (Math.random()<.0002*animationLoop){
				bReturn=true;
			}
		}
		if (animationLoop>100){
			bReturn=true;
		}

		if (bReturn){
			carElem.style.webkitTransform='rotate(270deg)';
			carElem.style.MozTransform='rotate(270deg)';
			carElem.style.transform='rotate(270deg)';
			carElem.src='img/cars/${racer3.model}';
			car4Egged=false;
			clearInterval(yoshiid);
		}
	}
	var yoshiid = setInterval(function() { yoshiEat(4); }, 40);
	}
	</script>
</body>
</html>