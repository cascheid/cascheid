angular.module('indexApp').factory('battleshipService', ['$http', '$q', '$uibModal', '$log', function($http, $q, $uibModal, $log){
		return {
			getActiveGames : function(){
				var deferred = $q.defer();
				$http.get('getBattleshipGames').then(
					function onSuccess(response){
				        deferred.resolve(response.data);
					},
					function onError(response){
			        	$log.error('Error in battleshipService.getActiveGames', response);
			        	deferred.reject(response.data);
					}
				);
	            return deferred.promise;
			},
			createBattleshipGame: function(oppName){
				return $http.get('createBattleshipGame?oppName='+oppName);
			}
		}
}]);