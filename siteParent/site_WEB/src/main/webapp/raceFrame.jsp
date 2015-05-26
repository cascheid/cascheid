<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="site.racinggame.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="racing.css">
</head>
<body>
	<jsp:useBean id="racingGame" class="site.racinggame.RacingGame" scope="session"/>
	<% Integer raceDistance=5000;%>
	<% out.println("identifier: " + racingGame.getRacingIdentifier()); %>
	<% out.println("car ID: " + racingGame.getCarID()); %>
	<% Racecar myCar=RacingGameUtils.getRacecarByID(racingGame.getCarID()); %>
	<% Racecar car2=RacingGameUtils.getRandomOponentByClass(racingGame.getRacingClass());%>
	<% Racecar car3=RacingGameUtils.getRandomOponentByClass(racingGame.getRacingClass());%>
	<% Racecar car4=RacingGameUtils.getRandomOponentByClass(racingGame.getRacingClass());%>
	<% Racecar car5=RacingGameUtils.getRandomOponentByClass(racingGame.getRacingClass());%>
	<% Racecar car6=RacingGameUtils.getRandomOponentByClass(racingGame.getRacingClass());%>
	
	<script>
		var finishedRace=false;
		function startRace(){
			var distance=<%=raceDistance%>;
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
			var car1TopSpeed=<%=myCar.getTopSpeed()%>;
			var car2TopSpeed=<%=car2.getTopSpeed()%>;
			var car3TopSpeed=<%=car3.getTopSpeed()%>;
			var car4TopSpeed=<%=car4.getTopSpeed()%>;
			var car5TopSpeed=<%=car5.getTopSpeed()%>;
			var car6TopSpeed=<%=car6.getTopSpeed()%>;

			var car1Location=0;
			var car2Location=0;
			var car3Location=0;
			var car4Location=0;
			var car5Location=0;
			var car6Location=0;
			
			function moveAllCars(){
				elapsedTime += .1;
				if (car1Location < distance) {
					var car1CurVelocity = elapsedTime * car1Accel / 2;//not exact, but close enough
					if (car1CurVelocity > car1TopSpeed) {
						car1Location = car1Location + car1TopSpeed * .1;
					} else {
						car1Location = elapsedTime * elapsedTime * car1Accel / 2;
					}
					car1.style.left = car1Location/distance*400+"px";
					if (car1Location >= distance) {
						if (firstPlace == null) {
							firstPlace = "car1 "+elapsedTime;
						} else if (secondPlace == null) {
							secondPlace = "car1 "+elapsedTime;
						} else if (thirdPlace == null) {
							thirdPlace = "car1 "+elapsedTime;
							finishedRace = true;
						}
					}
				}
				
				if (car2Location < distance) {
					var car2CurVelocity = elapsedTime * car2Accel / 2;//not exact, but close enough
					if (car2CurVelocity > car2TopSpeed) {
						car2Location = car2Location + car2TopSpeed * .1;
					} else {
						car2Location = elapsedTime * elapsedTime * car2Accel / 2;
					}
					car2.style.left = car2Location/distance*400+"px";
					if (car2Location >= distance) {
						if (firstPlace == null) {
							firstPlace = "car2 "+elapsedTime;
						} else if (secondPlace == null) {
							secondPlace = "car2 "+elapsedTime;
						} else if (thirdPlace == null) {
							thirdPlace = "car2 "+elapsedTime;
							finishedRace = true;
						}
					}
				}
				
				if (car3Location < distance) {
					var car3CurVelocity = elapsedTime * car3Accel / 2;//not exact, but close enough
					if (car3CurVelocity > car3TopSpeed) {
						car3Location = car3Location + car3TopSpeed * .1;
					} else {
						car3Location = elapsedTime * elapsedTime * car3Accel / 2;
					}
					car3.style.left = car3Location/distance*400+"px";
					if (car3Location >= distance) {
						if (firstPlace == null) {
							firstPlace = "car3 "+elapsedTime;
						} else if (secondPlace == null) {
							secondPlace = "car3 "+elapsedTime;
						} else if (thirdPlace == null) {
							thirdPlace = "car3 "+elapsedTime;
							finishedRace = true;
						}
					}
				}

				if (finishedRace) {
					clearInterval(raceid);
					window.alert("First: " + firstPlace + "\nSecond: "
							+ secondPlace + "\nThird: " + thirdPlace);
				}
			}

			var raceid = setInterval(moveAllCars, 10);

		}
	</script>
	
	<div class="track" id="track1">
		<hr/>
			<img class="car" id="car1" src="img/cars/<%=myCar.getModel()%>.png" width="100px" height="50px">
		<hr/>
	</div>
	<div class="trackalt" id="track2"></div>
		<hr/>
			<img class="car" id="car2" src="img/cars/<%=car2.getModel()%>.png" width="100px" height="50px">
		<hr/>
	<div class="track" id="track3">
		<hr/>
			<img class="car" id="car3" src="img/cars/<%=car3.getModel()%>.png" width="100px" height="50px">
		<hr/>
	</div>
	<div class="trackalt" id="track4">
		<hr/>
			<img class="car" id="car4" src="img/cars/<%=car4.getModel()%>.png" width="100px" height="50px">
		<hr/>
	</div>
	<div class="track" id="track5">
		<hr/>
			<img class="car" id="car5" src="img/cars/<%=car5.getModel()%>.png" width="100px" height="50px">
		<hr/>
	</div>
	<div class="trackalt" id="track6">
		<hr/>
			<img class="car" id="car6" src="img/cars/<%=car6.getModel()%>.png" width="100px" height="50px">
		<hr/>
	</div>
	<button onclick="startRace()">Start Race!</button>
</body>
</html>