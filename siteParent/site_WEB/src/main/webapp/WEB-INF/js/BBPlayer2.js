
THREE.BBPlayer = function (player, startingPos, is3d) {

	var scope = this;
	var sqrt2=Math.sqrt(2);
	var moveScale=0.5;
	var origin = new THREE.Vector3(0.1,0.1,0.1);
	var sphereRadius=100;
	
	this.level=3;
	this.name='Test Player';
	this.speed=99;
	this.endurance=10;
	this.hp=150;
	this.attack=10;
	this.pass=10;
	this.shot=10;
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
	this.currentRotation=0;
	if (startingPos.x>0){
		this.currentRotation=Math.PI;
	}
	this.has3DModel=is3d;
	this.hasBall=false;
	this.root=null;
	this.animation=null;

	// internal helper variables

	this.loaded = false;

	this.loadPlayer = function (callback){
		scope.callback=callback;
		var loader = new THREE.ColladaLoader();
		loader.options.convertUpAxis = true;
		loader.load( 'obj/stormtrooper/stormtrooper.dae', function ( collada ) {

			scope.root = collada.scene;
			//scope.root.position = scope.currentPosition;
			var object3d = scope.root.children[1];
			//trooper.children[0].material.reflectivity=0;
			//trooper.children[0].material.shininess=0;
			object3d.children[0].material.side=THREE.DoubleSide;
			scope.animation= new THREE.BBAnimation( object3d.children[0], object3d.children[0].geometry.animation, scope.speed );
			//myAnimation.play();

			scope.root.position.x = scope.currentPosition.x;
			scope.root.position.z = scope.currentPosition.z;
			scope.root.scale.x = scope.root.scale.y = scope.root.scale.z = 2;
			scope.root.updateMatrix();

			//scene.add( dae );

			if ( scope.callback ) {
				scope.callback();
			}
		} );
	}
	
	this.updatePlayer = function(delta, controls){
		var trajectory;
		this.animation.resetBlendWeights();
		this.animation.update(delta);
		if (this.hasBall){
			if (controls.moveForward&&!controls.moveBackward){
				if (controls.moveLeft&&!controls.moveRight){
					trajectory=new THREE.Vector3(-1*moveScale*sqrt2*this.speed*delta, 0, moveScale*sqrt2*this.speed*delta);
				} else if (controls.moveRight&&!controls.moveLeft){
					trajectory=new THREE.Vector3(moveScale*sqrt2*this.speed*delta, 0, moveScale*sqrt2*this.speed*delta);
				} else {
					trajectory=new THREE.Vector3(0, 0, moveScale*this.speed*delta);
				}
			} else if (controls.moveBackward&&!controls.moveForward){
				if (controls.moveLeft&&!controls.moveRight){
					trajectory=new THREE.Vector3(-1*moveScale*sqrt2*this.speed*delta, 0, -1*moveScale*sqrt2*this.speed*delta);
				} else if (controls.moveRight&&!controls.moveLeft){
					trajectory=new THREE.Vector3(moveScale*sqrt2*this.speed*delta, 0, -1*moveScale*sqrt2*this.speed*delta);
				} else {
					trajectory=new THREE.Vector3(0, 0, -1*moveScale*this.speed*delta);
				}
			} else if (controls.moveLeft&&!controls.moveRight){
				trajectory=new THREE.Vector3(-1*moveScale*this.speed*delta, 0, 0);
			} else if (controls.moveRight&&!controls.moveLeft){
				trajectory=new THREE.Vector3(moveScale*this.speed*delta, 0, 0);
			}
		} else {
			if (this.restingPosition.x!=this.currentPosition.x||this.restingPosition.z!=this.currentPosition.z){
				trajectory=this.restingPosition.clone().sub(this.currentPosition);
			}
		}
		if (trajectory!=null){
			var maxMove=moveScale*this.speed*delta;
			var lengthLeft=trajectory.length();
			trajectory = checkSphereBounds(trajectory);
			if (maxMove>=lengthLeft){
				this.newPosition.addVectors(this.currentPosition, trajectory);
			} else {
				var scale = maxMove/lengthLeft;
				var mv = trajectory.multiplyScalar(scale);
				this.newPosition.addVectors(this.currentPosition, mv);
			}
			var newRot = Math.atan2(trajectory.z, trajectory.x);
			this.currentRotation=newRot;
			if (this.loaded){
				this.root.lookAt(this.currentPosition);
				this.root.position=this.currentPosition;
			}
			if (this.animation.animPlaying!="swim"){
				this.animation.playSwimAnimation();
			}
			this.root.position.x=this.currentPosition.x;
			this.root.position.z=this.currentPosition.z;
		} else if (this.animation.animPlaying=="swim"){
			this.animation.playTreadAnimation();
		}
	}
	
	this.playTreadAnimation = function(){
		this.animation.playTreadAnimation();
	}
	
	function checkSphereBounds(trajectory){
		if ((trajectory.x+this.currentPosition.x)*(trajectory.x+this.currentPosition.x)
				+(trajectory.z+this.currentPosition.z)*(trajectory.z+this.currentPosition.z)<sphereRadius*sphereRadius){
			this.currentPosition.x=this.newPosition.x;
			this.currentPosition.z=this.newPosition.z;
			this.newPosition=null;
		} else if (this.currentPosition.x>0){
			if (trajectory.x>0&&trajectory.z==0){//going right
				if (this.currentPosition.z>0){//slide up
					trajectory.x=trajectory.x*sqrt2;
					trajectory.z=0-trajectory.x;
				} else if (this.currentPosition.z<0){//slide down
					trajectory.x=trajectory.x*sqrt2;
					trajectory.z=trajectory.x;
				}
			} else if (trajectory.x==0){//going down or up, slide left
				trajectory.z=trajectory.z*sqrt2;
				trajectory.x=0-Math.abs(trajectory.z*sqrt2);
			}
		} else if (this.currentPosition.x<0){
			if (trajectory.x<0&&trajectory.z==0){//going left
				if (this.currentPosition.z>0){//slide up
					trajectory.x=trajectory.x*sqrt2;
					trajectory.z=0-trajectory.x;
				} else if (this.currentPosition.z<0){//slide down
					trajectory.x=trajectory.x*sqrt2;
					trajectory.z=trajectory.x;
				}
			} else if (trajectory.x==0){//going down or up, slide right
				trajectory.z=trajectory.z*sqrt2;
				trajectory.x=Math.abs(trajectory.z*sqrt2);
			}
		}
		return trajectory;
	}
};
