angular.module('indexApp').factory('racingService', ['$http', '$q', '$uibModal', '$log', function($http, $q, $uibModal, $log){
	return {
		getRacingGame : function(){
			var deferred = $q.defer();
			$http.get('getRacingGame').then(
				function onSuccess(response){
			        deferred.resolve(response.data);
				},
				function onError(response){
		        	$log.error('Error in racingService.getRacingGame', response);
		        	deferred.reject(response);
				}
			);
            return deferred.promise;
		},
		purchaseCar : function(carID) {
			var deferred = $q.defer();
			$http.get('purchaseCar?carID='+carID).then(
				function onSuccess(response){
			        deferred.resolve(response.data);
				},
				function onError(response){
		        	$log.error('Error in racingService.purchaseCar', response);
		        	deferred.reject(response);
				}
			);
            return deferred.promise;	
		},
		getUpgradeList : function (racingClass){
			var deferred = $q.defer();
			$http.get('getUpgrades?racingClass='+racingClass).then(
				function onSuccess(response){
			        deferred.resolve(response.data);
				},
				function onError(response){
		        	$log.error('Error in racingService.getUpgradeList', response);
		        	deferred.reject(response);
				}
			);
            return deferred.promise;
		},
		purchaseUpgrade : function(upgradeID) {
			var deferred = $q.defer();
			$http.get('purchaseUpgrade?upgradeID='+upgradeID).then(
				function onSuccess(response){
			        deferred.resolve(response.data);
				},
				function onError(response){
		        	$log.error('Error in racingService.purchaseUpgrade', response);
		        	deferred.reject(response);
				}
			);
            return deferred.promise;	
		}
	}
}]);
