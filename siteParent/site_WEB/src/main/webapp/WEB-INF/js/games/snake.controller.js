angular.module('indexApp').controller('snakeCtrl', ['$scope', '$window', '$state', '$document', '$rootScope', '$http', '$interval', 'commonService', function($scope, $window, $state, $document, $rootScope, $http, $interval, commonService){
	var snakeVM = this;
	
	snakeVM.highScore = $rootScope.identity.snakeScore==null?0:$rootScope.identity.snakeScore;
	
	$scope.$on('loadUser', function(e){
		snakeVM.highScore = $rootScope.identity.snakeScore;
	});
	
	snakeVM.init = function(){
		snakeVM.gameEnded=false;
		snakeVM.lastMoveDirection = 'none';
		snakeVM.currDirection = 'none';
		snakeVM.head = angular.element("<div class='snakeBlock'/>");
		snakeVM.food = angular.element("<div />");
		angular.element('#snakeContainer').append(snakeVM.head);
		angular.element('#snakeContainer').append(snakeVM.food);
		snakeVM.food[0].className = 'snakeBlock';
		snakeVM.snakeBody = [];
		snakeVM.score = 0;
		snakeVM.intervalTime = 100;
		snakeVM.imageCounter = 0;

		snakeVM.snakeBody.push(snakeVM.head);
		snakeVM.food.css('left', '208px');
		
		snakeVM.range1 = [ '0px', '0px' ];
		snakeVM.range2 = [ '100px', '0px' ];
		snakeVM.range3 = [ '200px', '0px' ];
		snakeVM.range4 = [ '300px', '0px' ];
		snakeVM.range5 = [ '0px', '100px' ];
		snakeVM.range6 = [ '100px', '100px' ];
		snakeVM.range7 = [ '200px', '100px' ];
		snakeVM.range8 = [ '300px', '100px' ];
		snakeVM.range9 = [ '0px', '200px' ];
		snakeVM.range10 = [ '100px', '200px' ];
		snakeVM.range11 = [ '200px', '200px' ];
		snakeVM.range12 = [ '300px', '200px' ];
		snakeVM.range13 = [ '0px', '300px' ];
		snakeVM.range14 = [ '100px', '300px' ];
		snakeVM.range15 = [ '200px', '300px' ];
		snakeVM.range16 = [ '300px', '300px' ];
		snakeVM.range17 = [ '400px', '0px' ];
		snakeVM.range18 = [ '400px', '100px' ];
		snakeVM.range19 = [ '400px', '200px' ];
		snakeVM.range20 = [ '400px', '300px' ];
		snakeVM.range21 = [ '500px', '0px' ];
		snakeVM.range22 = [ '500px', '100px' ];
		snakeVM.range23 = [ '500px', '200px' ];
		snakeVM.range24 = [ '500px', '300px' ];

		snakeVM.gameInterval = $interval(snakeVM.move, snakeVM.intervalTime);

		snakeVM.pictureList = [ 'barcelona.jpg', 'bvi.jpg', 'cabo_san_lucas.jpg',
				'cancun.jpg', 'chichen_itza.jpg', 'disney_world.jpg', 'naxos.jpg',
				'rome.jpg', 'valencia.jpg', 'venice.jpg', 'victoria_falls.jpg' ];
		
		$document.bind('keydown', function(e) {
			e = e || window.event;
			var selectedKey = (typeof e.which == "number") ? e.which : e.keyCode;
			if (selectedKey < 37 || selectedKey > 40) {// not an arrow key
				return;
			} else {
				e.preventDefault();
				if (selectedKey == 37) {
					if (snakeVM.lastMoveDirection != 'right') {
						snakeVM.currDirection = 'left';
					}
				} else if (selectedKey == 38) {
					if (snakeVM.lastMoveDirection != 'down') {
						snakeVM.currDirection = 'up';
					}
				} else if (selectedKey == 39) {
					if (snakeVM.lastMoveDirection != 'left') {
						snakeVM.currDirection = 'right';
					}
				} else if (selectedKey == 40) {
					if (snakeVM.lastMoveDirection != 'up') {
						snakeVM.currDirection = 'down';
					}
				}
			}
		});
		

		snakeVM.resetImage();
	};
	

	snakeVM.endGame = function(){
		$interval.cancel(snakeVM.gameInterval);
		snakeVM.gameEnded=true;
		angular.forEach(snakeVM.snakeBody, function(elem){
			elem.remove()
		});
		snakeVM.food.remove();
		
		if (snakeVM.score>snakeVM.highScore){
			$http.post('snakeResult', {params: {snakeScore:snakeVM.score}});
			snakeVM.highScore = snakeVM.score;
		}
	};


	snakeVM.resetImage = function() {
		snakeVM.imageCounter = 0;
		var myArray = [ snakeVM.range1, snakeVM.range2, snakeVM.range3, snakeVM.range4, snakeVM.range5, snakeVM.range6, snakeVM.range7,
				snakeVM.range8, snakeVM.range9, snakeVM.range10, snakeVM.range11, snakeVM.range12, snakeVM.range13, snakeVM.range14,
				snakeVM.range15, snakeVM.range16, snakeVM.range17, snakeVM.range18, snakeVM.range19, snakeVM.range20, snakeVM.range21,
				snakeVM.range22, snakeVM.range23, snakeVM.range24 ];
		for (var i = 1; i <= 24; i++) {
			var index = Math.floor(Math.random() * myArray.length);
			var randRange = myArray[index];
			myArray.splice(index, 1);
			angular.element("#blank" + i).css('left', randRange[0]);
			angular.element("#blank" + i).css('top', randRange[1]);
			angular.element("#blank" + i).css('visibility', '');
		}

		snakeVM.backgroundSrc = 'img/snake/'+snakeVM.pictureList[Math.floor(Math.random() * snakeVM.pictureList.length)]
	};

	snakeVM.eatFood = function() {
		snakeVM.score++;
		snakeVM.imageCounter++;
		if (snakeVM.imageCounter <= 24) {
			angular.element("#blank" + snakeVM.imageCounter).css('visibility', 'hidden');
		} else if (snakeVM.imageCounter == 25) {
			snakeVM.resetImage();
		}
		
		snakeVM.snakeBody.unshift(snakeVM.food);
		snakeVM.head = snakeVM.food;
		snakeVM.food = angular.element('<div />');
		angular.element('#snakeContainer').append(snakeVM.food);
		snakeVM.food[0].className = 'snakeBlock';
		var newTop;
		var newLeft;
		var match = true;
		while (match) {
			newTop = Math.round(24 * Math.random()) * 16;
			newLeft = Math.round(24 * Math.random()) * 16;
			match = false;
			for (var i = 0; i < snakeVM.snakeBody.length; i++) {
				if (snakeVM.snakeBody[i][0].offsetTop == newTop
						&& snakeVM.snakeBody[i][0].offsetLeft == newLeft) {
					match = true;
					break;
				}
			}
		}
		snakeVM.food.css('left', newLeft + 'px');
		snakeVM.food.css('top', newTop + 'px');
		if (snakeVM.score % 5 == 0 && snakeVM.intervalTime > 50) {
			snakeVM.intervalTime = snakeVM.intervalTime - 10;
			$interval.cancel(snakeVM.gameInterval);
			snakeVM.gameInterval = $interval(snakeVM.move, snakeVM.intervalTime);
		}
	}

	snakeVM.move = function() {
		snakeVM.lastMoveDirection = snakeVM.currDirection;
		var newLoc;
		var top = snakeVM.head[0].offsetTop;
		var left = snakeVM.head[0].offsetLeft;
		var foodtop = snakeVM.food[0].offsetTop;
		var foodLeft = snakeVM.food[0].offsetLeft;
		var newLeft = left;
		var newTop = top;
		if (snakeVM.currDirection == 'left') {
			newLeft = left - 16;
			if (newLeft == snakeVM.food[0].offsetLeft && top == snakeVM.food[0].offsetTop) {
				snakeVM.eatFood();
				return;
			}
			if (newLeft < 0) {
				snakeVM.endGame();
				return;
			}
		} else if (snakeVM.currDirection == 'right') {
			newLeft = left + 16;
			if (newLeft == snakeVM.food[0].offsetLeft && top == snakeVM.food[0].offsetTop) {
				snakeVM.eatFood();
				return;
			}
			if (newLeft > 584) {
				snakeVM.endGame();
				return;
			}
		} else if (snakeVM.currDirection == 'up') {
			newTop = top - 16;
			if (newTop == snakeVM.food[0].offsetTop && left == snakeVM.food[0].offsetLeft) {
				snakeVM.eatFood();
				return;
			}
			if (newTop < 0) {
				snakeVM.endGame();
				return;
			}
		} else if (snakeVM.currDirection == 'down') {
			newTop = top + 16;
			if (newTop == snakeVM.food[0].offsetTop && left == snakeVM.food[0].offsetLeft) {
				snakeVM.eatFood();
				return;
			}
			if (newTop > 384) {
				snakeVM.endGame();
				return;
			}
		}
		snakeVM.head = snakeVM.snakeBody.pop();
		snakeVM.head.css('top', newTop + 'px');
		snakeVM.head.css('left', newLeft + 'px');
		for (var i = 0; i < snakeVM.snakeBody.length; i++) {
			if (snakeVM.snakeBody[i][0].offsetLeft == newLeft
					&& snakeVM.snakeBody[i][0].offsetTop == newTop) {
				snakeVM.endGame();
				break;
			}
		}
		snakeVM.snakeBody.unshift(snakeVM.head);
	};
	
	snakeVM.init();
}]);
