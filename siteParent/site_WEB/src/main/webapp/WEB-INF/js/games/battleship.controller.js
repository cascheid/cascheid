angular.module('indexApp').controller('battleshipCtrl', ['$scope', '$window', '$state', 'commonService', 'racingService', function($scope, $window, $state, commonService, racingService){
	var battleshipVM = this;
	
	battleshipVM.init = function(){
		battleshipVM.activeGames=undefined;
		battleshipService.getActiveGames().then(function(data){
			battleshipVM.activeGames = data;
		});
	};
	
	battleshipVM.createGame = function(){
		if (!battleshipVM.oppName){
			battleshipVM.createGameError = { resultMessage: "Enter name of opponent to play.", error: "true" };
		} else {
			battleshipService.createGame(battleshipVM.oppName).then(function success(){
				$state.go("battleshipCreate");
			}, function error(data){
				battleshipVM.createGameError = data;
			});
		}
	}
	
	battleshipVM.loadGame = function(game){
		battleshipService.loadGame(game).then(function success(data){
			$state.go("battleship");
		});
	};
}]);