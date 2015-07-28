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
var myTurn=false;
var myId;
var opponentId;
var shotSelected='';
var myMoves=[];
var oppMoves=[];
var mySunkenShips=[];
var oppSunkenShips=[];
var lastMove;
var winState;
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

	window.onload=function(){
		drawTopGrid();
		drawTopText();
		drawTopShips();
	}
}

function initGame(size, gameID, identifier, turnStatus, mymoves, oppmoves, mysunkenships, oppsunkenships, winstate){
	localGameId=gameID;
	myTurn=turnStatus;
	myId=identifier;
	myMoves=mymoves;
	oppMoves=oppmoves;
	mySunkenShips=mysunkenships;
	oppSunkenShips=oppsunkenships;
	winState=winstate;
	bw = (size-20)/2;
	canvas = document.getElementById('canvas');
	context = canvas.getContext('2d');
	stndTxt=(bw-20)/12;
	canvas.width = size;
	canvas.height = size;

    placingShips=false;
	canvas.addEventListener("mousedown", onClick, false);
	//canvas.addEventListener("mouseup", onMouseUp, false);
	
	socket = new WebSocket("ws://localhost:8080/site_WEB/wsbattleship");
	socket.onmessage = onMessage;
	socket.onopen = function(){
		initWs();
	};

	window.onload=function(){
		drawTopGrid();
		drawBottomGrid();
		drawTopText();
	    toggleTurn();
		drawBottomText();
		drawTopShips();
		drawBottomShips();
	}
}

	var waterImg = new Image();
	waterImg.src='img/battleship/water.png';
	waterImg.width=bw+'px';
	waterImg.height=bw+'px';

	function drawTopGrid(){
		context.drawImage(waterImg, 10, 10, bw, bw);
		//top grid
		context.beginPath();
		for (var i=0; i<=10; i++){
			context.moveTo(10+i*bw/10, 10);
			context.lineTo(10+i*bw/10, 10+bw);
		}

		for (var i=0; i<=10; i++){
			context.moveTo(10, 10+i*bw/10);
			context.lineTo(10+bw, 10+i*bw/10);
		}
		
		context.strokeStyle='black';
		context.lineWidth = bw/100;
		context.stroke();
		
		drawLoadedShips();
		
		for (var i=0; i<oppMoves.length; i++){
			if (oppMoves[i].status=='hit'){
				if (oppMoves[i].status==lastMove){
					drawHit(oppMoves[i].loc, 0, true);
				} else {
					drawHit(oppMoves[i].loc, 0, false);
				}
			} else if (oppMoves[i].status=='miss'){
				if (oppMoves[i].status==lastMove){
					drawMiss(oppMoves[i].loc, 0, true);
				} else {
					drawMiss(oppMoves[i].loc, 0, false);
				}
			}
		}
	}
	
	function drawBottomGrid(){
		context.drawImage(waterImg, bw+10, bw+10, bw, bw);
		//bottom grid
		context.beginPath();
		for (var i=0; i<=10; i++){
			context.moveTo(bw+10+i*bw/10, bw+10);
			context.lineTo(bw+10+i*bw/10, bw+10+bw);
		}

		for (var i=0; i<=10; i++){
			context.moveTo(bw+10, bw+10+i*bw/10);
			context.lineTo(bw+10+bw, bw+10+i*bw/10);
		}

		context.strokeStyle='black';
		context.lineWidth = bw/100;
		context.stroke();
		
		for (var i=0; i<myMoves.length; i++){
			if (myMoves[i].status=='hit'){
				if (myMoves[i].status==lastMove){
					drawHit(myMoves[i].loc, bw, true);
				} else {
					drawHit(myMoves[i].loc, bw, false);
				}
			} else if (myMoves[i].status=='miss'){
				if (myMoves[i].status==lastMove){
					drawMiss(myMoves[i].loc, bw, true);
				} else {
					drawMiss(myMoves[i].loc, bw, false);
				}
			}
		}
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
	
	function toggleTurn(){
		context.textAlign='center';
		context.clearRect(bw+20, 20+9.5*stndTxt, bw-20, 2*stndTxt);
		if (winState=='win'){
			context.font=stndTxt*1.5+'px Arial';
			context.fillStyle='#00FF00';
			context.fillText("YOU WIN!", bw+10+bw/2, 20+11*stndTxt, bw-20);
		} else if (winState=='lose'){
			context.font=stndTxt*1.5+'px Arial';
			context.fillStyle='red';
			context.fillText("YOU LOSE", bw+10+bw/2, 20+11*stndTxt, bw-20);	
		} else if (myTurn){
			context.font=stndTxt*1.5+'px Arial';
			context.fillStyle='#00FF00';
			context.fillText("YOUR TURN", bw+10+bw/2, 20+11*stndTxt, bw-20);
		} else {
			context.font=stndTxt*1.5+'px Arial';
			context.fillStyle='black';
			context.fillText("THEIR TURN", bw+10+bw/2, 20+11*stndTxt, bw-20);	
		}
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
		
		for (var i=0; i<mySunkenShips.length; i++){
			var yStart;
			var length;
			if (mySunkenShips[i]=='carrier'){
				yStart=20+2*stndTxt;
				length=bw/2;
			} else if (mySunkenShips[i]=='battleship'){
				yStart=20+3.5*stndTxt;
				length=2*bw/5;
			} else if (mySunkenShips[i]=='destroyer'){
				yStart=20+5*stndTxt;
				length=3*bw/10;
			} else if (mySunkenShips[i]=='submarine'){
				yStart=20+6.5*stndTxt;
				length=3*bw/10;
			} else if (mySunkenShips[i]=='patrol'){
				yStart=20+8*stndTxt;
				length=bw/5;
			}
			context.beginPath();
			context.moveTo(bw+20+bw/2, yStart);
			context.lineTo(bw+20+bw/2+length, yStart+bw/10);
			context.moveTo(bw+20+bw/2, yStart+bw/10);
			context.lineTo(bw+20+bw/2+length, yStart);
			context.lineWidth = bw/50;
			context.strokeStyle='red';
			context.stroke();
		}
	}

	function drawBottomShips(){
		context.drawImage(carrierImg, 10+bw/2, bw+20+2*stndTxt, bw/2, bw/10);
		context.drawImage(battleshipImg, 10+bw/2, bw+20+3.5*stndTxt, 2*bw/5, bw/10);
		context.drawImage(destroyerImg, 10+bw/2, bw+20+5*stndTxt, 3*bw/10, bw/10);
		context.drawImage(submarineImg, 10+bw/2, bw+20+6.5*stndTxt, 3*bw/10, bw/10);
		context.drawImage(patrolImg, 10+bw/2, bw+20+8*stndTxt, bw/5, bw/10);
		
		for (var i=0; i<oppSunkenShips.length; i++){
			var yStart;
			var length;
			if (oppSunkenShips[i]=='carrier'){
				yStart=bw+20+2*stndTxt;
				length=bw/2;
			} else if (oppSunkenShips[i]=='battleship'){
				yStart=bw+20+3.5*stndTxt;
				length=2*bw/5;
			} else if (oppSunkenShips[i]=='destroyer'){
				yStart=bw+20+5*stndTxt;
				length=3*bw/10;
			} else if (oppSunkenShips[i]=='submarine'){
				yStart=bw+20+6.5*stndTxt;
				length=3*bw/10;
			} else if (oppSunkenShips[i]=='patrol'){
				yStart=bw+20+8*stndTxt;
				length=bw/5;
			}
			context.beginPath();
			context.moveTo(10+bw/2, yStart);
			context.lineTo(10+bw/2+length, yStart+bw/10);
			context.moveTo(10+bw/2, yStart+bw/10);
			context.lineTo(10+bw/2+length, yStart);
			context.lineWidth = bw/50;
			context.strokeStyle='red';
			context.stroke();
		}
	}

	function getXCoord(square){
		var col=square.substring(1, square.length);
		var left = (document.documentElement && document.documentElement.scrollLeft) || 
        document.body.scrollLeft;
		return 10+(col-1)*bw/10;
	}

	function getYCoord(square){
		var row=square.charCodeAt(0)-64;
		var top = (document.documentElement && document.documentElement.scrollTop) || 
        document.body.scrollTop;
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
	
	function getRowBottom(y){
		return (getRow(y-bw));
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

	function getColumnBottom(x){
		return (getColumn(x-bw));
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
          x = event.x + document.body.scrollLeft +
          document.documentElement.scrollLeft;
          y = event.y + document.body.scrollTop +
          document.documentElement.scrollTop;;
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
						clearTopHighlights();
						initialDrag=getRow(y)+getColumn(x);
						canvas.addEventListener("mousemove", dragSelection, false);
					}
				}
			}
		} else if (myTurn){
			if (x>=bw+10&&y>=bw+10){
				var square=getRowBottom(y)+getColumnBottom(x);
				if (shotSelected==''){
					var i = myMoves.length;
				    while (i--) {
				       if (myMoves[i] == square) {
				           //repeat
				    	   return;
				       }
				    }
				    highlightSquareBottom(square, 'red');
				    shotSelected=square;
				} else if (square==shotSelected){
					clearBottomHighlights();
				    shotSelected='';
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
			clearTopHighlights();
			initialDrag='';
			draggedSquares=0;
			reqSquares=0;
		}
	}
	function clearTopHighlights(){
		context.clearRect(10, 10, bw, bw);
		drawTopGrid();
	}
	function clearBottomHighlights(){
		context.clearRect(10+bw, 10+bw, bw, bw);
		drawBottomGrid();
	}

	function clearHighlights(){
		clearTopHighlights();
		clearBottomHighlights();
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
	
	function highlightSquareBottom(square, color){
		context.fillStyle=color;
		context.fillRect(getXCoord(square)+bw, getYCoord(square)+bw, bw/10, bw/10);
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
					clearTopHighlights();
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
					clearTopHighlights();
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
				clearTopHighlights();
			}
		}
	}
	
	function animateShotResult(status, square, offset){
		if (status=='hit'){
			var expInt=setInterval(function(){update(20);}, 20);
			setTimeout(function(){
				clearInterval(expInt); 
				particles=[]; 
				drawHit(square, offset, true);
			}, 1500);
			createExplosion(getXCoord(square)+offset+bw/20, getYCoord(square)+offset+bw/20, "#525252");
			createExplosion(getXCoord(square)+offset+bw/20, getYCoord(square)+offset+bw/20, "#FFA318");
		} else {
			waterRipple(square, offset);
		}
	}

	function onMessage(event) {
	    var result = JSON.parse(event.data);
	    clearHighlights();
	    if (result.status!='illegal'){
	    	if (result.status=='win'){
	    		if (result.userID==myId){
	    			winState='win';
	    			window.alert('You Win!');
	    		} else {
	    			winState='lose';
	    			window.alert('You lose...');
	    		}
	    		myTurn=false;
			    toggleTurn();
	    	}
	    	if (result.userID==myId){
	    		if (result.status.substring(0, 4) == 'sunk'){
	    			var sunkenShip=result.status.substring(4, result.status.length);
	    			oppSunkenShips.push(sunkenShip);
	    			window.alert('You sunk their '+sunkenShip+"!");
	    			drawBottomShips();
	    			result.status='hit';
	    		}
	    		lastMove=result;
			    animateShotResult(result.status, result.loc, bw);
			    myMoves.push(result);
			    myTurn=false;
			    toggleTurn();
	    	} else {
	    		if (result.status.substring(0, 4) == 'sunk'){
	    			var sunkenShip=result.status.substring(4, result.status.length);
	    			mySunkenShips.push(sunkenShip);
	    			window.alert('Your '+sunkenShip+" has been sunk!");
	    			drawTopShips();
	    			result.status='hit';
	    		}
	    		lastMove=result;
			    animateShotResult(result.status, result.loc, 0);
			    oppMoves.push(result);
			    myTurn=true;
			    toggleTurn();
	    	}
	    } else {
	    	window.alert('Illegal shot selected.');
	    }
		shotSelected='';
	    //window.alert(result.status);
	}
	
	function initWs(){
		var action = {
			gameID: localGameId,
			status: 'LOAD',
			user1: myId,
			user2: '0'
		};
		socket.send(JSON.stringify(action));
	}

	function fire(shotloc) {
	    var action = {
	        loc: shotloc,
	        status: 'fired',
	        userID: myId
	    };
	    socket.send(JSON.stringify(action));
	}
	
	function submitFire(){
		if (myTurn){
			if (shotSelected==''){
				window.alert("Please select location to fire.")
			} else {
				fire(shotSelected);
			}	
		}
	}
	
	function drawHit(square, offset, lastShot){
		var color;
		if (lastShot){
			color='red';
		} else {
			color='white';
		}
		var centerX=getXCoord(square)+offset+bw/20;
		var centerY=getYCoord(square)+offset+bw/20;
		context.beginPath();
		context.arc(centerX, centerY, bw/30, 0, 2 * Math.PI, false);
		context.fillStyle = color;
		context.fill();
		context.lineWidth = bw/150;
		context.strokeStyle=color;
		context.stroke();
	}
	
	function drawMiss(square, offset, lastShot){
		var color;
		if (lastShot){
			color='red';
		} else {
			color='white';
		}
		context.beginPath();
		var xStart=getXCoord(square)+offset;
		var yStart=getYCoord(square)+offset;
		context.moveTo(xStart+bw/100, yStart+bw/100);
		context.lineTo(xStart+bw/10-bw/100, yStart+bw/10-bw/100);
		context.moveTo(xStart+bw/100, yStart+bw/10-bw/100);
		context.lineTo(xStart+bw/10-bw/100, yStart+bw/100);
		context.lineWidth = bw/50;
		context.strokeStyle=color;
		context.stroke();
	}
	
