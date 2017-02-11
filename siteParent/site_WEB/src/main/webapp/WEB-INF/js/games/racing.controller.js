angular.module('indexApp').controller('racingCtrl', ['$rootScope', '$window', 'racingService', function($rootScope, $window, racingService){
	var racingVM = this;

	$rootScope.$on('loadUser', function(e){
		racingVM.initController();
	});
	
	racingVM.initController = function(){
		racingVM.racingGame = undefined;
		racingService.getRacingGame().then(function onSuccess(data){
			racingVM.racingGame = data;
			racingVM.racingGame.purchaseableClasses=Object.keys(racingVM.racingGame.purchaseableCars);
		});
	};
	
	racingVM.selectStoreCar = function(car){
		racingVM.storeSelectedCar = car;
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
			return (classOrder(a) < classOrder(b) ? 1 : -1);
		});
		return filtered;
	}
});