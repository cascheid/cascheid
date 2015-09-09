
var canvas = document.getElementById('bodyCanvas');
var rctx;
var w;
var h;
var init;
var maxParts;
var rainParticles;
var rlb;
var rtb;

function initRain(left, right, top, bottom, parts, lwidth){
  
  if(canvas.getContext) {
    rctx = canvas.getContext('2d');
    w = right-left;
    h = bottom-top;
    rlb=left;
    rtb=top;
    rctx.strokeStyle = 'rgba(174,194,224,0.5)';
    rctx.lineWidth = lwidth;
    rctx.lineCap = 'round';
    
    
    init = [];
    maxParts = parts;
    for(var a = 0; a < maxParts; a++) {
      init.push({
        x: left+Math.random() * w,
        y: top+Math.random() * h,
        l: Math.random() * 1,
        xs: -4 + Math.random() * 4 + 2,
        ys: Math.random() * 10 + 10
      })
    }
    
    rainParticles = [];
    for(var b = 0; b < maxParts; b++) {
      rainParticles[b] = init[b];
    }
    
    //setInterval(draw, 30);
    
  }
};

function drawRain() {
  //rctx.clearRect(rlb, rtb, w, h);
  for(var c = 0; c < rainParticles.length; c++) {
    var p = rainParticles[c];
    rctx.beginPath();
    rctx.moveTo(p.x, p.y);
    rctx.lineTo(p.x + p.l * p.xs, p.y + p.l * p.ys);
    rctx.stroke();
  }
  move();
}

function move() {
  for(var b = 0; b < rainParticles.length; b++) {
    var p = rainParticles[b];
    p.x += p.xs;
    p.y += p.ys;
    if(p.x > rlb+w || p.y > rtb+h) {
      p.x = rlb+Math.random() * w;
      p.y = rtb-20;
    }
  }
}