/**
 * Code for Explosions
 */
	/*
	 * A single explosion particle
	 */
	function Particle ()
	{
		this.scale = 1.0;
		this.x = 0;
		this.y = 0;
		this.radius = bw/50;
		this.color = "#000";
		this.velocityX = 0;
		this.velocityY = 0;
		this.scaleSpeed = 0.5;
		this.minCoord=10+bw;
		this.maxCoord=10+2*bw;

		this.update = function(ms)
		{
			// shrinking
			this.scale -= this.scaleSpeed * ms / 1000.0;

			if (this.scale <= 0)
			{
				this.scale = 0;
			}
			// moving away from explosion center
			this.x += this.velocityX * ms/1000.0;
			this.y += this.velocityY * ms/1000.0;
		};

		this.draw = function(context)
		{
			// translating the 2D context to the particle coordinates
			if ((this.x-this.radius)>this.minCoord&&(this.x+this.radius)<this.maxCoord&&
					(this.y-this.radius)>this.minCoord&&(this.y+this.radius)<this.maxCoord){
				context.save();
				context.translate(this.x, this.y);
				context.scale(this.scale, this.scale);

				// drawing a filled circle in the particle's local space
				context.beginPath();
				context.arc(0, 0, this.radius, 0, Math.PI*2, true);
				context.closePath();

				context.fillStyle = this.color;
				context.fill();

				context.restore();
			}
		};
	}

	var particles = [];
	
	function update (frameDelay)
	{
		// draw a white background to clear canvas
		//context.fillStyle = "#FFF";
		//context.fillRect(0, 0, context.canvas.width, context.canvas.height);
		clearHighlights();

		// update and draw particles
		for (var i=0; i<particles.length; i++)
		{
			var particle = particles[i];

			particle.update(frameDelay);
			particle.draw(context);
		}
	}
	
	function randomFloat (min, max)
	{
		return min + Math.random()*(max-min);
	}
	
	function createExplosion(x, y, color)
	{
		var minSize = bw/60;
		var maxSize = bw/20;
		var count = 10;
		var minSpeed = 30.0;
		var maxSpeed = 100.0;
		var minScaleSpeed = 1.0;
		var maxScaleSpeed = 4.0;

		for (var angle=0; angle<360; angle += Math.round(360/count))
		{
			var particle = new Particle();

			particle.x = x;
			particle.y = y;

			particle.radius = randomFloat(minSize, maxSize);

			particle.color = color;

			particle.scaleSpeed = randomFloat(minScaleSpeed, maxScaleSpeed);

			var speed = randomFloat(minSpeed, maxSpeed);

			particle.velocityX = speed * Math.cos(angle * Math.PI / 180.0);
			particle.velocityY = speed * Math.sin(angle * Math.PI / 180.0);

			particles.push(particle);
		}
	}
	
