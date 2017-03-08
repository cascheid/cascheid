angular.module('indexApp').controller('racingCtrl', ['$rootScope', '$window', 'commonService', 'racingService', 'raceInfo', function ($rootScope, $window, commonService, racingService, raceInfo) {
	var finishedRace = false;
	function startRace() {
		var distance = raceInfo.lapDistance * raceInfo.noLaps;
		
		var lapDistance = raceInfo.lapDistance;
		
		var elapsedTime = 0;
		var firstPlace = null;
		var secondPlace = null;
		var thirdPlace = null;
		var car1Accel = raceInfo.racecar.acceleration;
		var car2Accel = raceInfo.racer2.acceleration;
		var car3Accel = raceInfo.racer3.acceleration;
		var car4Accel = raceInfo.racer4.acceleration;
		var car5Accel = raceInfo.racer5.acceleration;
		var car6Accel = raceInfo.racer6.acceleration;
		var car1TopSpeed = raceInfo.racecar.topSpeed * (1 - ((1 - racecar.reliability) * Math.random()));
		var car2TopSpeed = raceInfo.racer2.topSpeed * (1 - ((1 - racer2.reliability) * Math.random()));
		var car3TopSpeed = raceInfo.racer3.topSpeed * (1 - ((1 - racer3.reliability) * Math.random()));
		var car4TopSpeed = raceInfo.racer4.topSpeed * (1 - ((1 - racer4.reliability) * Math.random()));
		var car5TopSpeed = raceInfo.racer5.topSpeed * (1 - ((1 - racer5.reliability) * Math.random()));
		var car6TopSpeed = raceInfo.racer6.topSpeed * (1 - ((1 - racer6.reliability) * Math.random()));
		var car1LapEfficiency = raceInfo.racecar.lapEfficiency;
		var car2LapEfficiency = raceInfo.racer2.lapEfficiency;
		var car3LapEfficiency = raceInfo.racer3.lapEfficiency;
		var car4LapEfficiency = raceInfo.racer4.lapEfficiency;
		var car5LapEfficiency = raceInfo.racer5.lapEfficiency;
		var car6LapEfficiency = raceInfo.racer6.lapEfficiency;
		
		var car1Location = 0;
		var car2Location = 0;
		var car3Location = 0;
		var car4Location = 0;
		var car5Location = 0;
		var car6Location = 0;

		var car1Lap = 1;
		var car2Lap = 1;
		var car3Lap = 1;
		var car4Lap = 1;
		var car5Lap = 1;
		var car6Lap = 1;

		var car1CurVelocity = 0;
		var car2CurVelocity = 0;
		var car3CurVelocity = 0;
		var car4CurVelocity = 0;
		var car5CurVelocity = 0;
		var car6CurVelocity = 0;

		function moveAllCars() {
			elapsedTime += .01;
			if (car1Location < distance) {
				car1CurVelocity = car1CurVelocity + 0.01 * car1Accel;// not exact, but close enough
				if (car1CurVelocity > car1TopSpeed) {
					car1CurVelocity = car1TopSpeed;
				}
				car1Location = car1Location + car1CurVelocity * .01;

				if (car1Location >= distance) {
					if (firstPlace == null) {
						firstPlace = "user";
						document.getElementById("firstPlaceTimeForm").value = elapsedTime;
					} else if (secondPlace == null) {
						secondPlace = "user";
						document.getElementById("secondPlaceTimeForm").value = elapsedTime;
					} else if (thirdPlace == null) {
						thirdPlace = "user";
						document.getElementById("thirdPlaceTimeForm").value = elapsedTime;
						finishedRace = true;
					}
				} else {
					car1.style.left = 100 * (car1Location % lapDistance)
							/ lapDistance + "%";
					if (car1Location / lapDistance > car1Lap) {
						car1Lap += 1;
						car1CurVelocity = car1CurVelocity * car1LapEfficiency;
						track1.className = "tracklap" + car1Lap;
						car1TopSpeed = raceInfo.racecar.topSpeed * (1 - ((1 - raceInfo.racecar.reliability) * Math.random()));
						car1Acceleration = raceInfo.racecar.acceleration * (1 - ((1 - raceInfo.racecar.reliability) * Math.random()));
					}
				}
			}

			if (car2Location < distance) {
				car2CurVelocity = car2CurVelocity + 0.01 * car2Accel;
				if (car2CurVelocity > car2TopSpeed) {
					car2CurVelocity = car2TopSpeed;
				}
				car2Location = car2Location + car2CurVelocity * .01;

				if (car2Location >= distance) {
					if (firstPlace == null) {
						firstPlace = raceInfo.racer2.name;
						document.getElementById("firstPlaceTimeForm").value = elapsedTime;
					} else if (secondPlace == null) {
						secondPlace = raceInfo.racer2.name;
						document.getElementById("secondPlaceTimeForm").value = elapsedTime;
					} else if (thirdPlace == null) {
						thirdPlace = raceInfo.racer2.name;
						document.getElementById("thirdPlaceTimeForm").value = elapsedTime;
						finishedRace = true;
					}
				} else {
					car2.style.left = 100 * (car2Location % lapDistance)
							/ lapDistance + "%";
					if (car2Location / lapDistance > car2Lap) {
						car2Lap += 1;
						car2CurVelocity = car2CurVelocity * car2LapEfficiency;
						track2.className = "tracklap" + car2Lap;
						car2TopSpeed = raceInfo.racer2.topSpeed * (1 - ((1 - raceInfo.racer2.reliability) * Math.random()));
						car2Acceleration = raceInfo.racer2.acceleration * (1 - ((1 - raceInfo.racer2.reliability) * Math.random()));
					}
				}
			}

			if (car3Location < distance) {
				car3CurVelocity = car3CurVelocity + 0.01 * car3Accel;
				if (car3CurVelocity > car3TopSpeed) {
					car3CurVelocity = car3TopSpeed;
				}
				car3Location = car3Location + car3CurVelocity * .01;

				if (car3Location >= distance) {
					if (firstPlace == null) {
						firstPlace = raceInfo.racer3.name;
						document.getElementById("firstPlaceTimeForm").value = elapsedTime;
					} else if (secondPlace == null) {
						secondPlace = raceInfo.racer3.name;
						document.getElementById("secondPlaceTimeForm").value = elapsedTime;
					} else if (thirdPlace == null) {
						thirdPlace = raceInfo.racer3.name;
						document.getElementById("thirdPlaceTimeForm").value = elapsedTime;
						finishedRace = true;
					}
				} else {
					car3.style.left = 100 * (car3Location % lapDistance)
							/ lapDistance + "%";
					if (car3Location / lapDistance > car3Lap) {
						car3Lap += 1;
						car3CurVelocity = car3CurVelocity * car3LapEfficiency;
						track3.className = "tracklap" + car3Lap;
						car3TopSpeed = raceInfo.racer3.topSpeed * (1 - ((1 - raceInfo.racer3.reliability) * Math.random()));
						car3Acceleration = raceInfo.racer3.acceleration * (1 - ((1 - raceInfo.racer3.reliability) * Math.random()));
					}
				}
			}

			if (car4Location < distance) {
				car4CurVelocity = car4CurVelocity + 0.01 * car4Accel;
				if (car4CurVelocity > car4TopSpeed) {
					car4CurVelocity = car4TopSpeed;
				}
				car4Location = car4Location + car4CurVelocity * .01;

				if (car4Location >= distance) {
					if (firstPlace == null) {
						firstPlace = raceInfo.racer4.name;
						document.getElementById("firstPlaceTimeForm").value = elapsedTime;
					} else if (secondPlace == null) {
						secondPlace = raceInfo.racer4.name;
						document.getElementById("secondPlaceTimeForm").value = elapsedTime;
					} else if (thirdPlace == null) {
						thirdPlace = raceInfo.racer4.name;
						document.getElementById("thirdPlaceTimeForm").value = elapsedTime;
						finishedRace = true;
					}
				} else {
					car4.style.left = 100 * (car4Location % lapDistance)
							/ lapDistance + "%";
					if (car4Location / lapDistance > car4Lap) {
						car4Lap += 1;
						car4CurVelocity = car4CurVelocity * car4LapEfficiency;
						track4.className = "tracklap" + car4Lap;
						car4TopSpeed = raceInfo.racer4.topSpeed * (1 - ((1 - raceInfo.racer4.reliability) * Math.random()));
						car4Acceleration = raceInfo.racer4.acceleration * (1 - ((1 - raceInfo.racer4.reliability) * Math.random()));
					}
				}
			}

			if (car5Location < distance) {
				car5CurVelocity = car5CurVelocity + 0.01 * car5Accel;
				if (car5CurVelocity > car5TopSpeed) {
					car5CurVelocity = car5TopSpeed;
				}
				car5Location = car5Location + car5CurVelocity * .01;

				if (car5Location >= distance) {
					if (firstPlace == null) {
						firstPlace = raceInfo.racer5.name;
						document.getElementById("firstPlaceTimeForm").value = elapsedTime;
					} else if (secondPlace == null) {
						secondPlace = raceInfo.racer5.name;
						document.getElementById("secondPlaceTimeForm").value = elapsedTime;
					} else if (thirdPlace == null) {
						thirdPlace = raceInfo.racer5.name;
						document.getElementById("thirdPlaceTimeForm").value = elapsedTime;
						finishedRace = true;
					}
				} else {
					car5.style.left = 100 * (car5Location % lapDistance)
							/ lapDistance + "%";
					if (car5Location / lapDistance > car5Lap) {
						car5Lap += 1;
						car5CurVelocity = car5CurVelocity * car5LapEfficiency;
						track5.className = "tracklap" + car5Lap;
						car5TopSpeed = raceInfo.racer5.topSpeed * (1 - ((1 - raceInfo.racer5.reliability) * Math.random()));
						car5Acceleration = raceInfo.racer5.acceleration * (1 - ((1 - raceInfo.racer5.reliability) * Math.random()));
					}
				}
			}

			if (car6Location < distance) {
				car6CurVelocity = car6CurVelocity + 0.01 * car6Accel;
				if (car6CurVelocity > car6TopSpeed) {
					car6CurVelocity = car6TopSpeed;
				}
				car6Location = car6Location + car6CurVelocity * .01;

				if (car6Location >= distance) {
					if (firstPlace == null) {
						firstPlace = raceInfo.racer6.name;
						document.getElementById("firstPlaceTimeForm").value = elapsedTime;
					} else if (secondPlace == null) {
						secondPlace = raceInfo.racer6.name;
						document.getElementById("secondPlaceTimeForm").value = elapsedTime;
					} else if (thirdPlace == null) {
						thirdPlace = raceInfo.racer6.name;
						document.getElementById("thirdPlaceTimeForm").value = elapsedTime;
						finishedRace = true;
					}
				} else {
					car6.style.left = 100 * (car6Location % lapDistance)
							/ lapDistance + "%";
					if (car6Location / lapDistance > car6Lap) {
						car6Lap += 1;
						car6CurVelocity = car6CurVelocity * car6LapEfficiency;
						track6.className = "tracklap" + car6Lap;
						car6TopSpeed = raceInfo.racer6.topSpeed * (1 - ((1 - raceInfo.racer6.reliability) * Math.random()));
						car6Acceleration = raceInfo.racer6.acceleration * (1 - ((1 - raceInfo.racer6.reliability) * Math.random()));
					}
				}
			}

			if (finishedRace) {
				clearInterval(raceid);
				document.getElementById("firstPlaceForm").value = firstPlace;
				document.getElementById("secondPlaceForm").value = secondPlace;
				document.getElementById("thirdPlaceForm").value = thirdPlace;
				resultForm.submit();
			}
		}

		var raceid = setInterval(moveAllCars, 10);
	}
}]);