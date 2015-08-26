// Create an array to store our particles
var particles = [];

// The amount of particles to render
var particleCount;

// The maximum velocity in each direction
var maxVelocity = 2;

// The target frames per second (how often do we want to update / redraw the scene)
var targetFPS = 40;

// Set the dimensions of the canvas as variables so they can be used.
var canvasWidth;
var canvasHeight;
var leftBound;
var rightBound;
var topBound;
var bottomBound;
var size;


// A function to create a particle object.
function Particle(context) {

    // Set the initial x and y positions
    this.x = 0;
    this.y = 0;

    // Set the initial velocity
    this.xVelocity = 0;
    this.yVelocity = 0;

    // Set the radius
    this.radius = 5;

    // Store the context which will be used to draw the particle
    this.context = context;

    // The function to draw the particle on the canvas.
    this.draw = function() {
        // If an image is set draw it
        if(this.image){
            //this.context.drawImage(this.image, leftBound+this.x-128, topBound+this.y-128, 35, 35);  
            this.context.drawImage(this.image, leftBound+this.x, topBound+this.y, size, size);         
            // If the image is being rendered do not draw the circle so break out of the draw function                
            return;
        }
        // Draw the circle as before, with the addition of using the position and the radius from this object.
        /*this.context.beginPath();
        this.context.arc(this.x, this.y, this.radius, 0, 2 * Math.PI, false);
        this.context.fillStyle = "rgba(0, 255, 255, 1)";
        this.context.fill();
        this.context.closePath();*/
    };

    // Update the particle.
    this.update = function() {
        // Update the position of the particle with the addition of the velocity.
        this.x += this.xVelocity;
        this.y += this.yVelocity;

        // Check if has crossed the right edge
        if (this.x >= canvasWidth) {
            this.xVelocity = -this.xVelocity;
            this.x = canvasWidth;
        }
        // Check if has crossed the left edge
        else if (this.x <= 0) {
            this.xVelocity = -this.xVelocity;
            this.x = 0;
        }

        // Check if has crossed the bottom edge
        if (this.y >= canvasHeight) {
            this.yVelocity = -this.yVelocity;
            this.y = canvasHeight;
        }
        
        // Check if has crossed the top edge
        else if (this.y <= 0) {
            this.yVelocity = -this.yVelocity;
            this.y = 0;
        }
    };

    // A function to set the position of the particle.
    this.setPosition = function(x, y) {
        this.x = x;
        this.y = y;
    };

    // Function to set the velocity.
    this.setVelocity = function(x, y) {
        this.xVelocity = x;
        this.yVelocity = y;
    };
    
    this.setImage = function(image){
        this.image = image;
    }
}

// A function to generate a random number between 2 values
function generateRandom(min, max){
    return Math.random() * (max - min) + min;
}

// The canvas context if it is defined.
var context;

// Initialise the scene and set the context if possible
function initMist(left, right, top, bottom, imgsize, count) {
    var canvas = document.getElementById('bodyCanvas');
    if (canvas.getContext) {
    	leftBound=left;
    	rightBound=right;
    	topBound=top;
    	bottomBound=bottom;
    	size=imgsize;
    	canvasWidth=rightBound-leftBound;
    	canvasHeight=bottomBound-topBound;

        // Set the context variable so it can be re-used
        context = canvas.getContext('2d');
        //mainImg.src='http://thelionkingvideos.weebly.com/uploads/4/6/7/1/4671811/4045903_orig.jpg';
        //mainImg.style.height='400px';
		//context.drawImage(mainImg, 0, 0, mainImg.width, mainImg.height, 0, 0, 400, 400 );

        // Create the particles and set their initial positions and velocities
        particles = [];
        maxVelocity=imgsize/18;
        particleCount=count;
        for(var i=0; i < particleCount; ++i){
            var particle = new Particle(context);
            
            // Set the position to be inside the canvas bounds
            particle.setPosition(generateRandom(0, canvasWidth), generateRandom(0, canvasHeight));
            
            // Set the initial velocity to be either random and either negative or positive
            particle.setVelocity(generateRandom(-maxVelocity, maxVelocity), generateRandom(-maxVelocity, maxVelocity));
            particles.push(particle);            
        }

        
        // Create an image object (only need one instance)
        var imageObj = new Image();

        // Once the image has been downloaded then set the image on all of the particles
        imageObj.onload = function() {
            particles.forEach(function(particle) {
                    particle.setImage(imageObj);
            });
        };

        // Once the callback is arranged then set the source of the image
        imageObj.src = "img/misc/mist.png";
        /*setInterval(function() {
            // Update the scene befoe drawing
            update();
            // Draw the scene

            draw();
        }, 1000 / targetFPS);*/
    }
    else {
        alert("Please use a modern browser");
    }
}

// The function to draw the scene
function drawMist() {
    // Clear the drawing surface and fill it with a black background
    //context.fillStyle = "rgba(0, 0, 0, 0.5)";
    //context.fillRect(0, 0, 400, 400);

    // Go through all of the particles and draw them.           
    //context.drawImage(mainImg, 0, 0, mainImg.width, mainImg.height, 0, 0, 400, 400 );
    particles.forEach(function(particle) {
        particle.draw();
    });
}

// Update the scene
function updateMist() {
    particles.forEach(function(particle) {
        particle.update();
    });
}

// Initialize the scene
//init();