/**
 * Code for splashes
 */
	
	function waterRipple(square, offset) {
		var xStart=getXCoord(square)+offset;
		var yStart=getYCoord(square)+offset;
		var sqSize=Math.floor(bw/10);
		var size = sqSize * (sqSize + 2) * 2,
        delay = 30,
        oldind = sqSize,
        newind = sqSize * (sqSize + 3),
        riprad = 1,
        ripplemap = [],
        last_map = [],
        ripple,
        texture;

		//context.drawImage(waterImg, bw+10, bw+10, bw, bw);
	    texture = context.getImageData(xStart, yStart, sqSize, sqSize);
	    ripple = context.getImageData(xStart, yStart, sqSize, sqSize);
	    
	    for (var i = 0; i < size; i++) {
	        last_map[i] = ripplemap[i] = 0;
	    }
	    
	    /**
	     * Main loop
	     */
	    var loopCounter=0;
	    var runInterval;
	    function run() {
	    	loopCounter++;
	        newframe();
	        context.putImageData(ripple, xStart, yStart);
	        if (loopCounter==100){
	        	loopCounter=0;
	        	clearInterval(runInterval);
	        	drawMiss(square, offset, true);
	        }
	    }
	    
	    /**
	     * Disturb water at specified point
	     */
	    function disturb(dx, dy) {
	        dx <<= 0;
	        dy <<= 0;
	        
	        for (var j = dy - riprad; j < dy + riprad; j++) {
	            for (var k = dx - riprad; k < dx + riprad; k++) {
	                ripplemap[oldind + (j * sqSize) + k] += 128;
	            }
	        }
	    }
	    
	    /**
	     * Generates new ripples
	     */
	    function newframe() {
	        var a, b, data, cur_pixel, new_pixel, old_data;
	        
	        var t = oldind; oldind = newind; newind = t;
	        var i = 0;
	        
	        // create local copies of variables to decrease
	        // scope lookup time in Firefox
	        var _width = sqSize,
	            _height = sqSize,
	            _ripplemap = ripplemap,
	            _last_map = last_map,
	            _rd = ripple.data,
	            _td = texture.data,
	            _half_width = sqSize >> 1,
	            _half_height = sqSize >> 1;
	        
	        for (var y = 0; y < _height; y++) {
	            for (var x = 0; x < _width; x++) {
	                var _newind = newind + i, _mapind = oldind + i;
	                data = (
	                    _ripplemap[_mapind - _width] + 
	                    _ripplemap[_mapind + _width] + 
	                    _ripplemap[_mapind - 1] + 
	                    _ripplemap[_mapind + 1]) >> 1;
	                    
	                data -= _ripplemap[_newind];
	                data -= data >> 5;
	                
	                _ripplemap[_newind] = data;

	                //where data=0 then still, where data>0 then wave
	                data = 512 - data;
	                
	                old_data = _last_map[i];
	                _last_map[i] = data;
	                
	                if (old_data != data) {
	                    //offsets
	                    a = (((x - _half_width) * data / 512) << 0) + _half_width;
	                    b = (((y - _half_height) * data / 512) << 0) + _half_height;
	    
	                    //bounds check
	                    if (a >= _width) a = _width - 1;
	                    if (a < 0) a = 0;
	                    if (b >= _height) b = _height - 1;
	                    if (b < 0) b = 0;
	    
	                    new_pixel = (a + (b * _width)) * 4;
	                    cur_pixel = i * 4;
	                    
	                    _rd[cur_pixel] = _td[new_pixel];
	                    _rd[cur_pixel + 1] = _td[new_pixel + 1];
	                    _rd[cur_pixel + 2] = _td[new_pixel + 2];
	                }
	                
	                ++i;
	            }
	        }
	    }
	    //disturb (xStart+Math.floor(bw/20), yStart+Math.floor(bw/20));
	    disturb (Math.floor(bw/20), Math.floor(bw/20));
	    
	    runInterval=setInterval(run, 20);
	}
	