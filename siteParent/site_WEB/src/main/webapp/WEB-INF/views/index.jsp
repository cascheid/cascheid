<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link href="css/site.css" rel="stylesheet">
	<style>
		#main{
    		background: rgba(255,255,255,.25)
    	}
    	
		ul#menu li a {
    		background: rgba(255,255,255,.5)
    	}
    	
		#bodyCanvas{
			position:fixed;
			top:0;
			left:0;
		}
		
		.fish{
			position:fixed;
			top:900px;
			left:500px;
		}
		
		div.master{
			position:relative;
			z-index:3;
		}
		
		#top{
			position:fixed;
			top:0px;
			left:0px;
			z-index:2;
		}
	</style>
<title>CScheid Home</title>
<script src="js/smoke.js"></script>
<!--  --><script src="js/rain.js"></script>
</head>
<body>
	<canvas id="bodyCanvas"></canvas>
	<script>
	var runInterval;
	var fishInterval;
	var waterfallInterval;
	var fish1Left=500;
	var fish1Top=850;
	var fish2Left=1000;
	var fish2Top=880;
	var goingRight1=true;
	var goingRight2=false;
	var fish1Direction='straight';
	var fish2Direction='straight';
	var ratio=1;
	var canvas;
	var ctx;
	var bAnim=false;
    var canvasimg = new Image();
	canvasimg.src='img/misc/bottom.jpg';
	function waterRipple() {
	    canvas = document.getElementById('bodyCanvas');
	    ctx = canvas.getContext('2d');
	    var width = window.innerWidth,
	        height = window.innerHeight,
	        half_width = width >> 1,
	        half_height = height >> 1,
	        size = width * (height + 2) * 2,
	        delay = 30,
	        oldind = width,
	        newind = width * (height + 3),
	        riprad = 1,
	        ripplemap = [],
	        last_map = [],
	        ripple,
	        texture,
	        line_width = 10,
	        step = line_width * 2, 
	        count = height / line_width;
	        
	    canvas.width = width;
	    canvas.height = height;
	    
	    canvas.style.left ='0px';
	    canvas.style.top = '0px';

	    var fullWidth=1828;
	    var fullHeight=1080;
	    ratio = width/fullWidth;
	    var displayedHeight = (height/ratio)/fullHeight;
	    
	    document.getElementById('top').style.width=width+'px';
	    document.getElementById('top').style.height=height/displayedHeight+'px';
		ctx.drawImage(canvasimg, 0, 0, fullWidth, fullHeight*displayedHeight, 0, 0, width, height);
	    texture = ctx.getImageData(0, 0, width, height);
	    ripple = ctx.getImageData(0, 0, width, height);
	    
	    for (var i = 0; i < size; i++) {
	        last_map[i] = ripplemap[i] = 0;
	    }
	    
	    /**
	     * Main loop
	     */
	    var loopCounter=0;
	    function run() {
	        newframe();
	        ctx.putImageData(ripple, 0, 0);
        	drawRain();
		    updateMist();
	        drawMist();
	    }
	    
	    /**
	     * Disturb water at specified point
	     */
	    function disturb(dx, dy) {
	        dx <<= 0;
	        dy <<= 0;
	        
	        for (var j = dy - riprad; j < dy + riprad; j++) {
	            for (var k = dx - riprad; k < dx + riprad; k++) {
	                ripplemap[oldind + (j * width) + k] += 128;
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
	        var _width = width,
	            _height = height,
	            _ripplemap = ripplemap,
	            _last_map = last_map,
	            _rd = ripple.data,
	            _td = texture.data,
	            _half_width = half_width,
	            _half_height = half_height;
	        
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
	                    if (a<(100*ratio)||b<(800*ratio)){
		                    new_pixel=cur_pixel;
		                }
	                    _rd[cur_pixel] = _td[new_pixel];
	                    _rd[cur_pixel + 1] = _td[new_pixel + 1];
	                    _rd[cur_pixel + 2] = _td[new_pixel + 2];
	                }
	                
	                ++i;
	            }
	        }
	    }
	    
	    runInterval=setInterval(run, 20);

		var fish1Elem=document.getElementById('fish1');
		var fish2Elem=document.getElementById('fish2');
		fish1Left=fish1Left*ratio;
		fish1Top=fish1Top*ratio;
		fish1Elem.width=40*ratio;
		fish1Elem.height=20*ratio;
		fish1Elem.style.left=fish1Left+'px';
		fish1Elem.style.top=fish1Top+'px';
		fish2Left=fish2Left*ratio;
		fish2Top=fish2Top*ratio;
		fish2Elem.width=50*ratio;
		fish2Elem.height=25*ratio;
		fish2Elem.style.left=fish2Left+'px';
		fish2Elem.style.top=fish2Top+'px';
		fish2Elem.style.webkitTransform='rotate(180deg)';
		fish2Elem.style.MozTransform='rotate(180deg)';
		fish2Elem.style.transform='rotate(180deg)';
		var topBorder=820*ratio;
		var bottomBorder=930*ratio;
		var leftBorder=100*ratio;
		var rightBorder=1750*ratio;
		//var fishCounter=0;
		function animateAllFish(){
			//fishCounter++;
			animateFish(1);
			animateFish(2);
		}
		function animateFish(num){
			var fishElem;
			var fishLeft;
			var fishTop;
			var fishDirection;
			var goingRight;
			if (num==1){
				fishElem=fish1Elem;
				fishLeft=fish1Left;
				fishTop=fish1Top;
				fishDirection=fish1Direction;
				goingRight=goingRight1;
			} else {
				fishElem=fish2Elem;
				fishLeft=fish2Left;
				fishTop=fish2Top;
				fishDirection=fish2Direction;
				goingRight=goingRight2;
			}
			//var mv=20*(Math.random()/(4*num));
			var mv=4*ratio/num;
			var rand=Math.random();
			if (rand<.01){
				fishDirection='straight';
				var rotate;
				if (goingRight){
					rotate='rotate(0deg)';
				} else {
					rotate='rotate(180deg)';
				}
				fishElem.style.webkitTransform=rotate;
				fishElem.style.MozTransform=rotate;
				fishElem.style.transform=rotate;
			} else if (rand<.02&&fishTop<(bottomBorder-50*ratio)){
				fishDirection='down';
				var rotate;
				if (goingRight){
					rotate='rotate(45deg)';
				} else {
					rotate='rotate(140deg)';
				}
				fishElem.style.webkitTransform=rotate;
				fishElem.style.MozTransform=rotate;
				fishElem.style.transform=rotate;
			} else if (rand<.03&&fishTop>(topBorder+50*ratio)){
				fishDirection='up';
				var rotate;
				if (goingRight){
					rotate='rotate(315deg)';
				} else {
					rotate='rotate(215deg)';
				}
				fishElem.style.webkitTransform=rotate;
				fishElem.style.MozTransform=rotate;
				fishElem.style.transform=rotate;
			}
			
			if (goingRight){
				if (fishDirection=='up'){
					fishLeft=fishLeft+mv*.7;//roughly sqrt(2)
					fishTop=fishTop-mv*.7;
					if (fishTop<topBorder){
						fishDirection='down';
						rotate='rotate(45deg)';
						fishElem.style.webkitTransform=rotate;
						fishElem.style.MozTransform=rotate;
						fishElem.style.transform=rotate;
					}
				} else if (fishDirection=='down'){
					fishLeft=fishLeft+mv*.7;
					fishTop=fishTop+mv*.7;
					if (fishTop>bottomBorder){
						fishDirection='up';
						rotate='rotate(315deg)';
						fishElem.style.webkitTransform=rotate;
						fishElem.style.MozTransform=rotate;
						fishElem.style.transform=rotate;
					}
				} else {
					fishLeft=fishLeft+mv;
				}
				if (fishLeft>rightBorder){
					goingRight=false;
					var rotate;
					if (fishDirection=='up'){
						rotate='rotate(215deg)';
					} else if (fishDirection=='down'){
						rotate='rotate(140deg)';
					} else {
						rotate='rotate(180deg)';
					}
					fishElem.style.webkitTransform=rotate;
					fishElem.style.MozTransform=rotate;
					fishElem.style.transform=rotate;
				}
			} else {
				if (fishDirection=='up'){
					fishLeft=fishLeft-mv*.7;//roughly sqrt(2)
					fishTop=fishTop-mv*.7;
					if (fishTop<topBorder){
						fishDirection='down';
						rotate='rotate(140deg)';
						fishElem.style.webkitTransform=rotate;
						fishElem.style.MozTransform=rotate;
						fishElem.style.transform=rotate;
					}
				} else if (fishDirection=='down'){
					fishLeft=fishLeft-mv*.7;
					fishTop=fishTop+mv*.7;
					if (fishTop>bottomBorder){
						fishDirection='up';
						rotate='rotate(215deg)';
						fishElem.style.webkitTransform=rotate;
						fishElem.style.MozTransform=rotate;
						fishElem.style.transform=rotate;
					}
				} else {
					fishLeft=fishLeft-mv;
				}
				if (fishLeft<leftBorder){
					goingRight=true;
					if (fishDirection=='up'){
						rotate='rotate(315deg)';
					} else if (fishDirection=='down'){
						rotate='rotate(45deg)';
					} else {
						rotate='rotate(0deg)';
					}
					fishElem.style.webkitTransform=rotate;
					fishElem.style.MozTransform=rotate;
					fishElem.style.transform=rotate;
				}
			}
			fishElem.style.left=fishLeft+'px';
			fishElem.style.top=fishTop+'px';
			//if (fishCounter==2){
				disturb(fishLeft+12*ratio, fishTop+9*ratio);
				//if (num==2){
					//fishCounter=0;
				//}
			//}
			if (num==1){
				fish1Left=fishLeft;
				fish1Top=fishTop;
				fish1Direction=fishDirection;
				goingRight1=goingRight;
			} else {
				fish2Left=fishLeft;
				fish2Top=fishTop;
				fish2Direction=fishDirection;
				goingRight2=goingRight;
			}
		}

		fishInterval=setInterval(animateAllFish, 10);

		initMist(512*ratio, 1532*ratio, 728*ratio, 760*ratio, 55*ratio, 250);
		initRain(300*ratio, 1800*ratio, 0*ratio, 720*ratio, 2000, 2*ratio);
	}

    function onResize(){
        if (bAnim){
	    	clearInterval(fishInterval);
	    	clearInterval(runInterval);
	    	fish1Left=fish1Left/ratio;
	    	fish1Top=fish1Top/ratio;
	    	fish2Left=fish2Left/ratio;
	    	fish2Top=fish2Top/ratio;
	    
	    	waterRipple();
        }
	 }

	 function toggleAnim(){
		if (bAnim){
			bAnim=false;
			clearInterval(fishInterval);
	    	clearInterval(runInterval);
	    	document.getElementById('bodyCanvas').style.visibility='hidden';
	    	document.getElementById('fish1').style.visibility='hidden';
	    	document.getElementById('fish2').style.visibility='hidden';
	    	document.getElementById('btnAnim').innerHTML='Animations Off';
		} else {
			bAnim=true;
	    	document.getElementById('bodyCanvas').style.visibility='';
	    	document.getElementById('fish1').style.visibility='';
	    	document.getElementById('fish2').style.visibility='';
	    	document.getElementById('btnAnim').innerHTML='Animations On';
			onResize();
		}
	 }

     window.onload = function() {
       bAnim=true;
       onResize();
     };

	 window.addEventListener('resize', onResize, false);

	</script>
	<div class="master">
	<nav id="nav01">
		<ul id='menu'>
			<li><a href='index'>Home</a></li>
			<li><a href='gamesIndex'>Games</a></li>
			<li><a href='about'>About</a></li>
		</ul>
	</nav>
  	<div id="main">
  		<button id='btnAnim' onclick="toggleAnim()">Animations On</button>
		<h1>Hellow World!</h1>
	</div>
	</div>
	<img id="fish1" class="fish" src="img/sprites/fish.png">
	<img id="fish2" class="fish" src="img/sprites/fish.png">
	<img id="top" src="img/misc/top.png">
	
</body>
</html>