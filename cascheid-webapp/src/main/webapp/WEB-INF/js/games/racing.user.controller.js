angular.module('indexApp').controller('userRaceCtrl', ['$scope', '$window', '$interval', 'commonService', 'racingService', function ($scope, $window, $interval, commonService, racingService) {
	var userRace = this;
	
	$scope.$on('userRaceStart', function(e, data){
		userRace.startRace(data);
	});
	
	userRace.startRace = function(raceInfo) {
		userRace.raceInfo = raceInfo;
		userRace.raceResult = {
				racingClass: raceInfo.racingClass,
				raceType: raceInfo.raceType
		};
		
		var finishedRace = false;
		var distance = raceInfo.lapDistance * raceInfo.noLaps;
		
		var lapDistance = raceInfo.lapDistance;
		
		var elapsedTime = 0;
		var firstPlace = null;
		var secondPlace = null;
		var thirdPlace = null;
		var car1Accel = raceInfo.racer1.acceleration;
		var car2Accel = raceInfo.racer2.acceleration;
		var car3Accel = raceInfo.racer3.acceleration;
		var car4Accel = raceInfo.racer4.acceleration;
		var car5Accel = raceInfo.racer5.acceleration;
		var car6Accel = raceInfo.racer6.acceleration;
		var car1TopSpeed = raceInfo.racer1.topSpeed * (1 - ((1 - raceInfo.racer1.reliability) * Math.random()));
		var car2TopSpeed = raceInfo.racer2.topSpeed * (1 - ((1 - raceInfo.racer2.reliability) * Math.random()));
		var car3TopSpeed = raceInfo.racer3.topSpeed * (1 - ((1 - raceInfo.racer3.reliability) * Math.random()));
		var car4TopSpeed = raceInfo.racer4.topSpeed * (1 - ((1 - raceInfo.racer4.reliability) * Math.random()));
		var car5TopSpeed = raceInfo.racer5.topSpeed * (1 - ((1 - raceInfo.racer5.reliability) * Math.random()));
		var car6TopSpeed = raceInfo.racer6.topSpeed * (1 - ((1 - raceInfo.racer6.reliability) * Math.random()));
		userRace.car1lapEfficiency = raceInfo.racer1.lapEfficiency;
		userRace.car2lapEfficiency = raceInfo.racer2.lapEfficiency;
		userRace.car3lapEfficiency = raceInfo.racer3.lapEfficiency;
		userRace.car4lapEfficiency = raceInfo.racer4.lapEfficiency;
		userRace.car5lapEfficiency = raceInfo.racer5.lapEfficiency;
		userRace.car6lapEfficiency = raceInfo.racer6.lapEfficiency;
		
		var car1Location = 0;
		var car2Location = 0;
		var car3Location = 0;
		var car4Location = 0;
		var car5Location = 0;
		var car6Location = 0;

		userRace.car1lap = 1;
		userRace.car2lap = 1;
		userRace.car3lap = 1;
		userRace.car4lap = 1;
		userRace.car5lap = 1;
		userRace.car6lap = 1;

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
					if (userRace.raceResult.firstPlace == null) {
						userRace.raceResult.firstPlace = "user";
						userRace.raceResult.firstPlaceTime = elapsedTime;
					} else if (userRace.raceResult.secondPlace == null) {
						userRace.raceResult.secondPlace = "user";
						userRace.raceResult.secondPlaceTime = elapsedTime;
					} else if (userRace.raceResult.thirdPlace == null) {
						userRace.raceResult.thirdPlace = "user";
						userRace.raceResult.thirdPlaceTime = elapsedTime;
						finishedRace = true;
					}
				} else {
					angular.element('#car1').css('left', 100 * (car1Location % lapDistance) / lapDistance + "%");
					if (car1Location / lapDistance > userRace.car1lap) {
						userRace.car1lap += 1;
						car1CurVelocity = car1CurVelocity * userRace.car1lapEfficiency;
						car1TopSpeed = raceInfo.racer1.topSpeed * (1 - ((1 - raceInfo.racer1.reliability) * Math.random()));
						car1Acceleration = raceInfo.racer1.acceleration * (1 - ((1 - raceInfo.racer1.reliability) * Math.random()));
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
					if (userRace.raceResult.firstPlace == null) {
						userRace.raceResult.firstPlace = raceInfo.racer2.name;
						userRace.raceResult.firstPlaceTime = elapsedTime;
					} else if (userRace.raceResult.secondPlace == null) {
						userRace.raceResult.secondPlace = raceInfo.racer2.name;
						userRace.raceResult.secondPlaceTime = elapsedTime;
					} else if (userRace.raceResult.thirdPlace == null) {
						userRace.raceResult.thirdPlace = raceInfo.racer2.name;
						userRace.raceResult.thirdPlaceTime = elapsedTime;
						finishedRace = true;
					}
				} else {
					angular.element('#car2').css('left', 100 * (car2Location % lapDistance) / lapDistance + "%");
					if (car2Location / lapDistance > userRace.car2lap) {
						userRace.car2lap += 1;
						car2CurVelocity = car2CurVelocity * userRace.car2lapEfficiency;
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
					if (userRace.raceResult.firstPlace == null) {
						userRace.raceResult.firstPlace = raceInfo.racer3.name;
						userRace.raceResult.firstPlaceTime = elapsedTime;
					} else if (userRace.raceResult.secondPlace == null) {
						userRace.raceResult.secondPlace = raceInfo.racer3.name;
						userRace.raceResult.secondPlaceTime = elapsedTime;
					} else if (userRace.raceResult.thirdPlace == null) {
						userRace.raceResult.thirdPlace = raceInfo.racer3.name;
						userRace.raceResult.thirdPlaceTime = elapsedTime;
						finishedRace = true;
					}
				} else {
					angular.element('#car3').css('left', 100 * (car3Location % lapDistance) / lapDistance + "%");
					if (car3Location / lapDistance > userRace.car3lap) {
						userRace.car3lap += 1;
						car3CurVelocity = car3CurVelocity * userRace.car3lapEfficiency;
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
					if (userRace.raceResult.firstPlace == null) {
						userRace.raceResult.firstPlace = raceInfo.racer4.name;
						userRace.raceResult.firstPlaceTime = elapsedTime;
					} else if (userRace.raceResult.secondPlace == null) {
						userRace.raceResult.secondPlace = raceInfo.racer4.name;
						userRace.raceResult.secondPlaceTime = elapsedTime;
					} else if (userRace.raceResult.thirdPlace == null) {
						userRace.raceResult.thirdPlace = raceInfo.racer4.name;
						userRace.raceResult.thirdPlaceTime = elapsedTime;
						finishedRace = true;
					}
				} else {
					angular.element('#car4').css('left', 100 * (car4Location % lapDistance) / lapDistance + "%");
					if (car4Location / lapDistance > userRace.car4lap) {
						userRace.car4lap += 1;
						car4CurVelocity = car4CurVelocity * userRace.car4lapEfficiency;
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
					if (userRace.raceResult.firstPlace == null) {
						userRace.raceResult.firstPlace = raceInfo.racer5.name;
						userRace.raceResult.firstPlaceTime = elapsedTime;
					} else if (userRace.raceResult.secondPlace == null) {
						userRace.raceResult.secondPlace = raceInfo.racer5.name;
						userRace.raceResult.secondPlaceTime = elapsedTime;
					} else if (userRace.raceResult.thirdPlace == null) {
						userRace.raceResult.thirdPlace = raceInfo.racer5.name;
						userRace.raceResult.thirdPlaceTime = elapsedTime;
						finishedRace = true;
					}
				} else {
					angular.element('#car5').css('left', 100 * (car5Location % lapDistance) / lapDistance + "%");
					if (car5Location / lapDistance > userRace.car5lap) {
						userRace.car5lap += 1;
						car5CurVelocity = car5CurVelocity * userRace.car5lapEfficiency;
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
					if (userRace.raceResult.firstPlace == null) {
						userRace.raceResult.firstPlace = raceInfo.racer6.name;
						userRace.raceResult.firstPlaceTime = elapsedTime;
					} else if (userRace.raceResult.secondPlace == null) {
						userRace.raceResult.secondPlace = raceInfo.racer6.name;
						userRace.raceResult.secondPlaceTime = elapsedTime;
					} else if (userRace.raceResult.thirdPlace == null) {
						userRace.raceResult.thirdPlace = raceInfo.racer6.name;
						userRace.raceResult.thirdPlaceTime = elapsedTime;
						finishedRace = true;
					}
				} else {
					angular.element('#car6').css('left', 100 * (car6Location % lapDistance) / lapDistance + "%");
					if (car6Location / lapDistance > userRace.car6lap) {
						userRace.car6lap += 1;
						car6CurVelocity = car6CurVelocity * userRace.car6lapEfficiency;
						car6TopSpeed = raceInfo.racer6.topSpeed * (1 - ((1 - raceInfo.racer6.reliability) * Math.random()));
						car6Acceleration = raceInfo.racer6.acceleration * (1 - ((1 - raceInfo.racer6.reliability) * Math.random()));
					}
				}
			}

			if (finishedRace) {
				$interval.cancel(raceid);
				racingService.endRace(userRace.raceResult).then(function(data){
					userRace.ended = true;
					userRace.raceResult = data;
					$scope.$emit('updateRacingGame');
				});
			}
		}

		var raceid = $interval(moveAllCars, 10);
	}
}]);