
THREE.BBPlayer = function (player, startingPos, triggerCallback) {

	var scope = this;
	var sqrt2=Math.sqrt(2);
	var moveScale=12;
	var origin = new THREE.Vector3(0.1,0.1,0.1);
	var sphereRadius=100;
	
	this.triggerCallback=triggerCallback;
	this.level=3;
	this.name='Test Player';
	this.speed=60;
	this.endurance=15;
	this.hp=1150;
	this.attack=10;
	this.pass=15;
	this.shot=70;
	this.block=10;
	this.cat=10;
	this.techs=[];
	/*this.level=player.level;
	this.name=player.name;
	this.speed = player.speed;
	this.endurance=player.endurance;
	this.hp=player.hp;
	this.attack=player.attack;
	this.pass=player.pass;
	this.shot=player.shot;
	this.block=player.block;
	this.cat=player.cat;
	this.techs=[];
	if (player.tech1!=null){
		this.techs.push(player.tech1);
	}
	if (player.tech2!=null){
		this.techs.push(player.tech2);
	}
	if (player.tech3!=null){
		this.techs.push(player.tech3);
	}
	if (player.tech4!=null){
		this.techs.push(player.tech4);
	}
	if (player.tech5!=null){
		this.techs.push(player.tech5);
	}*/
	this.restingPosition = startingPos.clone();//Vector3
	this.currentPosition = startingPos;
	this.chasingPosition = null;
	this.currentRotation=0;//Math.PI/2;
	this.myGoal = new THREE.Vector3(-100, 0, 0);
	if (startingPos.x>0){
		this.currentRotation=Math.PI//-1*Math.PI/2;
		this.myGoal.x=100;
	}
	this.has3DModel=false;
	this.hasBall=false;
	this.root=null;
	this.animation=null;
	this.ballAnimation=null;
	this.speedUpChase=false;
	this.gameActive=false;
	this.rotationTarget=null;
	this.ball=null;
	this.fieldOfVision=40;
	this.brawler=false;
	for (var i = 0; i < this.techs.length; i++) {
        if (this.techs[i].techID === 50){//Elite Defense
            this.fieldOfVision=55;
        } else if (this.techs[i].techID == 51){
        	this.brawler=true;
        }
    }

	// internal helper variables

	this.loadPlayer = function (callback){
		scope.callback=callback;
		var loader = new THREE.ColladaLoader();
		loader.options.convertUpAxis = true;
		loader.load( 'obj/stormtrooper/stormtrooper19.dae', function ( collada ) {

			scope.root = collada.scene;
			scope.has3DModel=true;
			var playerModel = scope.root.children[1];
			playerModel.children[0].material.side=THREE.DoubleSide;
			scope.animation= new THREE.BBAnimation( scope, playerModel.children[0].geometry.animation, scope.speed, false );
			scope.ball = scope.root.children[3];
			scope.ball.children[0].material.side=THREE.DoubleSide;
			scope.ball.visible=false;
			scope.ballAnimation= new THREE.BBAnimation( scope.ball.children[0], scope.ball.children[0].geometry.animation, scope.speed, true );

			/*scope.root.traverse( function ( child ) {

				if ( child instanceof THREE.SkinnedMesh ) {

					if (child.parent.name=='blitzball'){
						scope.animation = new THREE.BBAnimation( object3d.children[0], object3d.children[0].geometry.animation, scope.speed );
					} else {
						scope.animation = new THREE.BBAnimation( object3d.children[0], object3d.children[0].geometry.animation, scope.speed );
					}

				}

			} );*/
			
			scope.root.position.x = scope.currentPosition.x;
			scope.root.position.y = -1;
			scope.root.position.z = scope.currentPosition.z;
			scope.root.rotation.y = scope.currentRotation+Math.PI/2;
			scope.root.scale.x = scope.root.scale.y = scope.root.scale.z = 2;
			scope.root.updateMatrix();

			if ( scope.callback ) {
				scope.callback();
			}
		} );
	}
	
	this.zoomChase = function(percentage){
		this.currentPosition.add(this.chasingPosition.clone().sub(this.currentPosition).multiplyScalar(percentage));
		this.root.position.x=this.currentPosition.x;
		this.root.position.z=this.currentPosition.z;
	}
	
	this.updatePlayer = function(delta, controls){
		var trajectory;
		this.animation.resetBlendWeights();
		this.animation.update(delta);
		if (this.ball.visible){
			this.ballAnimation.resetBlendWeights();
			this.ballAnimation.update(delta);
		}
		if (this.hasBall){
			if (controls.moveForward&&!controls.moveBackward){
				if (controls.moveLeft&&!controls.moveRight){
					trajectory=new THREE.Vector3(-1*moveScale*sqrt2*(this.speed/60)*delta, 0, -1*moveScale*sqrt2*(this.speed/60)*delta);
				} else if (controls.moveRight&&!controls.moveLeft){
					trajectory=new THREE.Vector3(moveScale*sqrt2*(this.speed/60)*delta, 0, -1*moveScale*sqrt2*(this.speed/60)*delta);
				} else {
					trajectory=new THREE.Vector3(0, 0, -1*moveScale*(this.speed/60)*delta);
				}
			} else if (controls.moveBackward&&!controls.moveForward){
				if (controls.moveLeft&&!controls.moveRight){
					trajectory=new THREE.Vector3(-1*moveScale*sqrt2*(this.speed/60)*delta, 0, moveScale*sqrt2*(this.speed/60)*delta);
				} else if (controls.moveRight&&!controls.moveLeft){
					trajectory=new THREE.Vector3(moveScale*sqrt2*(this.speed/60)*delta, 0, moveScale*sqrt2*(this.speed/60)*delta);
				} else {
					trajectory=new THREE.Vector3(0, 0, moveScale*(this.speed/60)*delta);
				}
			} else if (controls.moveLeft&&!controls.moveRight){
				trajectory=new THREE.Vector3(-1*moveScale*(this.speed/60)*delta, 0, 0);
			} else if (controls.moveRight&&!controls.moveLeft){
				trajectory=new THREE.Vector3(moveScale*(this.speed/60)*delta, 0, 0);
			}
		} else {
			if (this.gameActive&&this.chasingPosition!=null){
					trajectory=this.chasingPosition.clone().sub(this.currentPosition);
					if (trajectory.length()<5&&this.gameActive){
						this.triggerEncounter();
					}
			} else if (this.gameActive&&(this.restingPosition.x!=this.currentPosition.x||this.restingPosition.z!=this.currentPosition.z)){
				trajectory=this.restingPosition.clone().sub(this.currentPosition);
			}
		}
		if (trajectory!=null){
			var maxMove=moveScale*(this.speed/60)*delta;
			if (this.speedUpChase){
				maxMove*=10;
			}
			var lengthLeft=trajectory.length();
			if (maxMove<lengthLeft){
				trajectory = trajectory.multiplyScalar(maxMove/lengthLeft);
			}
			this.checkSphereBounds(trajectory);
			
			var newRot = Math.atan2(-1*trajectory.z, trajectory.x);
			this.currentRotation=newRot;//position seems to be based off of vertical axis, not horizontal
			if (this.currentRotation<0){
				this.currentRotation+=Math.PI*2;
			}
			this.root.rotation.y=this.currentRotation+Math.PI/2;

			if (this.animation.animPlaying!="swim"){
				this.playSwimAnimation();
			}
		} else if (this.animation.animPlaying=="swim"){
			this.playTreadAnimation();
		}
		if (this.rotationTarget!=null){
			var rotToGo=this.rotationTarget-this.currentRotation;
			var maxRot=2*Math.PI*delta;
			if (maxRot>=Math.abs(rotToGo)){
				this.currentRotation=this.rotationTarget;
				this.rotationTarget=null;
			} else {
				//this.currentRotation+=maxRot;
				if (rotToGo<0){
					this.currentRotation-=maxRot;
				} else {
					this.currentRotation+=maxRot;
				}
			}
			this.root.rotation.y=this.currentRotation+Math.PI/2;
		}
		this.root.position.x=this.currentPosition.x;
		this.root.position.z=this.currentPosition.z;
	}
	
	this.lookAt = function(vector){
		this.rotationTarget=Math.atan2(-1*(vector.z-this.currentPosition.z), vector.x-this.currentPosition.x);
		if (this.rotationTarget<0){
			this.rotationTarget+=Math.PI*2;
		}
	}
	
	this.playTreadAnimation = function(){
		this.animation.playTreadAnimation();
		if (this.hasBall){
			this.ballAnimation.playTreadAnimation();
		}
	}
	
	this.playGoalieTreadAnimation = function(){
		this.animation.playGoalieTreadAnimation();
	}
	
	this.playSwimAnimation = function(){
		this.animation.playSwimAnimation();
		if (this.hasBall){
			this.ballAnimation.playSwimAnimation();
		}
	}
	
	this.animateGrabBall = function(callback, interimCallback){
		this.hasBall=true;
		this.ball.visible=true;
		this.animation.playGrabBallAnimation(null);
		this.ballAnimation.playGrabBallAnimation(interimCallback);
		this.ballAnimation.callback=callback;
	}
	
	this.animateBlockFail = function(callback, interimCallback){
		this.ball.visible=true;
		this.animation.playGrabBallAnimation(null);
		this.ballAnimation.playGrabBallAnimation(interimCallback);
		this.ballAnimation.callback=callback;
	}
	
	this.animateCatchBall = function(callback){
		this.hasBall=true;
		this.ball.visible=true;
		//this.animation.playGrabBallAnimation();
		//this.ballAnimation.playGrabBallAnimation();
		this.animation.playCatchAnimation();
		this.ballAnimation.playCatchAnimation();
		this.ballAnimation.callback=callback;
	}
	
	this.animateDropCatch = function(callback){
		this.ball.visible=true;
		this.animation.playDropCatchAnimation();
		this.ballAnimation.playDropCatchAnimation();
		this.ballAnimation.callback=function(){scope.ball.visible=false; callback()};
	}
	
	this.animateShoot = function(callback){
		this.animation.playShootAnimation();
		this.ballAnimation.playShootAnimation();
		this.ballAnimation.callback=function(){scope.ball.visible=false; callback();};
	}
	
	this.animatePass = function(callback){
		this.animation.playPassAnimation(null);
		this.ballAnimation.playPassAnimation(function(){scope.ball.visible=false;});
		this.animation.callback=callback;
	}
	
	this.animateGoalieTread = function(){
		//this.animation.playGoalieAnimation();
	}
	
	this.animateGoalieSave = function(callback){
		this.ball.visible=true;
		this.animation.playGoalieSaveAnimation(null);
		this.ballAnimation.playGoalieSaveAnimation(callback);
	}
	
	this.animateGoalieFailSave = function(gameball, callback){
		this.ball.visible=true;
		this.animation.playGoalieSaveAnimation(null);
		this.ballAnimation.playBallGoalieFailSaveAnimation();
		this.ballAnimation.callback = function(){
			if (scope.currentPosition.x<0){
				gameball.position.set(-97, 3, 4);
			} else {
				gameball.position.set(97, 3, -4);
			}
			gameball.visible=true;
			scope.ball.visible=false;
		}
		this.animation.callback=callback;
	}
	
	this.continueGoalieSave = function(grabbedBall, callback){
		//TODO change animation for deflect
		this.ballAnimation.callback=callback;
	}
	
	this.continueBreak = function(callback){
		this.animation.callback=callback;
	}
	
	this.animateEndure = function(callback){
		this.animation.playEndureAnimation(null);
		this.ballAnimation.playEndureAnimation(callback);
		//this.ballAnimation.callback=callback;
	}
	
	this.continueEndure = function(keptBall, callback){
		if (!keptBall){
			this.ball.visible=false;
			this.hasBall=false;
		}
		this.animation.callback=callback;
	}
	
	this.animateTackle = function(target){
		this.animation.playTackleAnimation(target);
		this.ballAnimation.playTackleAnimation(target);
	}
	
	this.continueTackle = function(wonBall){
		if (wonBall){
			this.ball.visible=true;
			this.hasBall=true;
			this.ballAnimation.currentTime=this.animation.currentTime;
		}
		//this.ballAnimation.callback=callback;
	}
	
	this.lostBall = function(callback){
		this.hasBall=false;
		this.animation.callback=callback;
	}
	
	this.checkSphereBounds = function(trajectory){
		if ((trajectory.x+this.currentPosition.x)*(trajectory.x+this.currentPosition.x)
				+(trajectory.z+this.currentPosition.z)*(trajectory.z+this.currentPosition.z)<sphereRadius*sphereRadius){
			this.currentPosition.x+=trajectory.x;
			this.currentPosition.z+=trajectory.z;
		} else if (this.currentPosition.x>0){//on the right side
			if (this.currentPosition.z>0){//right bottom
				if (trajectory.x>0){//going right
					if (trajectory.z<=0){//slide up
						var xBorder = Math.sqrt(sphereRadius*sphereRadius-this.currentPosition.z*this.currentPosition.z);
						var lengthLeft=trajectory.length()-(xBorder-this.currentPosition.x);
						var addedAngle = Math.asin((lengthLeft)/sphereRadius);
						var oldAngle = Math.atan2(-1*this.currentPosition.z, xBorder);
						this.currentPosition.x=(sphereRadius*Math.cos(addedAngle+oldAngle));
						this.currentPosition.z=-1*(sphereRadius*Math.sin(addedAngle+oldAngle));
					}
				} else if (trajectory.z>0){//going down, slide left
					var yBorder = -1*Math.sqrt(sphereRadius*sphereRadius-this.currentPosition.x*this.currentPosition.x);
					var lengthLeft=trajectory.length()-(-1*yBorder-this.currentPosition.z);
					var subAngle = Math.asin((lengthLeft)/sphereRadius);
					var oldAngle = Math.atan2(yBorder, this.currentPosition.x);
					this.currentPosition.x=(sphereRadius*Math.cos(oldAngle-subAngle));
					this.currentPosition.z=-1*(sphereRadius*Math.sin(oldAngle-subAngle));
				}
			} else if (this.currentPosition.z<0){//right top
				if (trajectory.x>0){//going right
					if (trajectory.z>=0){//slide down
						var xBorder = Math.sqrt(sphereRadius*sphereRadius-this.currentPosition.z*this.currentPosition.z);
						var lengthLeft=trajectory.length()-(xBorder-this.currentPosition.x);
						var subAngle = Math.asin((lengthLeft)/sphereRadius);
						var oldAngle = Math.atan2(-1*this.currentPosition.z, xBorder);
						this.currentPosition.x=(sphereRadius*Math.cos(oldAngle-subAngle));
						this.currentPosition.z=-1*(sphereRadius*Math.sin(oldAngle-subAngle));
					}
				} else if (trajectory.z<0){//going up, slide left
					var yBorder = Math.sqrt(sphereRadius*sphereRadius-this.currentPosition.x*this.currentPosition.x);
					var lengthLeft=trajectory.length()-(yBorder+this.currentPosition.z);
					var addAngle = Math.asin((lengthLeft)/sphereRadius);
					var oldAngle = Math.atan2(yBorder, this.currentPosition.x);
					this.currentPosition.x=(sphereRadius*Math.cos(oldAngle+addAngle));
					this.currentPosition.z=-1*(sphereRadius*Math.sin(oldAngle+addAngle));
				}
			}
		} else {//on the left side
			if (this.currentPosition.z>0){//left bottom
				if (trajectory.x<0){//going left
					if (trajectory.z<=0){//slide up
						var xBorder = -1*Math.sqrt(sphereRadius*sphereRadius-this.currentPosition.z*this.currentPosition.z);
						var lengthLeft=trajectory.length()-(-1*xBorder+this.currentPosition.x);
						var subAngle = Math.asin((lengthLeft)/sphereRadius);
						var oldAngle = Math.atan2(-1*this.currentPosition.z, xBorder);
						this.currentPosition.x=(sphereRadius*Math.cos(oldAngle-subAngle));
						this.currentPosition.z=-1*(sphereRadius*Math.sin(oldAngle-subAngle));
					}
				} else if (trajectory.z>0){//going down, slide right
					var yBorder = -1*Math.sqrt(sphereRadius*sphereRadius-this.currentPosition.x*this.currentPosition.x);
					var lengthLeft=trajectory.length()-(-1*yBorder-this.currentPosition.z);
					var addAngle = Math.asin((lengthLeft)/sphereRadius);
					var oldAngle = Math.atan2(yBorder, this.currentPosition.x);
					this.currentPosition.x=(sphereRadius*Math.cos(oldAngle+addAngle));
					this.currentPosition.z=-1*(sphereRadius*Math.sin(oldAngle+addAngle));
				}
			} else if (this.currentPosition.z<0){//left top
				if (trajectory.x<0){//going left
					if (trajectory.z>=0){//slide down
						var xBorder = -1*Math.sqrt(sphereRadius*sphereRadius-this.currentPosition.z*this.currentPosition.z);
						var lengthLeft=trajectory.length()-(-1*xBorder+this.currentPosition.x);
						var addAngle = Math.asin((lengthLeft)/sphereRadius);
						var oldAngle = Math.atan2(-1*this.currentPosition.z, xBorder);
						this.currentPosition.x=(sphereRadius*Math.cos(oldAngle+addAngle));
						this.currentPosition.z=-1*(sphereRadius*Math.sin(oldAngle+addAngle));
					}
				} else if (trajectory.z<0){//going up, slide right
					var yBorder = Math.sqrt(sphereRadius*sphereRadius-this.currentPosition.x*this.currentPosition.x);
					var lengthLeft=trajectory.length()-(yBorder+this.currentPosition.z);
					var subAngle = Math.asin((lengthLeft)/sphereRadius);
					var oldAngle = Math.atan2(yBorder, this.currentPosition.x);
					this.currentPosition.x=(sphereRadius*Math.cos(oldAngle-subAngle));
					this.currentPosition.z=-1*(sphereRadius*Math.sin(oldAngle-subAngle));
				}
			}
		}
	}
	
	this.testEncounter = function(playerLocation, existingDefCount){
		var distToPlayer = this.currentPosition.distanceTo(playerLocation);
		if (distToPlayer<20||(this.brawler&&this.distToPlayer<50&&Math.random()<.6)){
			this.chasingPosition=null;
			return true;
		} else {
			return false;
		}
	}
	
	this.testViewBallCarrier = function(ballLocation){
		var distToCarrier = this.currentPosition.distanceTo(ballLocation);
		if (distToCarrier<=this.fieldOfVision){
			this.chasingPosition=ballLocation;
		} else {
			this.chasingPosition=null;
		}
	}
	
	this.triggerEncounter = function(){
		this.chasingPosition=null;
		this.triggerCallback();
	}
};
