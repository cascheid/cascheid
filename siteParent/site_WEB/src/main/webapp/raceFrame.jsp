<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="site.racinggame.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="racing.css?test=7">
<style>
	body{overflow:hidden;}
</style>
</head>
<body>
	<jsp:useBean id="racingGame" class="site.racinggame.RacingGame" scope="session"/>
	<jsp:useBean id="raceResult" class="site.racinggame.RacingGameResult" scope="session"/>
	<jsp:setProperty name="raceResult" property="*"/> 
	<% 
	char racingClass=request.getParameter("selected").charAt(0);
	if (racingGame.getRacingClass()!='S'&&racingGame.getRacingClass()>racingClass){
		throw new IllegalStateException("invalid racing class option for this user");
	}
	racingGame.setSelectedClass(racingClass);
	Integer lapDistance=RacingGameUtils.getLapDistanceByClass(racingClass);
	Integer noLaps = RacingGameUtils.getNumberOfLaps();
	out.println("<h3>Lap Length: " + lapDistance + "  Number of Laps: " + noLaps + "</h3>");
	UserRacecar myCar=null;
	for (UserRacecar car : racingGame.getCarList()){
		if (car.getCarID()==racingGame.getCarID()){
			myCar=car;
			break;
		}
	}
	myCar=new UserRacecar(RacingGameUtils.getRandomOponentByClass(racingClass));
	Racecar car2=RacingGameUtils.getRandomOponentByClass(racingClass);
	Racecar car3=RacingGameUtils.getRandomOponentByClass(racingClass);
	Racecar car4=RacingGameUtils.getRandomOponentByClass(racingClass);
	Racecar car5=RacingGameUtils.getRandomOponentByClass(racingClass);
	Racecar car6=RacingGameUtils.getRandomOponentByClass(racingClass);
	raceResult.setRacingClass(racingClass);%>
	
	<script>
		var finishedRace=false;
		function startRace(){
			var distance=<%=lapDistance*noLaps%>;
			var lapDistance=<%=lapDistance%>;
			var elapsedTime=0;
			var firstPlace=null;
			var secondPlace=null;
			var thirdPlace=null;
			var car1Accel=<%=myCar.getAcceleration()%>;
			var car2Accel=<%=car2.getAcceleration()%>;
			var car3Accel=<%=car3.getAcceleration()%>;
			var car4Accel=<%=car4.getAcceleration()%>;
			var car5Accel=<%=car5.getAcceleration()%>;
			var car6Accel=<%=car6.getAcceleration()%>;
			var car1TopSpeed=<%=myCar.getTopSpeed()*(1-((1-myCar.getReliability())*Math.random()))%>;
			var car2TopSpeed=<%=car2.getTopSpeed()*(1-((1-car2.getReliability())*Math.random()))%>;
			var car3TopSpeed=<%=car3.getTopSpeed()*(1-((1-car3.getReliability())*Math.random()))%>;
			var car4TopSpeed=<%=car4.getTopSpeed()*(1-((1-car4.getReliability())*Math.random()))%>;
			var car5TopSpeed=<%=car5.getTopSpeed()*(1-((1-car5.getReliability())*Math.random()))%>;
			var car6TopSpeed=<%=car6.getTopSpeed()*(1-((1-car6.getReliability())*Math.random()))%>;
			var car1Reliability=<%=myCar.getReliability()%>;
			var car2Reliability=<%=car2.getReliability()%>;
			var car3Reliability=<%=car3.getReliability()%>;
			var car4Reliability=<%=car4.getReliability()%>;
			var car5Reliability=<%=car5.getReliability()%>;
			var car6Reliability=<%=car6.getReliability()%>;
			var car1LapEfficiency=<%=myCar.getLapEfficiency()%>;
			var car2LapEfficiency=<%=car2.getLapEfficiency()%>;
			var car3LapEfficiency=<%=car3.getLapEfficiency()%>;
			var car4LapEfficiency=<%=car4.getLapEfficiency()%>;
			var car5LapEfficiency=<%=car5.getLapEfficiency()%>;
			var car6LapEfficiency=<%=car6.getLapEfficiency()%>;

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
								car1TopSpeed=<%=myCar.getTopSpeed()%> * (1-((1-car1Reliability)*Math.random()));
								car1Acceleration=<%=myCar.getAcceleration()%> * (1-((1-car1Reliability)*Math.random()));
							} else if (car1Lap==3){
								track1.className="tracklap3";
								car1TopSpeed=<%=myCar.getTopSpeed()%> * (1-((1-car1Reliability)*Math.random()));
								car1Acceleration=<%=myCar.getAcceleration()%> * (1-((1-car1Reliability)*Math.random()));
							} else if (car1Lap==4){
								track1.className="tracklap4";
								car1TopSpeed=<%=myCar.getTopSpeed()%> * (1-((1-car1Reliability)*Math.random()));
								car1Acceleration=<%=myCar.getAcceleration()%> * (1-((1-car1Reliability)*Math.random()));
							} else if (car1Lap==5){
								track1.className="tracklap5";
								car1TopSpeed=<%=myCar.getTopSpeed()%> * (1-((1-car1Reliability)*Math.random()));
								car1Acceleration=<%=myCar.getAcceleration()%> * (1-((1-car1Reliability)*Math.random()));
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
								car2TopSpeed=<%=car2.getTopSpeed()%> * (1-((1-car2Reliability)*Math.random()));
								car2Acceleration=<%=car2.getAcceleration()%> * (1-((1-car2Reliability)*Math.random()));
							} else if (car2Lap==3){
								track2.className="tracklap3";
								car2TopSpeed=<%=car2.getTopSpeed()%> * (1-((1-car2Reliability)*Math.random()));
								car2Acceleration=<%=car2.getAcceleration()%> * (1-((1-car2Reliability)*Math.random()));
							} else if (car2Lap==4){
								track2.className="tracklap4";
								car2TopSpeed=<%=car2.getTopSpeed()%> * (1-((1-car2Reliability)*Math.random()));
								car2Acceleration=<%=car2.getAcceleration()%> * (1-((1-car2Reliability)*Math.random()));
							} else if (car2Lap==5){
								track2.className="tracklap5";
								car2TopSpeed=<%=car2.getTopSpeed()%> * (1-((1-car2Reliability)*Math.random()));
								car2Acceleration=<%=car2.getAcceleration()%> * (1-((1-car2Reliability)*Math.random()));
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
								car3TopSpeed=<%=car3.getTopSpeed()%> * (1-((1-car3Reliability)*Math.random()));
								car3Acceleration=<%=car3.getAcceleration()%> * (1-((1-car3Reliability)*Math.random()));
							} else if (car3Lap==3){
								track3.className="tracklap3";
								car3TopSpeed=<%=car3.getTopSpeed()%> * (1-((1-car3Reliability)*Math.random()));
								car3Acceleration=<%=car3.getAcceleration()%> * (1-((1-car3Reliability)*Math.random()));
							} else if (car3Lap==4){
								track3.className="tracklap4";
								car3TopSpeed=<%=car3.getTopSpeed()%> * (1-((1-car3Reliability)*Math.random()));
								car3Acceleration=<%=car3.getAcceleration()%> * (1-((1-car3Reliability)*Math.random()));
							} else if (car3Lap==5){
								track3.className="tracklap5";
								car3TopSpeed=<%=car3.getTopSpeed()%> * (1-((1-car3Reliability)*Math.random()));
								car3Acceleration=<%=car3.getAcceleration()%> * (1-((1-car3Reliability)*Math.random()));
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
								car4TopSpeed=<%=car4.getTopSpeed()%> * (1-((1-car4Reliability)*Math.random()));
								car4Acceleration=<%=car4.getAcceleration()%> * (1-((1-car4Reliability)*Math.random()));
							} else if (car4Lap==3){
								track4.className="tracklap3";
								car4TopSpeed=<%=car4.getTopSpeed()%> * (1-((1-car4Reliability)*Math.random()));
								car4Acceleration=<%=car4.getAcceleration()%> * (1-((1-car4Reliability)*Math.random()));
							} else if (car4Lap==4){
								track4.className="tracklap4";
								car4TopSpeed=<%=car4.getTopSpeed()%> * (1-((1-car4Reliability)*Math.random()));
								car4Acceleration=<%=car4.getAcceleration()%> * (1-((1-car4Reliability)*Math.random()));
							} else if (car4Lap==5){
								track4.className="tracklap5";
								car4TopSpeed=<%=car4.getTopSpeed()%> * (1-((1-car4Reliability)*Math.random()));
								car4Acceleration=<%=car4.getAcceleration()%> * (1-((1-car4Reliability)*Math.random()));
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
								car5TopSpeed=<%=car5.getTopSpeed()%> * (1-((1-car5Reliability)*Math.random()));
								car5Acceleration=<%=car5.getAcceleration()%> * (1-((1-car5Reliability)*Math.random()));
							} else if (car5Lap==3){
								track5.className="tracklap3";
								car5TopSpeed=<%=car5.getTopSpeed()%> * (1-((1-car5Reliability)*Math.random()));
								car5Acceleration=<%=car5.getAcceleration()%> * (1-((1-car5Reliability)*Math.random()));
							} else if (car5Lap==4){
								track5.className="tracklap4";
								car5TopSpeed=<%=car5.getTopSpeed()%> * (1-((1-car5Reliability)*Math.random()));
								car5Acceleration=<%=car5.getAcceleration()%> * (1-((1-car5Reliability)*Math.random()));
							} else if (car5Lap==5){
								track5.className="tracklap5";
								car5TopSpeed=<%=car5.getTopSpeed()%> * (1-((1-car5Reliability)*Math.random()));
								car5Acceleration=<%=car5.getAcceleration()%> * (1-((1-car5Reliability)*Math.random()));
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
								car6TopSpeed=<%=car6.getTopSpeed()%> * (1-((1-car6Reliability)*Math.random()));
								car6Acceleration=<%=car6.getAcceleration()%> * (1-((1-car6Reliability)*Math.random()));
							} else if (car6Lap==3){
								track6.className="tracklap3";
								car6TopSpeed=<%=car6.getTopSpeed()%> * (1-((1-car6Reliability)*Math.random()));
								car6Acceleration=<%=car6.getAcceleration()%> * (1-((1-car6Reliability)*Math.random()));
							} else if (car6Lap==4){
								track6.className="tracklap4";
								car6TopSpeed=<%=car6.getTopSpeed()%> * (1-((1-car6Reliability)*Math.random()));
								car6Acceleration=<%=car6.getAcceleration()%> * (1-((1-car6Reliability)*Math.random()));
							} else if (car6Lap==5){
								track6.className="tracklap5";
								car6TopSpeed=<%=car6.getTopSpeed()%> * (1-((1-car6Reliability)*Math.random()));
								car6Acceleration=<%=car6.getAcceleration()%> * (1-((1-car6Reliability)*Math.random()));
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
			<img class="car" id="car1" src="img/cars/<%=myCar.getModel()%>" width="100px" height="50px">
		<hr/>
	</div>
	<div class="tracklap1" id="track2">
		<hr/>
			<img class="car" id="car2" src="img/cars/<%=car2.getModel()%>" width="100px" height="50px">
		<hr/>
	</div>
	<div class="tracklap1" id="track3">
		<hr/>
			<img class="car" id="car3" src="img/cars/<%=car3.getModel()%>" width="100px" height="50px">
		<hr/>
	</div>
	<div class="tracklap1" id="track4">
		<hr/>
			<img class="car" id="car4" src="img/cars/<%=car4.getModel()%>" width="100px" height="50px">
		<hr/>
	</div>
	<div class="tracklap1" id="track5">
		<hr/>
			<img class="car" id="car5" src="img/cars/<%=car5.getModel()%>" width="100px" height="50px">
		<hr/>
	</div>
	<div class="tracklap1" id="track6">
		<hr/>
			<img class="car" id="car6" src="img/cars/<%=car6.getModel()%>" width="100px" height="50px">
		<hr/>
	</div>
	<button onclick="startRace()">Start Race!</button>
	<form method="POST" id="resultForm" action="racingResults.jsp">
		<input id="firstPlaceForm" type="hidden" name="firstPlace"/>
		<input id="firstPlaceTimeForm" type="hidden" name="firstPlaceTime"/>
		<input id="secondPlaceForm" type="hidden" name="secondPlace"/>
		<input id="secondPlaceTimeForm" type="hidden" name="secondPlaceTime"/>
		<input id="thirdPlaceForm" type="hidden" name="thirdPlace"/>
		<input id="thirdPlaceTimeForm" type="hidden" name="thirdPlaceTime"/>
	</form>
</body>
</html>