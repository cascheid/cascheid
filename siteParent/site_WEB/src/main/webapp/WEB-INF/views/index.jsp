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
		
		#fish{
			position:fixed;
			top:900px;
			left:500px;
		}
		
		div.master{
			position:relative;
			z-index:2;
		}
	</style>
<title>CScheid Home</title>
</head>
<body>
	<canvas id="bodyCanvas"></canvas>
	<script>
	var runInterval;
	var fishInterval;
	var waterfallInterval;
	var fishLeft=500;
	var fishTop=850;
	var goingRight=true;
	var fishDirection='straight';
	var ratio=1;
	var canvas;
	var ctx;
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

	    var img = new Image();
		img.src='img/misc/timon.jpg';
	    var fullWidth=img.width;
	    var fullHeight=img.height;
	    ratio = width/fullWidth;
	    var displayedHeight = (height/ratio)/fullHeight;
	    var offsetHeight = fullHeight*(1-displayedHeight)*ratio;
		ctx.drawImage(img, 0, 0, img.width, img.height*displayedHeight, 0, 0, width, height);
	    texture = ctx.getImageData(0, 0, width, height);
	    ripple = ctx.getImageData(0, 0, width, height);
	    
	    for (var i = 0; i < size; i++) {
	        last_map[i] = ripplemap[i] = 0;
	    }
	    
	    /**
	     * Main loop
	     */
	    function run() {
	        newframe();
	        ctx.putImageData(ripple, 0, 0);
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
	                    if (a<(320*ratio)||b<(800*ratio)){
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
	    
	    /*canvas.onmousemove = function(evt) {
		    var dx=evt.offsetX || evt.layerX;
		    var dy=evt.offsetY || evt.layerY;
	        disturb(evt.offsetX || evt.layerX, evt.offsetY || evt.layerY);
	    };*/
	    
	    runInterval=setInterval(run, delay);
		var waterfallLoop=0;
	    function animateWaterfalls(){
		    for (var x=Math.round(1309*ratio); x<1343; x=x+5*ratio){
				disturb(x, 110+Math.round(waterfallLoop*20*ratio));
			}
		    waterfallLoop++;
		    if (waterfallLoop>21){
			    waterfallLoop=0;
			}
            /*if (y>=Math.round(110*ratio)&&y<=Math.round(333*ratio)&&x>1309*ratio&&x<1343*ratio){
                if (y=Math.round(110*ratio)){
	                _rd[i*4] = _td[(x + (Math.round(333*ratio) * _width)) * 4];
	            } else {
                	_rd[i*4] = _td[i*4-_width];
	            }
            }*/
		}

		//waterfallInterval=setInterval(animateWaterfalls, 200);
	    /*// generate random ripples
	    var rnd = Math.random;
	    setInterval(function() {
	        disturb(rnd() * width, rnd() * height);
	    }, 700);*/

		var fishElem=document.getElementById('fish');
		fishLeft=fishLeft*ratio;
		fishTop=fishTop*ratio;
		fishElem.style.width=24*ratio;
		fishElem.style.height=17*ratio;
		fishElem.style.left=fishLeft+'px';
		fishElem.style.top=fishTop+'px';
		var topBorder=850*ratio;
		var bottomBorder=1030*ratio;
		var leftBorder=400*ratio;
		var rightBorder=1750*ratio;
		function animateFish(){
			var mv=5*(Math.random()/2);
			var rand=Math.random();
			if (rand<.004){
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
			} else if (rand<.007&&fishTop<(bottomBorder-50*ratio)){
				fishDirection='down';
				var rotate;
				if (goingRight){
					rotate='rotate(45deg)';
				} else {
					rotate='rotate(135deg)';
				}
				fishElem.style.webkitTransform=rotate;
				fishElem.style.MozTransform=rotate;
				fishElem.style.transform=rotate;
			} else if (rand<.01&&fishTop>(topBorder+50*ratio)){
				fishDirection='up';
				var rotate;
				if (goingRight){
					rotate='rotate(315deg)';
				} else {
					rotate='rotate(225deg)';
				}
				fishElem.style.webkitTransform=rotate;
				fishElem.style.MozTransform=rotate;
				fishElem.style.transform=rotate;
			}
			if (goingRight){
				if (fishDirection=='up'){
					fishLeft=fishLeft+mv*ratio*.7;//roughly sqrt(2)
					fishTop=fishTop-mv*ratio*.7;
					if (fishTop<topBorder){
						fishDirection='down';
					}
				} else if (fishDirection=='down'){
					fishLeft=fishLeft+mv*ratio*.7;
					fishTop=fishTop+mv*ratio*.7;
					if (fishTop>bottomBorder){
						fishDirection='up';
					}
				} else {
					fishLeft=fishLeft+mv*ratio;
				}
				if (fishLeft>rightBorder){
					goingRight=false;
					var rotate;
					if (fishDirection=='up'){
						rotate='rotate(225deg)';
					} else if (fishDirection=='down'){
						rotate='rotate(135deg)';
					} else {
						rotate='rotate(180deg)';
					}
					fishElem.style.webkitTransform=rotate;
					fishElem.style.MozTransform=rotate;
					fishElem.style.transform=rotate;
				}
			} else {
				if (fishDirection=='up'){
					fishLeft=fishLeft-mv*ratio*.7;//roughly sqrt(2)
					fishTop=fishTop-mv*ratio*.7;
					if (fishTop<topBorder){
						fishDirection='down';
					}
				} else if (fishDirection=='down'){
					fishLeft=fishLeft-mv*ratio*.7;
					fishTop=fishTop+mv*ratio*.7;
					if (fishTop>bottomBorder){
						fishDirection='up';
					}
				} else {
					fishLeft=fishLeft-mv*ratio;
				}
				fishLeft=fishLeft-mv*ratio;
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
			disturb(fishLeft+12*ratio, fishTop+9*ratio);
		}

		fishInterval=setInterval(animateFish, 20);
	    
	}

    function onResize(){
	    clearInterval(fishInterval);
	    clearInterval(runInterval);
	    //clearInterval(waterfallInterval);
	    fishLeft=fishLeft/ratio;
	    fishTop=fishTop/ratio;
	    /*var oldRatio=ratio;
    	width = window.innerWidth;
        height = window.innerHeight;
	    canvas.width = width;
	    canvas.height = height;
	    ratio = width/fullWidth;
		//ctx.drawImage(img, 0, 0, img.width, img.height*displayedHeight, 0, 0, width, height);
	    texture = ctx.getImageData(0, 0, width, height);
	    ripple = ctx.getImageData(0, 0, width, height);
		fishLeft=fishLeft*ratio/oldRatio;
		fishTop=fishTop*ratio/oldRatio;
		//fishElem.style.width=24*ratio;
		//fishElem.style.height=17*ratio;
		fishElem.style.left=fishLeft+'px';
		fishElem.style.top=fishTop+'px';
		topBorder=850*ratio;
		bottomBorder=1030*ratio;
		leftBorder=400*ratio;
		rightBorder=1750*ratio;
		ripplemap = [];
        last_map = [];*/
	    
	    /*for (var i = 0; i < size; i++) {
	        last_map[i] = ripplemap[i] = 0;
	    }*/
	    //runInterval=setInterval(run, delay);
		//fishInterval=setInterval(animateFish, 10);
	    waterRipple();
	    //var newimg=new Image();
	    //newimg.src=canvas.toDataURL();
	    //processImage(newimg);
	    //animate();
	 }

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
  		<button onclick="onResize()">Animate</button>
		<h1>Welcome to my site!</h1>
	</div>
	</div>
	<img id="fish" src="img/sprites/crab-1.png">
	<script>waterRipple()</script>
	
</body>
</html>