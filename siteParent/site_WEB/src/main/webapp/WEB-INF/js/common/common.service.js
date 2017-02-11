angular.module('indexApp').factory('commonService', ['$http', '$q', '$uibModal', '$log', function($http, $q, $uibModal, $log){
	return {
		openConfirmModal : function (title, message){
			var deferred = $q.defer();
			$uibModal.open({
                animation: true,
                templateUrl: 'templates/confirm.html',
                controller: function ($uibModalInstance, title, message) {
                	var modalVM = this;
                	modalVM.title = title;
                	modalVM.message = message;
                	
                	modalVM.ok = function(){
        				$uibModalInstance.close(true);
                	};
                	modalVM.cancel = function(){
        				$uibModalInstance.close(false);
                	};
                },
                controllerAs: 'modalCtrl',
                resolve: {
                	title: function(){
                		return title;
                	},
                	message: function(){
                		return message;
                	}
                }
            }).result.then(function(result){
            	deferred.resolve(result);
            });
			return deferred.promise;
		}
	}
}]);