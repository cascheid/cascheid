angular.module('indexApp').factory('identityService', ['$http', '$q', '$uibModal', '$log', function($http, $q, $uibModal, $log){
	return {
		getIdentity : function(){
			var deferred = $q.defer();
			$http.get('getIdentity').then(
				function onSuccess(response) {
		        	deferred.resolve(response.data);
		        },
		        function onError(response) {
		        	$log.error('Error in identityService.getIdentity', response);
		        	deferred.reject(response);
		        }
			);
            return deferred.promise;
		},
		openLoadUserModal : function(){
			var deferred = $q.defer();
			$uibModal.open({
                animation: true,
                templateUrl: 'templates/loadUser.html',
                controller: function ($uibModalInstance) {
                	var modalVM = this;
                	modalVM.execute = function(){
            			var loadConfig =  {
            				params: {
            					username: modalVM.username,
            					password: modalVM.password
            				}
            			};
                		$http.get('loadUser', loadConfig).then(
                			function onSuccess(response){
                				$uibModalInstance.close(response.data);
                			},
                			function onError(response){
                				$log.error('Failed loadUser', response);
                				modalVM.resultMessage = response.data;
                			}
                		);
                	};
                	
                	modalVM.cancel = function(){
                		$uibModalInstance.dismiss();
                	};
                },
                controllerAs: 'modalCtrl'
            }).result.then(function(result){
            	deferred.resolve(result);
            });
			
			return deferred.promise;
		},
		openCreateUserModal : function(){
			var deferred = $q.defer();
			$uibModal.open({
                animation: true,
                templateUrl: 'templates/createUser.html',
                controller: function ($uibModalInstance) {
                	var modalVM = this;
                	modalVM.execute = function(){
            			var createConfig =  {
            				params: {
            					username: modalVM.username
            				}
            			};
                		$http.get('createUser', createConfig).then(
                			function onSuccess(response){
                				$uibModalInstance.close(response.data);
                			},
                			function onError(response){
                				$log.error('Failed saveUser', response);
                				modalVM.resultMessage = response.data;
                			}
                		);
                	};
                	
                	modalVM.cancel = function(){
                		$uibModalInstance.dismiss();
                	};
                },
                controllerAs: 'modalCtrl'
            }).result.then(function(result){
            	deferred.resolve(result);
            });
			
			return deferred.promise;
		},
		logout : function(){
			var deferred = $q.defer();
    		$http.get('logout').then(
    			function onSuccess(){
                	deferred.resolve(true);
    			},
    			function onError(response){
    				$log('Could not logout', response);
                	deferred.resolve(false);
    			}
    		);
			return deferred.promise;
		}
	}
}]); 