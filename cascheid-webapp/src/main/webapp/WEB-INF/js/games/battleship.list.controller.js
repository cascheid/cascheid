angular.module('indexApp').controller('battleshipListCtrl', ['$rootScope', '$window', '$state', 'commonService', 'battleshipService', function($rootScope, $window, $state, commonService, battleshipService){
	var listVM = this;
	
	listVM.init = function(){
		listVM.activeGames=undefined;
		battleshipService.getActiveGames().then(function(data){
			listVM.activeGames = data;
		});
	};
	
	listVM.createGame = function(){
		listVM.createGameError = undefined;
		if (!listVM.oppName){
			listVM.createGameError = { resultMessage: "Enter name of opponent to play.", error: "true" };
		} else {
			battleshipService.createBattleshipGame(listVM.oppName).then(function success(){
				$state.go("battleshipCreate");
			}, function error(data){
				listVM.createGameError = { resultMessage: "Invalid Opponent Name.", error: "true" };
			});
		}
	}
	
	listVM.loadGame = function(game){
		battleshipService.loadGame(game).then(function success(data){
			$state.go("battleship");
		});
	};
	if ($rootScope.identity && $rootScope.identity.username){
		//if not logged in, no need to make the call
		listVM.init();
	}
}]);