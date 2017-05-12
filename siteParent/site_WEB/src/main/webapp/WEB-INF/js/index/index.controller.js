angular.module('indexApp').controller('indexCtrl', ['$rootScope', '$window', 'identityService', function($rootScope, $window, identityService){
	var indexVM = this;

	$rootScope.identity={};
	
	indexVM.initController = function(){
		indexVM.animationsToggle=false;
		indexVM.homeTabSelected=true;
		identityService.getIdentity().then(function(data){
			$rootScope.identity = data;
			indexVM.animationsToggle=true;
			$window.addEventListener('resize', function(e){
				if (indexVM.animationsToggle&&indexVM.homeTabSelected){
					onResize();
				}
			});
			toggleAnim(indexVM.homeTabSelected);
		});
	};
	
	indexVM.toggleAnim = function(){
		toggleAnim(indexVM.animationsToggle);
	};
	
	indexVM.selectHome = function(isHome){
		indexVM.homeTabSelected=isHome;
		if (!indexVM.homeTabSelected){
			toggleAnim(false);
		} else {
			indexVM.toggleAnim();
		}
	}

	indexVM.initController();
}]);