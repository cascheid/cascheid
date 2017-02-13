angular.module('indexApp').controller('racingCtrl', ['$rootScope', '$window', 'commonService', 'racingService', function($rootScope, $window, commonService, racingService){
	var racingVM = this;

	$rootScope.$on('loadUser', function(e){
		racingVM.initController();
	});
	
	racingVM.initController = function(){
		racingVM.racingGame = undefined;
		racingService.getRacingGame().then(function onSuccess(data){
			racingVM.racingGame = data;
			racingVM.racingGame.purchaseableClasses=Object.keys(racingVM.racingGame.purchaseableCars);
			racingVM.initUpgradeFrame();
		});
	};
	
	racingVM.purchaseCar = function(car){
		commonService.openConfirmModal('Purchase Car', 'Are you sure you would like to purchase this car?').then(function(result){
			if (result){
				racingService.purchaseCar(car.carID).then(
					function onSuccess(data){
						racingVM.racingGame = data;
						racingVM.racingGame.purchaseableClasses=Object.keys(racingVM.racingGame.purchaseableCars);
					}
				);
			}
		});
	};
	
	racingVM.initUpgradeFrame = function() {
		racingVM.selectedUpgrade = null;
		racingService.getUpgradeList(racingVM.racingGame.selectedCar.racingClass).then(function(data){
			racingVM.purchaseableUpgrades = data;
		});
	};
	
	$rootScope.$on('loadRacingUpgrade', function(e){
		racingVM.initUpgradeFrame();
	});
	
	racingVM.purchaseUpgrade = function() {
		var price = racingVM.selectedUpgrade.price;
		racingService.purchaseUpgrade(racingVM.selectedUpgrade.upgradeID).then(function(data){
			racingVM.racingGame.selectedCar = data;
			racingVM.racingGame.availableCash -= price;
		});
	}
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