var bw;
var canvas;
var context;
var stndTxt;
var placingShips;
var placingSelected='';
var draggedSquares=0;
var reqSquares=0;
var initialDrag='';
var dragVert=true;
var nameArray=['carrier', 'battleship', 'destroyer', 'submarine', 'patrol'];
var socket;
var localGameId;
var currStatus;
var myId;
var opponentId;
function initBoardLoad(size){
	bw = (size-20)/2;
	canvas = document.getElementById('canvas');
	context = canvas.getContext('2d');
	stndTxt=(bw-20)/12;
	canvas.width = size;
	canvas.height = size/2;

    placingShips=true;
	canvas.addEventListener("mousedown", onClick, false);
	canvas.addEventListener("mouseup", onMouseUp, false);
	
	drawTopGrid();
	drawTopText();
	drawTopShips();
	
	socket = new WebSocket("ws://localhost:8080/site_WEB/wsbattleship");
	socket.onmessage = onMessage;
	socket.onopen = function(){
		fire('A1');
	};
}

function initGame(size, gameID, status, identifier){
	localGameId=gameID;
	currStatus=status;
	myId=identifier;
	bw = (size-20)/2;
	canvas = document.getElementById('canvas');
	context = canvas.getContext('2d');
	stndTxt=(bw-20)/12;
	canvas.width = size;
	canvas.height = size;

    placingShips=false;
	canvas.addEventListener("mousedown", onClick, false);
	canvas.addEventListener("mouseup", onMouseUp, false);
	
	socket = new WebSocket("ws://localhost:8080/site_WEB/wsbattleship");
	socket.onmessage = onMessage;
	socket.onload = function(){
		initWs();
	};
}

	function drawTopGrid(){
		//top grid
		for (var i=0; i<=10; i++){
			context.moveTo(10+i*bw/10, 10);
			context.lineTo(10+i*bw/10, 10+bw);
		}

		for (var i=0; i<=10; i++){
			context.moveTo(10, 10+i*bw/10);
			context.lineTo(10+bw, 10+i*bw/10);
		}
		
		context.strokeStyle='black';
		context.stroke();
	}
	
	function drawBottomGrid(){
		//bottom grid
		for (var i=0; i<=10; i++){
			context.moveTo(bw+10+i*bw/10, bw+10);
			context.lineTo(bw+10+i*bw/10, bw+10+bw);
		}

		for (var i=0; i<=10; i++){
			context.moveTo(bw+10, bw+10+i*bw/10);
			context.lineTo(bw+10+bw, bw+10+i*bw/10);
		}

		context.strokeStyle='black';
		context.stroke();
	}

	function drawTopText(){
		context.font=stndTxt*1.5+'px Arial';
		context.fillStyle='red';
		context.textAlign='center';
		//context.fillText("My Board", bw+20, 50, bw-20);
		//context.fillText("Their Board", 20, bw+50, bw-20);
		context.fillText("My Board", bw+10+bw/2, 20+1.5*stndTxt, bw-20);

		context.font=stndTxt+'px Arial';
		context.textAlign='left';
		context.fillStyle='magenta';
		context.fillText("Carrier:", bw+20, 20+3*stndTxt, (bw-20)/2);
		context.fillStyle='purple';
		context.fillText("Battleship:", bw+20, 20+4.5*stndTxt, (bw-20)/2);
		context.fillStyle='orange';
		context.fillText("Destroyer:", bw+20, 20+6*stndTxt, (bw-20)/2);
		context.fillStyle='blue';
		context.fillText("Submarine:", bw+20, 20+7.5*stndTxt, (bw-20)/2);
		context.fillStyle='green';
		context.fillText("Patrol Boat:", bw+20, 20+9*stndTxt, (bw-20)/2);	
	}

	function drawBottomText(){
		context.font=stndTxt*1.5+'px Arial';
		context.fillStyle='red';
		context.textAlign='center';
		//context.fillText("My Board", bw+20, 50, bw-20);
		//context.fillText("Their Board", 20, bw+50, bw-20);
		context.fillText("Their Board", 10+bw/2, bw+20+1.5*stndTxt, bw-20);

		context.font=stndTxt+'px Arial';
		context.textAlign='left';
		context.fillStyle='magenta';
		context.fillText("Carrier:", 20, bw+20+3*stndTxt, (bw-20)/2);
		context.fillStyle='purple';
		context.fillText("Battleship:", 20, bw+20+4.5*stndTxt, (bw-20)/2);
		context.fillStyle='orange';
		context.fillText("Destroyer:", 20, bw+20+6*stndTxt, (bw-20)/2);
		context.fillStyle='blue';
		context.fillText("Submarine:", 20, bw+20+7.5*stndTxt, (bw-20)/2);
		context.fillStyle='green';
		context.fillText("Patrol Boat:", 20, bw+20+9*stndTxt, (bw-20)/2);		
	}

	var carrierImg = new Image();
	carrierImg.src='img/battleship/carrier.png';
	carrierImg.width=bw/2+'px';
	carrierImg.height=bw/10+'px';
	var battleshipImg = new Image();
	battleshipImg.src='img/battleship/battleship.png';
	battleshipImg.width=2*bw/5+'px';
	battleshipImg.height=bw/10+'px';
	var destroyerImg = new Image();
	destroyerImg.src='img/battleship/destroyer.png';
	destroyerImg.width=3*bw/10+'px';
	destroyerImg.height=bw/10+'px';
	var submarineImg = new Image();
	submarineImg.src='img/battleship/submarine.png';
	submarineImg.width=3*bw/10+'px';
	submarineImg.height=bw/10+'px';
	var patrolImg = new Image();
	patrolImg.src='img/battleship/patrol.png';
	patrolImg.width=bw/5+'px';
	patrolImg.height=bw/10+'px';
	
	function drawTopShips(){
		context.drawImage(carrierImg, bw+20+bw/2, 20+2*stndTxt, bw/2, bw/10);
		context.drawImage(battleshipImg, bw+20+bw/2, 20+3.5*stndTxt, 2*bw/5, bw/10);
		context.drawImage(destroyerImg, bw+20+bw/2, 20+5*stndTxt, 3*bw/10, bw/10);
		context.drawImage(submarineImg, bw+20+bw/2, 20+6.5*stndTxt, 3*bw/10, bw/10);
		context.drawImage(patrolImg, bw+20+bw/2, 20+8*stndTxt, bw/5, bw/10);
	}

	function drawBottomShips(){
		context.drawImage(carrierImg, 10+bw/2, bw+20+2*stndTxt, bw/2, bw/10);
		context.drawImage(battleshipImg, 10+bw/2, bw+20+3.5*stndTxt, 2*bw/5, bw/10);
		context.drawImage(destroyerImg, 10+bw/2, bw+20+5*stndTxt, 3*bw/10, bw/10);
		context.drawImage(submarineImg, 10+bw/2, bw+20+6.5*stndTxt, 3*bw/10, bw/10);
		context.drawImage(patrolImg, 10+bw/2, bw+20+8*stndTxt, bw/5, bw/10);
	}

	function getXCoord(square){
		var col=square.substring(1, square.length);
		return 10+(col-1)*bw/10;
	}

	function getYCoord(square){
		var row=square.charCodeAt(0)-64;
		return 10+(row-1)*bw/10;
	}

	function drawLoadedShips(){
		var loc = document.getElementById('carrierLoc').value;
		var vert=document.getElementById('carrierVertical').value;
		if (loc!=''){
			if (document.getElementById('carrierVertical').value=='true'){
			    context.save(); 
			    context.translate(getXCoord(loc), getYCoord(loc));
			    context.rotate(Math.PI/2);
				context.drawImage(carrierImg, 0, -bw/10, bw/2, bw/10);
			    context.restore(); 
			} else {
				context.drawImage(carrierImg, getXCoord(loc), getYCoord(loc), bw/2, bw/10);
			}
		}
		loc = document.getElementById('battleshipLoc').value;
		if (loc!=''){
			if (document.getElementById('battleshipVertical').value=='true'){
			    context.save(); 
			    context.translate(getXCoord(loc), getYCoord(loc));
			    context.rotate(Math.PI/2);
				context.drawImage(battleshipImg, 0, -bw/10, 2*bw/5, bw/10);
			    context.restore(); 
			} else {
				context.drawImage(battleshipImg, getXCoord(loc), getYCoord(loc), 2*bw/5, bw/10);
			}
		}
		loc = document.getElementById('destroyerLoc').value;
		if (loc!=''){
			if (document.getElementById('destroyerVertical').value=='true'){
			    context.save(); 
			    context.translate(getXCoord(loc), getYCoord(loc));
			    context.rotate(Math.PI/2);
				context.drawImage(destroyerImg, 0, -bw/10, 3*bw/10, bw/10);
			    context.restore(); 
			} else {
				context.drawImage(destroyerImg, getXCoord(loc), getYCoord(loc), 3*bw/10, bw/10);
			}
		}
		loc = document.getElementById('submarineLoc').value;
		if (loc!=''){
			if (document.getElementById('submarineVertical').value=='true'){
			    context.save(); 
			    context.translate(getXCoord(loc), getYCoord(loc));
			    context.rotate(Math.PI/2);
				context.drawImage(submarineImg, 0, -bw/10, 3*bw/10, bw/10);
			    context.restore(); 
			} else {
				context.drawImage(submarineImg, getXCoord(loc), getYCoord(loc), 3*bw/10, bw/10);
			}
		}
		loc = document.getElementById('patrolLoc').value;
		if (loc!=''){
			if (document.getElementById('patrolVertical').value=='true'){
			    context.save(); 
			    context.translate(getXCoord(loc), getYCoord(loc));
			    context.rotate(Math.PI/2);
				context.drawImage(patrolImg, 0, -bw/10, bw/5, bw/10);
			    context.restore(); 
			} else {
				context.drawImage(patrolImg, getXCoord(loc), getYCoord(loc), bw/5, bw/10);
			}
		}
	}

	function getRow(y){
		var b=null;
		if (y>10&&y<=10+bw/10){
			b='A';
		} else if (y>10+bw/10&&y<=10+2*bw/10){
			b='B';
		} else if (y>10+2*bw/10&&y<=10+3*bw/10){
			b='C';
		} else if (y>10+3*bw/10&&y<=10+4*bw/10){
			b='D';
		} else if (y>10+4*bw/10&&y<=10+5*bw/10){
			b='E';
		} else if (y>10+5*bw/10&&y<=10+6*bw/10){
			b='F';
		} else if (y>10+6*bw/10&&y<=10+7*bw/10){
			b='G';
		} else if (y>10+7*bw/10&&y<=10+8*bw/10){
			b='H';
		} else if (y>10+8*bw/10&&y<=10+9*bw/10){
			b='I';
		} else if (y>10+9*bw/10&&y<=10+bw){
			b='J';
		}
		return b;
	}

	function getColumn(x){
		var b=null;
		if (x>10&&x<=10+bw/10){
			b='1';
		} else if (x>10+bw/10&&x<=10+2*bw/10){
			b='2';
		} else if (x>10+2*bw/10&&x<=10+3*bw/10){
			b='3';
		} else if (x>10+3*bw/10&&x<=10+4*bw/10){
			b='4';
		} else if (x>10+4*bw/10&&x<=10+5*bw/10){
			b='5';
		} else if (x>10+5*bw/10&&x<=10+6*bw/10){
			b='6';
		} else if (x>10+6*bw/10&&x<=10+7*bw/10){
			b='7';
		} else if (x>10+7*bw/10&&x<=10+8*bw/10){
			b='8';
		} else if (x>10+8*bw/10&&x<=10+9*bw/10){
			b='9';
		} else if (x>10+9*bw/10&&x<=10+bw){
			b='10';
		}
		return b;
	}

	function getNumSquares(shipname){
		var bNum=0;
		if (shipname=='carrier'){
			bNum=5;
		} else if (shipname=='battleship'){
			bNum=4;
		} else if (shipname=='destroyer'){
			bNum=3;
		} else if (shipname=='submarine'){
			bNum=3;
		} else if (shipname=='patrol'){
			bNum=2;
		}
		return bNum;
	}

	function onClick(event){
        if (event.x != undefined && event.y != undefined) {
          x = event.x;
          y = event.y;
        } else{ // Firefox method to get the position
          x = event.clientX + document.body.scrollLeft +
              document.documentElement.scrollLeft;
          y = event.clientY + document.body.scrollTop +
              document.documentElement.scrollTop;
        }


		x -= canvas.offsetLeft;
		y -= canvas.offsetTop;

		if (placingShips){
			if (x>=bw+20+bw/2){
				if (y>=20+2*stndTxt){
					//we're within top left of ships, simplify with offset now
					var newx=x-(bw+20+bw/2);
					var newy=y-(20+2*stndTxt);
					if (newy>=0&&newy<=bw/10&&newx<=bw/2){//carrier
						if (placingSelected=='carrier'){
							placingSelected='';
							/*context.rect(bw+20+bw/2, 20+2*stndTxt, bw/2, bw/10);
							context.fillStyle = "white";
							context.fill();*/
							//context.clearRect(bw+20+bw/2, 20+2*stndTxt, bw/2, bw/10);
							context.clearRect(Math.floor(bw+20+bw/2), Math.floor(20+2*stndTxt), Math.ceil(bw/2)+1, Math.ceil(bw/10)+1);
							context.drawImage(carrierImg, bw+20+bw/2, 20+2*stndTxt, bw/2, bw/10);
						} else if (placingSelected==''){
							placingSelected='carrier';
							context.fillStyle = "magenta";
							context.fillRect(Math.floor(bw+20+bw/2), Math.floor(20+2*stndTxt), Math.ceil(bw/2)+1, Math.ceil(bw/10)+1);
							context.drawImage(carrierImg, bw+20+bw/2, 20+2*stndTxt, bw/2, bw/10);
						}
					} else if (newy>=1.5*stndTxt&&newy<=1.5*stndTxt+bw/10&&newx<=2*bw/5){//battleship
						if (placingSelected=='battleship'){
							placingSelected='';
							context.clearRect(Math.floor(bw+20+bw/2), Math.floor(20+3.5*stndTxt), Math.ceil(2*bw/5)+1, Math.ceil(bw/10)+1);
							context.drawImage(battleshipImg, bw+20+bw/2, 20+3.5*stndTxt, 2*bw/5, bw/10);
						} else if (placingSelected==''){
							placingSelected='battleship';
							context.fillStyle = "purple";
							context.fillRect(Math.floor(bw+20+bw/2), Math.floor(20+3.5*stndTxt), Math.ceil(2*bw/5)+1, Math.ceil(bw/10)+1);
							context.drawImage(battleshipImg, bw+20+bw/2, 20+3.5*stndTxt, 2*bw/5, bw/10);
						}
					} else if (newy>=3*stndTxt&&newy<=3*stndTxt+bw/10&&newx<=3*bw/10){//destroyer
						if (placingSelected=='destroyer'){
							placingSelected='';
							context.clearRect(Math.floor(bw+20+bw/2), Math.floor(20+5*stndTxt), Math.ceil(3*bw/10)+1, Math.ceil(bw/10)+1);
							context.drawImage(destroyerImg, bw+20+bw/2, 20+5*stndTxt, 3*bw/10, bw/10);
						} else if (placingSelected==''){
							placingSelected='destroyer';
							context.fillStyle = "orange";
							context.fillRect(Math.floor(bw+20+bw/2), Math.floor(20+5*stndTxt), Math.ceil(3*bw/10)+1, Math.ceil(bw/10)+1);
							context.drawImage(destroyerImg, bw+20+bw/2, 20+5*stndTxt, 3*bw/10, bw/10);
						}
					} else if (newy>=4.5*stndTxt&&newy<=4.5*stndTxt+bw/10&&newx<=3*bw/10){//submarine
						if (placingSelected=='submarine'){
							placingSelected='';
							context.clearRect(Math.floor(bw+20+bw/2), Math.floor(20+6.5*stndTxt), Math.ceil(3*bw/10)+1, Math.ceil(bw/10)+1);
							context.drawImage(submarineImg, bw+20+bw/2, 20+6.5*stndTxt, 3*bw/10, bw/10);
						} else if (placingSelected==''){
							placingSelected='submarine';
							context.fillStyle = "blue";
							context.fillRect(Math.floor(bw+20+bw/2), Math.floor(20+6.5*stndTxt), Math.ceil(3*bw/10)+1, Math.ceil(bw/10)+1);
							context.drawImage(submarineImg, bw+20+bw/2, 20+6.5*stndTxt, 3*bw/10, bw/10);
						}
					} else if (newy>=6*stndTxt&&newy<=6*stndTxt+bw/10&&newx<=bw/5){//patrol boat
						if (placingSelected=='patrol'){
							placingSelected='';
							context.clearRect(Math.floor(bw+20+bw/2), Math.floor(20+8*stndTxt), Math.ceil(bw/5)+1, Math.ceil(bw/10)+1);
							context.drawImage(patrolImg, bw+20+bw/2, 20+8*stndTxt, bw/5, bw/10);
						} else if (placingSelected==''){
							placingSelected='patrol';
							context.fillStyle = "green";
							context.fillRect(Math.floor(bw+20+bw/2), Math.floor(20+8*stndTxt), Math.ceil(bw/5)+1, Math.ceil(bw/10)+1);
							context.drawImage(patrolImg, bw+20+bw/2, 20+8*stndTxt, bw/5, bw/10);
						}
					}
				}
			} else if (x<=bw+10&&y>=10&&y<=10+bw){
				if (placingSelected!=''){
					if (draggedSquares==0){
						//draggedSquares=1;
						reqSquares=getNumSquares(placingSelected);
						document.getElementById(placingSelected+'Loc').value='';
						clearHighlights();
						initialDrag=getRow(y)+getColumn(x);
						canvas.addEventListener("mousemove", dragSelection, false);
					}
				}
			}
		}
	}

	function getOccupiedSpaces(shipname){
		var spaces=getNumSquares(shipname);
		var loc=document.getElementById(shipname+'Loc').value;
		var vert=document.getElementById(shipname+'Vertical').value;
		var squares=[];
		if (loc!=''){
			if (vert=='true'){
				var col=loc.substring(1, loc.length);
				var row=loc.charAt(0);
				for (var i=0; i<spaces; i++){
					squares.push(row+col);
					row=String.fromCharCode(row.charCodeAt(0)+1);
				}
			} else {
				var col=loc.substring(1, loc.length);
				var row=loc.charAt(0);
				for (var i=0; i<spaces; i++){
					squares.push(row+col);
					col=(Number(col)+1).toString();
				}
			}
		}
		return squares;
	}

	function isInArray(value, array) {
		return array.indexOf(value) > -1;
	}

	function checkCollision(){
		if (dragVert){
			var col = Number(initialDrag.substring(1, initialDrag.length));
			var rows = [];
			var initRow=initialDrag.charCodeAt(0);
			for (var i=0; i<reqSquares; i++){
				rows.push(initRow+i);
			}
			outer:
			for (var i=0; i<5; i++){
				var name=nameArray[i];
				if (name!=placingSelected&&document.getElementById(name+'Loc').value!=''){
					var squares=getOccupiedSpaces(name);
					for (var j=0; j<rows.length; j++){
						var cur=String.fromCharCode(rows[j])+col;
						if (isInArray(cur, squares)){
							document.getElementById(placingSelected+'Loc').value='';
							break outer;
						}
					}
				}
			}
		} else {
			var cols = [];
			var row = initialDrag.charAt(0);
			var initCol=Number(initialDrag.substring(1, initialDrag.length));
			for (var i=0; i<reqSquares; i++){
				cols.push(initCol+i);
			}
			outer:
			for (var i=0; i<5; i++){
				var name=nameArray[i];
				if (name!=placingSelected&&document.getElementById(name+'Loc').value!=''){
					var squares=getOccupiedSpaces(name);
					for (var j=0; j<cols.length; j++){
						var cur=row+cols[j].toString;
						if (isInArray(cur, squares)){
							document.getElementById(placingSelected+'Loc').value='';
							break outer;
						}
					}
				}
			}
			
		}
	}

	var dif;
	function onMouseUp(event){
		if (draggedSquares>0){
			canvas.removeEventListener("mousemove", dragSelection, false);
			if ((reqSquares-1)==draggedSquares){//we're good, drop the ship
				if (dif<0){//need to adjust location
					if (dragVert){
						var row=initialDrag.charCodeAt(0);
						initialDrag=String.fromCharCode(row-draggedSquares)+initialDrag.substring(1, initialDrag.length);
					} else {
						var col=Number(initialDrag.substring(1, initialDrag.length));
						initialDrag=initialDrag.substring(0, 1)+(col-draggedSquares).toString();
					}
				}
				document.getElementById(placingSelected+'Loc').value=initialDrag;
				document.getElementById(placingSelected+'Vertical').value=dragVert;
				checkCollision();
			} else {
				//anything to clear?
			}
			clearHighlights();
			initialDrag='';
			draggedSquares=0;
			reqSquares=0;
		}
	}

	function clearHighlights(){
		context.clearRect(10, 10, bw, bw);
		drawTopGrid();
		drawLoadedShips();
	}

	function highlightSquare(square){
		var color='magenta';
		if (placingSelected=='battleship'){
			color='purple';
		} else if (placingSelected=='destroyer'){
			color='orange';
		} else if (placingSelected=='submarine'){
			color='blue';
		} else if (placingSelected=='patrol'){
			color='green';
		}
		
		context.fillStyle=color;
		context.fillRect(getXCoord(square), getYCoord(square), bw/10, bw/10);
	}
	
	function dragSelection(event){
		if (placingShips&&initialDrag!=''){
	        if (event.x != undefined && event.y != undefined) {
	          x = event.x;
	          y = event.y;
	        } else{ // Firefox method to get the position
	          x = event.clientX + document.body.scrollLeft +
	              document.documentElement.scrollLeft;
	          y = event.clientY + document.body.scrollTop +
	              document.documentElement.scrollTop;
	        }

			x -= canvas.offsetLeft;
			y -= canvas.offsetTop;

			var row=getRow(y);
			var col=Number(getColumn(x));
			if (row==initialDrag.charAt(0)){
				var initCol=Number(initialDrag.substring(1, initialDrag.length));
				dif=col-initCol;
				if (Math.abs(dif)>=reqSquares){
					if (dif<0){
						dif=0-(reqSquares-1);
					} else {
						dif=reqSquares-1;
					}
				}
				if (Math.abs(dif)!=draggedSquares){//&&!dragVert){
					dragVert=false;
					draggedSquares=-1;
					clearHighlights();
					if (dif<0){
						for (var i=0; i>=dif; i--){
							draggedSquares++;
							if ((initCol+i)>0){
								highlightSquare(row+(initCol+i));
							}
						}
					} else if (dif>0){
						for (var i=0; i<=dif; i++){
							draggedSquares++;
							if ((initCol+i)<=10){
								highlightSquare(row+(initCol+i));
							}
						}
					}
				}
			} else if (col==initialDrag.substring(1, initialDrag.length)){
				var initRow=initialDrag.charAt(0);
				dif=row.charCodeAt(0)-initialDrag.charCodeAt(0);
				if (Math.abs(dif)>=reqSquares){
					if (dif<0){
						dif=0-(reqSquares-1);
					} else {
						dif=reqSquares-1;
					}
				}
				if (Math.abs(dif)!=draggedSquares){//&&!dragVert){
					dragVert=true;
					draggedSquares=-1;
					clearHighlights();
					if (dif<0){
						for (var i=0; i>=dif; i--){
							draggedSquares++;
							highlightSquare(String.fromCharCode(initRow.charCodeAt(0)+i)+col);
						}
					} else if (dif>0){
						for (var i=0; i<=dif; i++){
							draggedSquares++;
							highlightSquare(String.fromCharCode(initRow.charCodeAt(0)+i)+col);
						}
					}
				}
			} else {
				clearHighlights();
			}
		}
	}

	function onMessage(event) {
	    var result = JSON.parse(event.data);
	    window.alert(result.status);
	}
	
	function initWs(){
		var action = {
			gameID: localGameId,
			status: currStatus,
			user1: myId,
			user2: '0'
		};
		socket.send(JSON.stringify(action));
	}

	function fire(shotloc) {
	    var action = {
	        loc: shotloc,
	        status: 'fired'
	    };
	    socket.send(JSON.stringify(action));
	}
	    