angular.module('indexApp').controller('racingCtrl', ['$scope', '$window', '$state', 'commonService', 'racingService', function($scope, $window, $state, commonService, racingService){
	var racingVM = this;

	$scope.$on('loadUser', function(e){
		racingVM.racingGame = undefined;
		racingVM.initController();
	});
	
	$scope.$on('updateRacingGame', function(e){
		racingVM.initController();
	});
	
	racingVM.initController = function(){
		racingService.getRacingGame().then(function onSuccess(data){
			racingVM.racingGame = data;
			racingVM.racingGame.raceableClasses=['E'];
			if (['D','C','B','A','S','SS'].indexOf(racingVM.racingGame.racingClass)>=0){
				racingVM.racingGame.raceableClasses.push('D');
			}
			if (['C','B','A','S','SS'].indexOf(racingVM.racingGame.racingClass)>=0){
				racingVM.racingGame.raceableClasses.push('C');
			}
			if (['B','A','S','SS'].indexOf(racingVM.racingGame.racingClass)>=0){
				racingVM.racingGame.raceableClasses.push('B');
			}
			if (['A','S','SS'].indexOf(racingVM.racingGame.racingClass)>=0){
				racingVM.racingGame.raceableClasses.push('A');
			}
			if (['S','SS'].indexOf(racingVM.racingGame.racingClass)>=0){
				racingVM.racingGame.raceableClasses.push('S');
			}
			racingVM.initUpgradeFrame();
			racingVM.initGarageFrame();
			racingVM.raceSetup = {
					raceType: 'user',
					racingClass: racingVM.racingGame.racingClass,
					carID: racingVM.racingGame.selectedCar.carID
			}
		});
		
		racingService.getRacingFees().then(function onSuccess(response){
			racingVM.feeMap = response.data;
		});
	};
	
	racingVM.purchaseCar = function(car){
		commonService.openConfirmModal('Purchase Car', 'Are you sure you would like to purchase this car?').then(function(result){
			if (result){
				racingService.purchaseCar(car.carID).then(
					function onSuccess(data){
						racingVM.racingGame = data;
						racingVM.racingGame.purchaseableClasses=Object.keys(racingVM.racingGame.purchaseableCars);
					},
					commonService.alertError
				);
			}
		});
	};
	
	racingVM.initUpgradeFrame = function() {
		racingVM.selectedUpgrade = null;
		racingService.getUpgradeList(racingVM.racingGame.selectedCar.racingClass).then(
			function(data){
				racingVM.purchaseableUpgrades = data;
			},
			commonService.alertError
		);
	};
	
	racingVM.initGarageFrame = function() {
		angular.forEach(racingVM.racingGame.carList, function(car){
			if (car.carID==racingVM.racingGame.selectedCar.carID){
				racingVM.garageCar=car;
			}
		});
	};
	
	racingVM.changeSelectedCar = function() {
		racingVM.racingGame.selectedCar=racingVM.garageCar;
		racingService.changeSelectedCar(racingVM.racingGame.selectedCar.carID);
	};
	
	$scope.$on('loadRacingUpgrade', function(e){
		racingVM.initUpgradeFrame();
	});
	
	$scope.$on('loadRacingGarage', function(e){
		racingVM.initGarageFrame();
	});
	
	racingVM.purchaseUpgrade = function() {
		var price = racingVM.selectedUpgrade.price;
		commonService.openConfirmModal('Purchase Upgrade', 'Are you sure you would like to purchase this upgrade for '+price+'?').then(function(result){
			if (result){
				racingService.purchaseUpgrade(racingVM.selectedUpgrade.upgradeID).then(
					function(data){
						racingVM.racingGame.selectedCar = data;
						racingVM.racingGame.availableCash -= price;
						racingVM.initUpgradeFrame();
					},
					commonService.alertError
				);
			}
		});
	};
	
	racingVM.submitRaceSetup = function(){
		racingService.startRace(racingVM.raceSetup).then(function(data){
			if (data.raceType==='user'){
				$scope.$broadcast('userRaceStart', data);
			} else if (data.raceType==='spectate'){
				$scope.$broadcast('spectateRaceStart', data);
			}
		});
		if (racingVM.raceSetup.raceType==='user'){
			$state.go('racing.userRace');
		} else if (racingVM.raceSetup.raceType==='spectate'){
			$state.go('racing.spectateRace');
		}
	};
	
	racingVM.initController();
}]);

angular.module('indexApp').filter('racingClassSorter', function(){
	function classOrder(item){
		if (item=="S"){
			return "";
		} else {
			return item;
		}
	}
	
	return function(items, field){
		var filtered = [];
		angular.forEach(items, function(item) {
			filtered.push(item);
		});
		filtered.sort(function(a, b) {
			return (classOrder(a) > classOrder(b) ? 1 : -1);
		});
		return filtered;
	}
});