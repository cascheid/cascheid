angular.module('indexApp').controller('gamesCtrl', ['$rootScope', '$window', 'commonService', 'identityService', function($rootScope, $window, commonService, identityService){
	var gamesVM = this;
	gamesVM.loadUser = function(){
		identityService.openLoadUserModal().then(function(data){
			$rootScope.username=data.username;
			$rootScope.$broadcast('loadUser');
		});
	};
	
	gamesVM.createUser = function(){
		identityService.openCreateUserModal().then(function(data){
			$rootScope.username=data.username;
		});
	};
	
	gamesVM.signout = function(){
		commonService.openConfirmModal('Sign Out', 'Are you sure you would like to sign out?').then(
			function(confirmed){
				if (confirmed){
					identityService.logout().then(function(loggedOut){
						if (loggedOut){
							$rootScope.username = null;
						}
					});
				}
			}
		);
	};
	
}]);