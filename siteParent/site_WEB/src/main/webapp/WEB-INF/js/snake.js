var lastMoveDirection = 'none'
var currDirection = 'none';
var head = document.getElementById("firstblock");
var food = document.getElementById("firstfood");
var snakeBody = [];
var score = 0;
var intervalTime = 100;
var imageCounter = 0;
// document.getElementById('background').style.clip='rect(0, 0, 0, 0)';

snakeBody.push(head);
food.style.left = '208px';
document.onkeydown = function(e) {
	e = e || window.event;
	var selectedKey = (typeof e.which == "number") ? e.which : e.keyCode;
	if (selectedKey < 37 || selectedKey > 40) {// not an arrow key
		return;
	} else {
		e.preventDefault();
		if (selectedKey == 37) {
			if (lastMoveDirection != 'right') {
				currDirection = 'left';
			}
		} else if (selectedKey == 38) {
			if (lastMoveDirection != 'down') {
				currDirection = 'up';
			}
		} else if (selectedKey == 39) {
			if (lastMoveDirection != 'left') {
				currDirection = 'right';
			}
		} else if (selectedKey == 40) {
			if (lastMoveDirection != 'up') {
				currDirection = 'down';
			}
		}
	}
}

function endGame() {
	clearInterval(gameInterval);
	window.open("snakeResult?score="
			+ document.getElementById("score").innerHTML, "_self");
}

var range1 = [ '0px', '0px' ];
var range2 = [ '100px', '0px' ];
var range3 = [ '200px', '0px' ];
var range4 = [ '300px', '0px' ];
var range5 = [ '0px', '100px' ];
var range6 = [ '100px', '100px' ];
var range7 = [ '200px', '100px' ];
var range8 = [ '300px', '100px' ];
var range9 = [ '0px', '200px' ];
var range10 = [ '100px', '200px' ];
var range11 = [ '200px', '200px' ];
var range12 = [ '300px', '200px' ];
var range13 = [ '0px', '300px' ];
var range14 = [ '100px', '300px' ];
var range15 = [ '200px', '300px' ];
var range16 = [ '300px', '300px' ];
var range17 = [ '400px', '0px' ];
var range18 = [ '400px', '100px' ];
var range19 = [ '400px', '200px' ];
var range20 = [ '400px', '300px' ];
var range21 = [ '500px', '0px' ];
var range22 = [ '500px', '100px' ];
var range23 = [ '500px', '200px' ];
var range24 = [ '500px', '300px' ];

var pictureList = [ 'barcelona.jpg', 'bvi.jpg', 'cabo_san_lucas.jpg',
		'cancun.jpg', 'chichen_itza.jpg', 'disney_world.jpg', 'naxos.jpg',
		'rome.jpg', 'valencia.jpg', 'venice.jpg', 'victoria_falls.jpg' ];

function resetImage() {
	imageCounter = 0;
	var myArray = [ range1, range2, range3, range4, range5, range6, range7,
			range8, range9, range10, range11, range12, range13, range14,
			range15, range16, range17, range18, range19, range20, range21,
			range22, range23, range24 ];
	for (var i = 1; i <= 24; i++) {
		var index = Math.floor(Math.random() * myArray.length);
		var randRange = myArray[index];
		myArray.splice(index, 1);
		document.getElementById("blank" + i).style.left = randRange[0];
		document.getElementById("blank" + i).style.top = randRange[1];
		document.getElementById("blank" + i).style.visibility = '';
	}
	document.getElementById('background').src = 'img/snake/'
			+ pictureList[Math.floor(Math.random() * pictureList.length)];
}
resetImage();

function eatFood() {
	score++;
	imageCounter++;
	if (imageCounter <= 24) {
		document.getElementById("blank" + imageCounter).style.visibility = 'hidden';
	} else if (imageCounter == 25) {
		resetImage();
	}
	// document.getElementById('background').style.clip='rect(0, '+20*score+'px,
	// '+20*score+'px, 0)';
	document.getElementById('score').innerHTML = score;
	snakeBody.unshift(food);
	head = food;
	food = document.createElement('div');
	document.getElementById('snakeContainer').appendChild(food);
	food.className = 'block';
	var newTop;
	var newLeft;
	var match = true;
	while (match) {
		newTop = Math.round(24 * Math.random()) * 16;
		newLeft = Math.round(24 * Math.random()) * 16;
		match = false;
		for (var i = 0; i < snakeBody.length; i++) {
			if (snakeBody[i].offsetTop == newTop
					&& snakeBody[i].offsetLeft == newLeft) {
				match = true;
				break;
			}
		}
	}
	food.style.left = newLeft + 'px';
	food.style.top = newTop + 'px';
	if (score % 5 == 0 && intervalTime > 50) {
		intervalTime = intervalTime - 10;
		clearInterval(gameInterval);
		gameInterval = setInterval(move, intervalTime);
	}
}

function move() {
	lastMoveDirection = currDirection;
	var newLoc;
	var top = head.offsetTop;
	var left = head.offsetLeft;
	var foodtop = food.offsetTop;
	var foodLeft = food.offsetLeft;
	var newLeft = left;
	var newTop = top;
	if (currDirection == 'left') {
		newLeft = left - 16;
		if (newLeft == food.offsetLeft && top == food.offsetTop) {
			eatFood();
			return;
		}
		if (newLeft < 0) {
			endGame();
			return;
		}
	} else if (currDirection == 'right') {
		newLeft = left + 16;
		if (newLeft == food.offsetLeft && top == food.offsetTop) {
			eatFood();
			return;
		}
		if (newLeft > 584) {
			endGame();
			return;
		}
	} else if (currDirection == 'up') {
		newTop = top - 16;
		if (newTop == food.offsetTop && left == food.offsetLeft) {
			eatFood();
			return;
		}
		if (newTop < 0) {
			endGame();
			return;
		}
	} else if (currDirection == 'down') {
		newTop = top + 16;
		if (newTop == food.offsetTop && left == food.offsetLeft) {
			eatFood();
			return;
		}
		if (newTop > 384) {
			endGame();
			return;
		}
	}
	head = snakeBody.pop();
	head.style.top = newTop + 'px';
	head.style.left = newLeft + 'px';
	for (var i = 0; i < snakeBody.length; i++) {
		if (snakeBody[i].offsetLeft == newLeft
				&& snakeBody[i].offsetTop == newTop) {
			endGame();
			break;
		}
	}
	snakeBody.unshift(head);
}

var gameInterval = setInterval(move, intervalTime);