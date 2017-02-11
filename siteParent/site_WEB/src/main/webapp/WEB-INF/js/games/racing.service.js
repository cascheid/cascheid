angular.module('indexApp').factory('racingService', ['$http', '$q', '$uibModal', '$log', function($http, $q, $uibModal, $log){
	return {
		getRacingGame : function(){
			var deferred = $q.defer();
			$http.get('getRacingGame').then(
				function onSuccess(response){
			        deferred.resolve(response.data);
				},
				function onError(){
		        	$log.error('Error in racingService.getRacingGame', response);
		        	deferred.reject(response);
				}
			);
            return deferred.promise;
		}
	}
}]);
