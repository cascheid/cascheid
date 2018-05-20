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
		        	deferred.reject(response.data);
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
		        	deferred.reject(response.data);
				}
			);
            return deferred.promise;	
		},
		changeSelectedCar : function(carID){
			var deferred = $q.defer();
			$http.get('selectCar?carID='+carID).then(
				function onSuccess(response){
			        deferred.resolve(response.data);
				},
				function onError(response){
		        	$log.error('Error in racingService.purchaseCar', response);
		        	deferred.reject(response.data);
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
		        	deferred.reject(response.data);
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
		        	deferred.reject(response.data);
				}
			);
            return deferred.promise;	
		},
		startRace : function(raceSetup) {
			var deferred = $q.defer();
			var raceConfig = {
					params: {
						racingClass : raceSetup.racingClass,
						courseType : 'long',
						raceType : raceSetup.raceType,
						racingFee : 0,
						lapDistance : 0,
						noLaps : 0,
						carID : raceSetup.carID
					}
			}
			$http.get('startRace', raceConfig).then(
				function onSuccess(response){
			        deferred.resolve(response.data);
				},
				function onError(response){
		        	$log.error('Error in racingService.startRace', response);
		        	deferred.reject(response.data);
				}
			);
            return deferred.promise;
		},
		endRace : function(raceResult){
			var deferred = $q.defer();
			var resultConfig = {};
			resultConfig.params = raceResult;
			$http.post('racingResults', raceResult).then(
				function onSuccess(response){
					deferred.resolve(response.data);
				},
				function onError(response){
					$log.error('Error in racingService.endRace', response);
			        deferred.reject(response.data);
				}
			);
	        return deferred.promise;
		}
	}
}]);
