angular.module('indexApp').controller('battleshipListCtrl', ['$scope', '$window', '$state', 'commonService', 'battleshipService', function($scope, $window, $state, commonService, battleshipService){
	var listVM = this;
	
	listVM.init = function(){
		listVM.activeGames=undefined;
		battleshipService.getActiveGames().then(function(data){
			listVM.activeGames = data;
		});
	};
	
	listVM.createGame = function(){
		if (!listVM.oppName){
			listVM.createGameError = { resultMessage: "Enter name of opponent to play.", error: "true" };
		} else {
			battleshipService.createGame(listVM.oppName).then(function success(){
				$state.go("battleshipCreate");
			}, function error(data){
				listVM.createGameError = data;
			});
		}
	}
	
	listVM.loadGame = function(game){
		battleshipService.loadGame(game).then(function success(data){
			$state.go("battleship");
		});
	};
	
	listVM.init();
}]);