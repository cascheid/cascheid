angular.module('indexApp', ['ui.bootstrap', 'ui.toggle', 'ngAnimate', 'ui.router']);

angular.module('indexApp').config(function($stateProvider, $urlRouterProvider) {
	var racingState = {
		name : 'racing',
		url : '/racing',
		templateUrl : 'views/racing.html',
		controller: 'racingCtrl as racing'
	};

	var snakeState = {
		name : 'snake',
		url : '/snake',
		templateUrl : 'snakeGame'
	};
	
	var racingStoreState = {
		name : 'racing.store',
		url : '/store',
		templateUrl : 'views/racingStore.html'
	}
	
	var racingUpgradeState = {
		name : 'racing.upgrades',
		url : '/upgrades',
		templateUrl : 'views/racingUpgrades.html'
	}
	$urlRouterProvider.otherwise('/');
	$stateProvider.state({
		name : 'gamesIndex',
		url : '/',
		templateUrl : 'gamesList.html'
	});
	$stateProvider.state(racingState);
	$stateProvider.state(snakeState);
	$stateProvider.state(racingStoreState);
	$stateProvider.state(racingUpgradeState);
});