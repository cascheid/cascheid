angular.module('indexApp', ['ui.bootstrap', 'ui.toggle', 'ngAnimate', 'ui.router', 'ngMaterial']);

angular.module('indexApp').config(function($stateProvider, $urlRouterProvider) {
	var racingState = {
		name : 'racing',
		url : '/racing',
		templateUrl : 'views/racing/racing.html',
		controller: 'racingCtrl as racing'
	};
	
	var racingStoreState = {
		name : 'racing.store',
		url : '/store',
		templateUrl : 'views/racing/racingStore.html'
	}
	
	var racingUpgradeState = {
		name : 'racing.upgrades',
		url : '/upgrades',
		templateUrl : 'views/racing/racingUpgrades.html',
		onEnter: function($rootScope){
			$rootScope.$broadcast('loadRacingUpgrade');
		}
	}
	$urlRouterProvider.otherwise('/');
	$stateProvider.state({
		name : 'gamesIndex',
		url : '/',
		templateUrl : 'gamesList.html'
	});
	$stateProvider.state({
		name : 'racing.garage',
		url : '/garage',
		templateUrl : 'views/racing/racingGarage.html',
		onEnter: function($rootScope){
			$rootScope.$broadcast('loadRacingGarage');
		}
	});
	$stateProvider.state({
		name : 'racing.setup',
		url : '/raceSetup',
		templateUrl : 'views/racing/racingSetup.html'
	});
	$stateProvider.state({
		name : 'racing.userRace',
		url : '/userRace',
		templateUrl : 'views/racing/userRace.html',
		controller:"userRaceCtrl",
		controllerAs:"userRace"
	});
	$stateProvider.state({
		name : 'racing.spectateRace',
		url : '/spectateRace',
		templateUrl : 'views/racing/spectateRace.html',
		controller:"spectateRaceCtrl",
		controllerAs:"spectateRace"
	});
	$stateProvider.state(racingState);
	$stateProvider.state({
		name : 'snake',
		url : '/snake',
		templateUrl : 'views/snake/snake.html',
		controller:"snakeCtrl",
		controllerAs:"snakeVM"
	});
	$stateProvider.state(racingStoreState);
	$stateProvider.state(racingUpgradeState);
});