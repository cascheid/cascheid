<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="css/racing.css">
<style>
	body{overflow:hidden;}
	div.tracklap1 {float:left; width:100px; height:650px; background: lightblue url ("../img/misc/one.png") no-repeat 50% 50%; }
	div.tracklap2 {float:left; width:100px; height:650px; background: seagreen url ("../img/misc/two.png") no-repeat 50% 50%; }
	div.tracklap3 {float:left; width:100px; height:650px; background: royalblue url ("../img/misc/three.png") no-repeat 50% 50%; }
	div.tracklap4 {float:left; width:100px; height:650px; background: lightsalmon url ("../img/misc/four.png") no-repeat 50% 50%; }
	div.tracklap5 {float:left; width:100px; height:650px; background: indianred url ("../img/misc/five.png") no-repeat 50% 50%; }
	div.splits {float:left; margin-left:0px; width:70px; height:650px; background-color: lightgreen;}
	div.middle {float:left; margin-left:0px; width:99px; height:650px; background-color: lightgreen;}
	img.car {position:absolute;
	bottom:50px;
	-webkit-transform: rotate(270deg);
    -moz-transform: rotate(270deg);
    -o-transform: rotate(270deg);
    -ms-transform: rotate(270deg);
    transform: rotate(270deg);
    width:100px;
    height:50px;
	}
	
	img.bowser{position:absolute;
	width:99px;
	height:69px;
	bottom:800px;}
	
	img.yoshi{position:absolute;
	width:108px;
	height:78px;
	bottom:350px;
	margin-left:-53px;}
	
	img.yoshiflip{position:absolute;
	width:108px;
	height:78px;
	bottom:350px;
	margin-left:15px;
	-moz-transform: scaleX(-1);
    -o-transform: scaleX(-1);
    -webkit-transform: scaleX(-1);
    transform: scaleX(-1);
    filter: FlipH;
    -ms-filter: "FlipH";}
	
	img.crab{position:absolute;
	width:48px;
	height:34px;}
	
	img.peach{position:absolute; 
	width:60px; 
	height:76px;
	bottom:400px;
	margin-left:-60px;}
	
	img.mario{position:absolute; 
	width:60px; 
	height:76px;
	bottom:400px;
	margin-left:60px;}
</style>
</head>
<body>
	<h3>Class: ${raceInfo.racingClass}  Lap Length: ${raceInfo.lapDistance}  Number of Laps: ${raceInfo.noLaps}</h3>
	
	<script>
		var finishedRace=false;
		function startRace(){
			var distance=${raceInfo.lapDistance*raceInfo.noLaps};
			var lapDistance=${raceInfo.lapDistance};
			var elapsedTime=0;
			var firstPlace=null;
			var secondPlace=null;
			var thirdPlace=null;
			
			var car1Accel=${racer1.acceleration};
			var car2Accel=${racer2.acceleration};
			var car3Accel=${racer3.acceleration};
			var car4Accel=${racer4.acceleration};
			
			var car1TopSpeed=${racer1.topSpeed*(1-((1-racer1.reliability)*Math.random()))};
			var car2TopSpeed=${racer2.topSpeed*(1-((1-racer2.reliability)*Math.random()))};
			var car3TopSpeed=${racer3.topSpeed*(1-((1-racer3.reliability)*Math.random()))};
			var car4TopSpeed=${racer4.topSpeed*(1-((1-racer4.reliability)*Math.random()))};
			
			var car1LapEfficiency=${racer1.lapEfficiency};
			var car2LapEfficiency=${racer2.lapEfficiency};
			var car3LapEfficiency=${racer3.lapEfficiency};
			var car4LapEfficiency=${racer4.lapEfficiency};

			var car1Location=0;
			var car2Location=0;
			var car3Location=0;
			var car4Location=0;

			var car1Lap=1;
			var car2Lap=1;
			var car3Lap=1;
			var car4Lap=1;

			var car1CurVelocity=0;
			var car2CurVelocity=0;
			var car3CurVelocity=0;
			var car4CurVelocity=0;

			var car1Egged=false;
			var car2Egged=false;
			var car3Egged=false;
			var car4Egged=false;

			var yoshi1Face="left";
			var yoshi2Face="right";

			var yoshi1Active=false;
			var yoshi2Active=false;
			var yoshiHatesCar1=false;
			var yoshiHatesCar2=false;
			var yoshiHatesCar3=false;
			var yoshiHatesCar4=false;
			if (Math.random()<.25){
				yoshiHatesCar1=true;
			}
			if (Math.random()<.25){
				yoshiHatesCar2=true;
			}
			if (Math.random()<.25){
				yoshiHatesCar3=true;
			}
			if (Math.random()<.25){
				yoshiHatesCar4=true;
			}
			var car1Counter=0;
			var car2Counter=0;
			var car3Counter=0;
			var car4Counter=0;
			var yoshiid1;
			var yoshiid2;
			var yoshiid3;
			var yoshiid4;
			function yoshiEat(carNum){
				var bYoshiReturn=false;
				var yoshiElem;
				var yoshiEatLoop;
				if (carNum==1 || carNum==2){
					yoshiElem = document.getElementById("yoshi1");
					if (carNum==1){
						car1Counter+=1;
						yoshiEatLoop=car1Counter;
					} else {
						car2Counter+=1;
						yoshiEatLoop=car2Counter;
					}
				} else {
					yoshiElem = document.getElementById("yoshi2");
					if (carNum==3){
						car3Counter+=1;
						yoshiEatLoop=car3Counter;
					} else {
						car4Counter+=1;
						yoshiEatLoop=car4Counter;
					}
				}
				var carElem = document.getElementById("car"+carNum);
				if (yoshiEatLoop==1){
					if (carNum==1 || carNum==2){
						yoshi1Active=true;
					} else {
						yoshi2Active=true;
					}
					yoshiElem.src='img/sprites/yoshi-eat-1.png';
				} else if (yoshiEatLoop==2){
					yoshiElem.src='img/sprites/yoshi-eat-2.png';
				} else if (yoshiEatLoop==3){
					yoshiElem.src='img/sprites/yoshi-eat-3.png';
				} else if (yoshiEatLoop==4){
					yoshiElem.src='img/sprites/yoshi-eat-4.png';
				} else if (yoshiEatLoop==5){
					yoshiElem.src='img/sprites/yoshi-eat-5.png';
				} else if (yoshiEatLoop==6){
					yoshiElem.src='img/sprites/yoshi-eat-6.png';
					carElem.style.visibility='hidden';
					if (carNum==1){
						car1Egged=true;
					} else if (carNum==2){
						car2Egged=true;
					} else if (carNum==3){
						car3Egged=true;
					} else if (carNum==4){
						car4Egged=true;
					}
				} else if (yoshiEatLoop==7){
					yoshiElem.src='img/sprites/yoshi-eat-7.png';
				} else if (yoshiEatLoop==8){
					yoshiElem.src='img/sprites/yoshi-eat-8.png';
				} else if (yoshiEatLoop==9){
					yoshiElem.src='img/sprites/yoshi-eat-9.png';
				} else if (yoshiEatLoop==10){
					yoshiElem.src='img/sprites/yoshi-eat-10.png';
				} else if (yoshiEatLoop==11){
					yoshiElem.src='img/sprites/yoshi-eat-11.png';
				} else if (yoshiEatLoop==12){
					yoshiElem.src='img/sprites/yoshi-eat-12.png';
				} else if (yoshiEatLoop==13){
					yoshiElem.src='img/sprites/yoshi-eat-13.png';
				} else if (yoshiEatLoop==14){
					yoshiElem.src='img/sprites/yoshi-eat-14.png';
				} else if (yoshiEatLoop==15){
					yoshiElem.src='img/sprites/yoshi-eat-15.png';
				} else if (yoshiEatLoop==16){
					yoshiElem.src='img/sprites/yoshi-eat-16.png';
				} else if (yoshiEatLoop==17){
					yoshiElem.src='img/sprites/yoshi-eat-15.png';
				} else if (yoshiEatLoop==18){
					yoshiElem.src='img/sprites/yoshi-eat-14.png';
					carElem.src='img/sprites/yoshi-egg-lb2.png';
					carElem.style.visibility='';
					if (carNum==1 || carNum==2){
						yoshi1Active=false;
					} else {
						yoshi2Active=false;
					}
				} else if (yoshiEatLoop%8==3){
					carElem.style.webkitTransform='rotate(260deg)';
					carElem.style.MozTransform='rotate(260deg)';
					carElem.style.transform='rotate(260deg)';
				} else if (yoshiEatLoop%8==4){
					carElem.style.webkitTransform='rotate(250deg)';
					carElem.style.MozTransform='rotate(250deg)';
					carElem.style.transform='rotate(250deg)';
				} else if (yoshiEatLoop%8==5){
					carElem.style.webkitTransform='rotate(260deg)';
					carElem.style.MozTransform='rotate(260deg)';
					carElem.style.transform='rotate(260deg)';
				} else if (yoshiEatLoop%8==6){
					carElem.style.webkitTransform='rotate(270deg)';
					carElem.style.MozTransform='rotate(270deg)';
					carElem.style.transform='rotate(270deg)';
				} else if (yoshiEatLoop%8==7){
					carElem.style.webkitTransform='rotate(280deg)';
					carElem.style.MozTransform='rotate(280deg)';
					carElem.style.transform='rotate(280deg)';
				} else if (yoshiEatLoop%8==0){
					carElem.style.webkitTransform='rotate(290deg)';
					carElem.style.MozTransform='rotate(290deg)';
					carElem.style.transform='rotate(290deg)';
				} else if (yoshiEatLoop%8==1){
					carElem.style.webkitTransform='rotate(280deg)';
					carElem.style.MozTransform='rotate(280deg)';
					carElem.style.transform='rotate(280deg)';
				} else if (yoshiEatLoop%8==2){
					carElem.style.webkitTransform='rotate(270deg)';
					carElem.style.MozTransform='rotate(270deg)';
					carElem.style.transform='rotate(270deg)';
				}
				if (yoshiEatLoop>24){
					if (Math.random()<.0002*yoshiEatLoop){
						bYoshiReturn=true;
					}
				}
				if (yoshiEatLoop>100){
					bYoshiReturn=true;
				}

				if (bYoshiReturn){
					carElem.style.webkitTransform='rotate(270deg)';
					carElem.style.MozTransform='rotate(270deg)';
					carElem.style.transform='rotate(270deg)';
					carElem.src='img/cars/${racer3.model}';
					if (carNum==1){
						car1Egged=false;
						car1Counter=0;
						clearInterval(yoshiid1);
					} else if (carNum==2){
						car2Egged=false;
						car2Counter=0;
						clearInterval(yoshiid2);
					} else if (carNum==3){
						car3Egged=false;
						car3Counter=0;
						clearInterval(yoshiid3);
					} else if (carNum==4){
						car4Egged=false;
						car4Counter=0;
						clearInterval(yoshiid4);
					}
				}
			}
			
			function triggerYoshiEat(carNum){
				if (carNum==1){
					yoshiid1 = setInterval(function() { yoshiEat(carNum); }, 40);
					yoshiHatesCar1=false;
				} else if (carNum==2){
					yoshiid2 = setInterval(function() { yoshiEat(carNum); }, 40);
					yoshiHatesCar2=false;
				} else if (carNum==3){
					yoshiid3 = setInterval(function() { yoshiEat(carNum); }, 40);
					yoshiHatesCar3=false;
				} else if (carNum==4){
					yoshiid4 = setInterval(function() { yoshiEat(carNum); }, 40);
					yoshiHatesCar4=false;
				}
			}
			
		
			function rotateYoshis(){
				if (!yoshi1Active){
					if (Math.random()<.25){
						if (yoshi1Face=="left"){
							yoshi1Face="right";
							document.getElementById("yoshi1").className='yoshiflip';
						} else {
							yoshi1Face="left";
							document.getElementById("yoshi1").className='yoshi';
						}
					}
				}
				if (!yoshi1Active){
					if (Math.random()<.25){
						if (yoshi2Face=="left"){
							yoshi2Face="right";
							document.getElementById("yoshi2").className='yoshiflip';
						} else {
							yoshi2Face="left";
							document.getElementById("yoshi2").className='yoshi';
						}
					}
				}
			}
			setInterval(rotateYoshis, 500);

			var peachLoop=0;
			var peachFail=false;
			var peachID;
			var charActive=false;
			var peachHelpedCar=0;
			function activatePeach(){
				peachLoop++;
				var peachElem = document.getElementById("peach");
				if (peachLoop==1){
					charActive=true;
					peachFail=false;
					peachElem.style.visibility='';
					peachElem.style.marginLeft='-50px';
					peachElem.src='img/sprites/peach-twirl-1.png';
				} else if (peachLoop==2){
					peachElem.src='img/sprites/peach-twirl-1.png';
					peachElem.style.marginLeft='-40px';
				} else if (peachLoop==3){
					peachElem.src='img/sprites/peach-twirl-1.png';
					peachElem.style.marginLeft='-30px';
				} else if (peachLoop==4){
					peachElem.src='img/sprites/peach-twirl-1.png';
					peachElem.style.marginLeft='-20px';
				} else if (peachLoop==5){
					peachElem.src='img/sprites/peach-twirl-1.png';
					peachElem.style.marginLeft='-10px';
				} else if (peachLoop==6){
					peachElem.src='img/sprites/peach-twirl-1.png';
					peachElem.style.marginLeft='0px';
				} else if (peachLoop==7){
					peachElem.src='img/sprites/peach-twirl-2.png';
				} else if (peachLoop==8){
					peachElem.src='img/sprites/peach-twirl-3.png';
				} else if (peachLoop==9){
					peachElem.src='img/sprites/peach-twirl-4.png';
				} else if (peachLoop==10){
					peachElem.src='img/sprites/peach-twirl-5.png';
				} else if (peachLoop==11){
					peachElem.src='img/sprites/peach-twirl-6.png';
				} else if (peachLoop==12){
					peachElem.src='img/sprites/peach-twirl-7.png';
				} else if (peachLoop==13){
					peachElem.src='img/sprites/peach-twirl-8.png';
				} else if (peachLoop==14){
					peachElem.src='img/sprites/peach-twirl-9.png';
				} else if (peachLoop==15){
					peachElem.src='img/sprites/peach-twirl-10.png';
					if (Math.random()<.25){
						peachFail=true;
					}
				} else if (peachLoop==16){
					var rand=Math.random();
					if (peachFail){
						peachElem.src='img/sprites/peach-twirl-fail-1.png';
						if (rand<=.25){
							car1CurVelocity=0;
						} else if (rand<=.5){
							car2CurVelocity=0;
						} else if (rand<=.75){
							car3CurVelocity=0;
						} else {
							car4CurVelocity=0;
						}
					} else {
						peachElem.src='img/sprites/peach-twirl-success-1.png';
						if (rand<=.25){
							peachHelpedCar=1;
						} else if (rand<=.5){
							peachHelpedCar=2;
						} else if (rand<=.75){
							peachHelpedCar=3;
						} else {
							peachHelpedCar=4;
						}
					}
				} else if (peachLoop==17){
					if (peachFail){
						peachElem.src='img/sprites/peach-twirl-fail-2.png';
					} else {
					}
				} else if (peachLoop==18){
					if (peachFail){
						peachElem.src='img/sprites/peach-twirl-fail-3.png';
					}
				} else if (peachLoop==19){
					if (peachFail){
						peachElem.src='img/sprites/peach-twirl-fail-4.png';
					}
				} else if (peachLoop==20){
					if (peachFail){
						peachElem.src='img/sprites/peach-twirl-fail-5.png';
					}
				} else if (peachLoop==21){
					if (peachFail){
						peachElem.src='img/sprites/peach-twirl-fail-6.png';
					}
				} else if (peachLoop==22){
					if (peachFail){
						peachElem.src='img/sprites/peach-twirl-fail-7.png';
					}
				}
				if (peachLoop>=16){
					if (!peachFail){
						if (peachHelpedCar==1){
							car1TopSpeed=${racer1.topSpeed * 2};
							car1CurVelocity=car1TopSpeed;
						} else if (peachHelpedCar==2){
							car2TopSpeed=${racer2.topSpeed * 2};
							car2CurVelocity=car2TopSpeed;
						} else if (peachHelpedCar==3){
							car3TopSpeed=${racer3.topSpeed * 2};
							car3CurVelocity=car3TopSpeed;
						} else if (peachHelpedCar==4){
							car4TopSpeed=${racer4.topSpeed * 2};
							car4CurVelocity=car4TopSpeed;
						}
					}
				}
				if (peachLoop>28){
					if (!peachFail){
						if (peachHelpedCar==1){
							car1TopSpeed=${racer1.topSpeed * (1-((1-racer1.reliability)*Math.random()))};
							car1CurVelocity=car1TopSpeed;
						} else if (peachHelpedCar==2){
							car2TopSpeed=${racer2.topSpeed * (1-((1-racer2.reliability)*Math.random()))};
							car2CurVelocity=car2TopSpeed;
						} else if (peachHelpedCar==3){
							car3TopSpeed=${racer3.topSpeed * (1-((1-racer3.reliability)*Math.random()))};
							car3CurVelocity=car3TopSpeed;
						} else if (peachHelpedCar==4){
							car4TopSpeed=${racer4.topSpeed * (1-((1-racer4.reliability)*Math.random()))};
							car4CurVelocity=car4TopSpeed;
						}
					}
					peachElem.style.visibility='hidden';
					peachLoop=0;
					charActive=false;
					clearInterval(peachID);
				}
			}

			var marioID;
			var marioLoop=0;
			var car1Boosted=0;
			var car2Boosted=0;
			var car3Boosted=0;
			var car4Boosted=0;
			function activateMario(){
				marioLoop++;
				var marioElem = document.getElementById("mario");
				if (marioLoop==1){
					charActive=true;
					marioElem.style.visibility='';
					marioElem.style.marginLeft='50px';
					marioElem.src='img/sprites/mario_toss-1.png';
				} else if (marioLoop==2){
					marioElem.src='img/sprites/mario_toss-1.png';
					marioElem.style.marginLeft='40px';
				} else if (marioLoop==3){
					marioElem.src='img/sprites/mario_toss-1.png';
					marioElem.style.marginLeft='30px';
				} else if (marioLoop==4){
					marioElem.src='img/sprites/mario_toss-1.png';
					marioElem.style.marginLeft='20px';
				} else if (marioLoop==5){
					marioElem.src='img/sprites/mario_toss-1.png';
					marioElem.style.marginLeft='10px';
				} else if (marioLoop==6){
					marioElem.src='img/sprites/mario_toss-1.png';
					marioElem.style.marginLeft='0px';
				} else if (marioLoop==7){
					marioElem.src='img/sprites/mario_toss-1.png';
				} else if (marioLoop==8){
					marioElem.src='img/sprites/mario_toss-2.png';
				} else if (marioLoop==9){
					marioElem.src='img/sprites/mario_toss-3.png';
				} else if (marioLoop==10){
					marioElem.src='img/sprites/mario_toss-4.png';
				} else if (marioLoop==11){
					marioElem.src='img/sprites/mario_toss-5.png';
				} else if (marioLoop==12){
					marioElem.src='img/sprites/mario_toss-6.png';
					car1Boosted=Math.random();
					car2Boosted=Math.random();
					car3Boosted=Math.random();
					car4Boosted=Math.random();
				} else if (marioLoop==13){
					marioElem.src='img/sprites/mario_toss-5.png';
				} else if (marioLoop==14){
					marioElem.src='img/sprites/mario_toss-4.png';
				} else if (marioLoop==15){
					marioElem.src='img/sprites/mario_toss-3.png';
				} else if (marioLoop==16){
					marioElem.src='img/sprites/mario_toss-2.png';
				} else if (marioLoop==17){
					marioElem.src='img/sprites/mario_toss-1.png';
				} else if (marioLoop==18){
					marioElem.src='img/sprites/mario_hat-1.png';
				} else if (marioLoop==19){
					marioElem.src='img/sprites/mario_hat-2.png';
				} else if (marioLoop==20){
					marioElem.src='img/sprites/mario_hat-3.png';
				} else if (marioLoop==21){
					marioElem.src='img/sprites/mario_hat-2.png';
				} else if (marioLoop==22){
					marioElem.src='img/sprites/mario_hat-1.png';
				} else if (marioLoop==23){
					marioElem.src='img/sprites/mario_thumbsup-1.png';
				} else if (marioLoop==24){
					marioElem.src='img/sprites/mario_thumbsup-2.png';
				} else if (marioLoop==25){
					marioElem.src='img/sprites/mario_thumbsup-3.png';
				}
				if (marioLoop>=12){
						car1TopSpeed=${racer1.topSpeed}*(1+car1Boosted);
						car1CurVelocity=car1TopSpeed;
						car2TopSpeed=${racer2.topSpeed}*(1+car2Boosted);
						car2CurVelocity=car2TopSpeed;
						car3TopSpeed=${racer3.topSpeed}*(1+car3Boosted);
						car3CurVelocity=car3TopSpeed;
						car4TopSpeed=${racer4.topSpeed}*(1+car4Boosted);
						car4CurVelocity=car4TopSpeed;
				}
				if (marioLoop>30){
					car1Boosted=0;
					car1TopSpeed=${racer1.topSpeed * (1-((1-racer1.reliability)*Math.random()))};
					car1CurVelocity=car1TopSpeed;
					
					car2Boosted=0;
					car2TopSpeed=${racer2.topSpeed * (1-((1-racer2.reliability)*Math.random()))};
					car2CurVelocity=car2TopSpeed;
					
					car3Boosted=0;
					car3TopSpeed=${racer3.topSpeed * (1-((1-racer3.reliability)*Math.random()))};
					car3CurVelocity=car3TopSpeed;
					
					car4Boosted=0;
					car4TopSpeed=${racer4.topSpeed * (1-((1-racer4.reliability)*Math.random()))};
					car4CurVelocity=car4TopSpeed;
					
					marioElem.style.visibility='hidden';
					marioLoop=0;
					charActive=false;
					clearInterval(marioID);
				}
			}

			var car1SpinTime=0;
			var car2SpinTime=0;
			var car3SpinTime=0;
			var car4SpinTime=0;
			var spinCar1;
			var spinCar2;
			var spinCar3;
			var spinCar4;
			function spinCar(carNum){
				var carElem = document.getElementById("car"+carNum);
				var spinLoop=0;
				if (carNum==1){
					car1SpinTime++;
					spinLoop=car1SpinTime;
				} else if (carNum==2){
					car2SpinTime++;
					spinLoop=car2SpinTime;
				} else if (carNum==3){
					car3SpinTime++;
					spinLoop=car3SpinTime;
				} else if (carNum==4){
					car4SpinTime++;
					spinLoop=car4SpinTime;
				}
				if (spinLoop%8==1){
					carElem.style.webkitTransform='rotate(280deg)';
					carElem.style.MozTransform='rotate(280deg)';
					carElem.style.transform='rotate(280deg)';
				} else if (spinLoop%8==2){
					carElem.style.webkitTransform='rotate(290deg)';
					carElem.style.MozTransform='rotate(290deg)';
					carElem.style.transform='rotate(290deg)';
				} else if (spinLoop%8==3){
					carElem.style.webkitTransform='rotate(280deg)';
					carElem.style.MozTransform='rotate(280deg)';
					carElem.style.transform='rotate(280deg)';
				} else if (spinLoop%8==4){
					carElem.style.webkitTransform='rotate(270deg)';
					carElem.style.MozTransform='rotate(270deg)';
					carElem.style.transform='rotate(270deg)';
				} else if (spinLoop%8==5){
					carElem.style.webkitTransform='rotate(260deg)';
					carElem.style.MozTransform='rotate(260deg)';
					carElem.style.transform='rotate(260deg)';
				} else if (spinLoop%8==6){
					carElem.style.webkitTransform='rotate(250deg)';
					carElem.style.MozTransform='rotate(250deg)';
					carElem.style.transform='rotate(250deg)';
				} else if (spinLoop%8==7){
					carElem.style.webkitTransform='rotate(260deg)';
					carElem.style.MozTransform='rotate(260deg)';
					carElem.style.transform='rotate(260deg)';
				} else if (spinLoop%8==0){
					carElem.style.webkitTransform='rotate(270deg)';
					carElem.style.MozTransform='rotate(270deg)';
					carElem.style.transform='rotate(270deg)';
				}

			}
			
			var crab1Active=false;
			var crab2Active=false;
			var crab3Active=false;
			var crab4Active=false;
			var crab1Loop=0;
			var crab2Loop=0;
			var crab3Loop=0;
			var crab4Loop=0;
			var crabID1;
			var crabID2;
			var crabID3;
			var crabID4;
			function activateCrab(crabNum, dir){
				var crabElem = document.getElementById("crab"+crabNum);
				var crabLoop;
				if (crabNum==1){
					crab1Loop+=1;
					crabLoop=crab1Loop;
				} else if (crabNum==2){
					crab2Loop+=1;
					crabLoop=crab2Loop;
				} else if (crabNum==3){
					crab3Loop+=1;
					crabLoop=crab3Loop;
				} else {
					crab4Loop+=1;
					crabLoop=crab4Loop;
				}
				if (crabLoop==1){
					crabElem.src='img/sprites/crab-2.png';
					if (dir=="right"){
						crabElem.style.marginLeft='21px';
					} else {
						crabElem.style.marginLeft='1px';
					}
				} else if (crabLoop==2){
					crabElem.src='img/sprites/crab-3.png';
					if (dir=="right"){
						crabElem.style.marginLeft='31px';
					} else {
						crabElem.style.marginLeft='-9px';
					}
				} else if (crabLoop==3){
					crabElem.src='img/sprites/crab-4.png';
					if (dir=="right"){
						crabElem.style.marginLeft='41px';
					} else {
						crabElem.style.marginLeft='-19px';
					}
				} else if (crabLoop==4){
					crabElem.src='img/sprites/crab-5.png';
					if (dir=="right"){
						crabElem.style.marginLeft='51px';
					} else {
						crabElem.style.marginLeft='-29px';
					}
				} else if (crabLoop==5){
					crabElem.src='img/sprites/crab-6.png';
					if (dir=="right"){
						crabElem.style.marginLeft='61px';
					} else {
						crabElem.style.marginLeft='-39px';
					}
				} else if (crabLoop==6){
					crabElem.src='img/sprites/crab-1.png';
					if (dir=="right"){
						crabElem.style.marginLeft='71px';
					} else {
						crabElem.style.marginLeft='-49px';
					}
				} else if (crabLoop==7){
					crabElem.src='img/sprites/crab-6.png';
					if (dir=="right"){
						crabElem.style.marginLeft='61px';
					} else {
						crabElem.style.marginLeft='-39px';
					}
				} else if (crabLoop==8){
					crabElem.src='img/sprites/crab-5.png';
					if (dir=="right"){
						crabElem.style.marginLeft='51px';
					} else {
						crabElem.style.marginLeft='-29px';
					}
				} else if (crabLoop==9){
					crabElem.src='img/sprites/crab-4.png';
					if (dir=="right"){
						crabElem.style.marginLeft='41px';
					} else {
						crabElem.style.marginLeft='-19px';
					}
				} else if (crabLoop==10){
					crabElem.src='img/sprites/crab-3.png';
					if (dir=="right"){
						crabElem.style.marginLeft='31px';
					} else {
						crabElem.style.marginLeft='-9px';
					}
				} else if (crabLoop==11){
					crabElem.src='img/sprites/crab-2.png';
					if (dir=="right"){
						crabElem.style.marginLeft='21px';
					} else {
						crabElem.style.marginLeft='1px';
					}
				} else if (crabLoop==12){
					crabElem.src='img/sprites/crab-1.png';
					crabElem.style.marginLeft='11px';
					if (crabNum==1){
						crab1Active=false;
						crab1Loop=0;
						clearInterval(crabID1);
					} else if (crabNum==2){
						crab2Active=false;
						crab2Loop=0;
						clearInterval(crabID2);
					} else if (crabNum==3){
						crab3Active=false;
						crab3Loop=0;
						clearInterval(crabID3);
					} else if (crabNum==4){
						crab4Active=false;
						crab4Loop=0;
						clearInterval(crabID4);
					}
				}

				if (crabLoop>=4&&crabLoop<=8){
					var carNum=0;
					if (dir=="right"){
						if (crabNum<=2){
							carNum=2;
						} else if (crabNum<=4){
							carNum=4;
						}
					} else {
						if (crabNum<=2){
							carNum=1;
						} else if (crabNum<=4){
							carNum=3;
						}
					}
					var carElem=document.getElementById("car"+carNum);
					var carBottom=Number(carElem.style.bottom.replace("px",""));
					var crabBottom=Number(crabElem.style.bottom.replace("px",""));
					if (crabLoop<=8&&carBottom<=crabBottom+10&&carBottom+70>=crabBottom){
						if (carNum==1){
							if (car1SpinTime==0){
								spinCar1=setInterval(function() { spinCar(carNum); },50);
							}
							car1CurVelocity=car1CurVelocity*.75;
						} else if (carNum==2){
							if (car2SpinTime==0){
								spinCar2=setInterval(function() { spinCar(carNum); },50);
							}
							car2CurVelocity=car2CurVelocity*.75;
						} else if (carNum==3){
							if (car3SpinTime==0){
								spinCar3=setInterval(function() { spinCar(carNum); },50);
							}
							car3CurVelocity=car3CurVelocity*.75;
						} else if (carNum==4){
							if (car4SpinTime==0){
								spinCar4=setInterval(function() { spinCar(carNum); },50);
							}
							car4CurVelocity=car4CurVelocity*.75;
						}
					}
				} else if (crabLoop>8){
					var carNum=0;
					if (dir=="right"){
						if (crabNum<=2){
							carNum=2;
						} else if (crabNum<=4){
							carNum=4;
						}
					} else {
						if (crabNum<=2){
							carNum=1;
						} else if (crabNum<=4){
							carNum=3;
						}
					}
					var carElem=document.getElementById("car"+carNum);
					carElem.style.webkitTransform='rotate(270deg)';
					carElem.style.MozTransform='rotate(270deg)';
					carElem.style.transform='rotate(270deg)';
					if (carNum==1){
						car1SpinTime=0;
						clearInterval(spinCar1);
					} else if (carNum==2){
						car2SpinTime=0;
						clearInterval(spinCar2);
					} else if (carNum==3){
						car3SpinTime=0;
						clearInterval(spinCar3);
					} else if (carNum==4){
						car4SpinTime=0;
						clearInterval(spinCar4);
					}
				}
			}

			function triggerCharacterAnimations(){
				var carTop=car1.style.top;
				var carBottom=car1.style.bottom;
				if (yoshiHatesCar1&&!yoshi1Active&&car1Counter==0&&car1.style.bottom.replace("px","")<400&&car1.style.bottom.replace("px","")>300&&yoshi1Face=="left"){
					triggerYoshiEat(1);
				}
				carTop=car2.style.top;
				carBottom=car2.style.bottom;
				if (yoshiHatesCar2&&!yoshi1Active&&car2Counter==0&&car2.style.bottom.replace("px","")<400&&car2.style.bottom.replace("px","")>300&&yoshi1Face=="right"){
					triggerYoshiEat(2);
				}
				carTop=car3.style.top;
				carBottom=car3.style.bottom;
				if (yoshiHatesCar3&&!yoshi2Active&&car3Counter==0&&car3.style.bottom.replace("px","")<400&&car3.style.bottom.replace("px","")>300&&yoshi2Face=="left"){
					triggerYoshiEat(3);
				}
				carTop=car4.style.top;
				carBottom=car4.style.bottom;
				if (yoshiHatesCar4&&!yoshi2Active&&car4Counter==0&&car4.style.bottom.replace("px","")<400&&car4.style.bottom.replace("px","")>300&&yoshi2Face=="right"){
					triggerYoshiEat(4);
				}
				if (!charActive&&Math.random()<.001){
					var rand = Math.random();
					if (rand<.2){
						if (bowserLoop==0){
							bowserID=setInterval(activateBowser, 100);
						}
					} else if (rand<.6){
						peachID=setInterval(activatePeach, 80);
					} else {
						marioID=setInterval(activateMario, 80);
					}
				}
				if (!crab1Active&&Math.random()<.001){
					crab1Active=true;
					var dir = "left";
					if (Math.random()<=.5){
						dir="right";
					}
					crabID1=setInterval(function() { activateCrab(1, dir); }, 200);
				}
				if (!crab2Active&&Math.random()<.001){
					crab2Active=true;
					var dir = "left";
					if (Math.random()<=.5){
						dir="right";
					}
					crabID2=setInterval(function() { activateCrab(2, dir); }, 200);
				}
				if (!crab3Active&&Math.random()<.001){
					crab3Active=true;
					var dir = "left";
					if (Math.random()<=.5){
						dir="right";
					}
					crabID3=setInterval(function() { activateCrab(3, dir); }, 200);
				}
				if (!crab4Active&&Math.random()<.001){
					crab4Active=true;
					var dir = "left";
					if (Math.random()<=.5){
						dir="right";
					}
					crabID4=setInterval(function() { activateCrab(4, dir); }, 200);
				}
			}

			var bowserLoop=0;
			var bowserID;
			var car1BowserEffect='none';
			var car2BowserEffect='none';
			var car3BowserEffect='none';
			var car4BowserEffect='none';
			function activateBowser(){
				bowserLoop++;
				var bowserElem = document.getElementById("bowser");
				if (bowserLoop==1){
					charActive=true;
					bowserElem.style.bottom='750px';
					bowserElem.src='img/sprites/bowser-falling-1.png';
				} else if (bowserLoop==2){
					bowserElem.src='img/sprites/bowser-falling-1.png';
					bowserElem.style.bottom='700px';
				} else if (bowserLoop==3){
					bowserElem.src='img/sprites/bowser-falling-1.png';
					bowserElem.style.bottom='650px';
				} else if (bowserLoop==4){
					bowserElem.src='img/sprites/bowser-falling-1.png';
					bowserElem.style.bottom='600px';
				} else if (bowserLoop==5){
					bowserElem.src='img/sprites/bowser-falling-1.png';
					bowserElem.style.bottom='550px';
				} else if (bowserLoop==6){
					bowserElem.src='img/sprites/bowser-falling-1.png';
					bowserElem.style.bottom='500px';
				} else if (bowserLoop>=7&&bowserLoop<=13){
					bowserElem.src='img/sprites/bowser-falling-'+(bowserLoop-5)+'.png';
				} else if (bowserLoop>=14&&bowserLoop<=28){
					bowserElem.src='img/sprites/bowser_down-'+(bowserLoop-13)+'.png';
				} else if (bowserLoop>=29&&bowserLoop<=38){
					bowserElem.src='img/sprites/bowser_clap-'+(bowserLoop-28)+'.png';
				} else if (bowserLoop==39){
					bowserElem.src='img/sprites/bowser_clap-9.png';
				} else if (bowserLoop==40){
					bowserElem.src='img/sprites/bowser_clap-8.png';
				} else if (bowserLoop==41){
					bowserElem.src='img/sprites/bowser_clap-1.png';
				} else if (bowserLoop==42){
					bowserElem.src='img/sprites/bowser_down-15.png';
				} else if (bowserLoop==60){
					var carElem=document.getElementById("car1");
					if (car1BowserEffect=='reverse'){
						car1CurVelocity=0-car1CurVelocity;
						car1Accel=0-car1Accel;
						car1TopSpeed=0-car1TopSpeed;
						carElem.style.webkitTransform='rotate(270deg)';
						carElem.style.MozTransform='rotate(270deg)';
						carElem.style.transform='rotate(270deg)';
					} else if (car1BowserEffect=='mini'){
						carElem.style.width='100px';
						carElem.style.height='50px';
					} 
					carElem=document.getElementById("car2");
					if (car2BowserEffect=='reverse'){
						car2CurVelocity=0-car2CurVelocity;
						car2Accel=0-car2Accel;
						car2TopSpeed=0-car2TopSpeed;
						carElem.style.webkitTransform='rotate(270deg)';
						carElem.style.MozTransform='rotate(270deg)';
						carElem.style.transform='rotate(270deg)';
					} else if (car2BowserEffect=='mini'){
						carElem.style.width='100px';
						carElem.style.height='50px';
					}
					carElem=document.getElementById("car3");
					if (car3BowserEffect=='reverse'){
						car3CurVelocity=0-car3CurVelocity;
						car3Accel=0-car3Accel;
						car3TopSpeed=0-car3TopSpeed;
						carElem.style.webkitTransform='rotate(270deg)';
						carElem.style.MozTransform='rotate(270deg)';
						carElem.style.transform='rotate(270deg)';
					} else if (car3BowserEffect=='mini'){
						carElem.style.width='100px';
						carElem.style.height='50px';
					}
					carElem=document.getElementById("car4");
					if (car4BowserEffect=='reverse'){
						car4CurVelocity=0-car4CurVelocity;
						car4Accel=0-car4Accel;
						car4TopSpeed=0-car4TopSpeed;
						carElem.style.webkitTransform='rotate(270deg)';
						carElem.style.MozTransform='rotate(270deg)';
						carElem.style.transform='rotate(270deg)';
					} else if (car4BowserEffect=='mini'){
						carElem.style.width='100px';
						carElem.style.height='50px';
					}
					car1BowserEffect='none';
					car2BowserEffect='none';
					car3BowserEffect='none';
					car4BowserEffect='none';
					bowserElem.style.visibility='hidden';
					charActive=false;
					clearInterval(bowserID);
				}
				if (bowserLoop==38){
					var rand=Math.random();
					var carElem=document.getElementById("car1");
					if (rand<.25){
						car1BowserEffect='reverse';
						car1CurVelocity=0-car1CurVelocity;
						car1Accel=0-car1Accel;
						car1TopSpeed=0-car1TopSpeed;
						carElem.style.webkitTransform='rotate(90deg)';
						carElem.style.MozTransform='rotate(90deg)';
						carElem.style.transform='rotate(90deg)';
					} else if (rand<.5){
						car1BowserEffect='stopped';
					} else if (rand<.75){
						car1BowserEffect='mini';
						carElem.style.width='50px';
						carElem.style.height='25px';
					} else {
						car1BowserEffect='none';
					}
					rand=Math.random();
					carElem=document.getElementById("car2");
					if (rand<.25){
						car2BowserEffect='reverse';
						car2CurVelocity=0-car2CurVelocity;
						car2Accel=0-car2Accel;
						car2TopSpeed=0-car2TopSpeed;
						carElem.style.webkitTransform='rotate(90deg)';
						carElem.style.MozTransform='rotate(90deg)';
						carElem.style.transform='rotate(90deg)';
					} else if (rand<.5){
						car2BowserEffect='stopped';
					} else if (rand<.75){
						car2BowserEffect='mini';
						carElem.style.width='50px';
						carElem.style.height='25px';
					} else {
						car2BowserEffect='none';
					}
					rand=Math.random();
					carElem=document.getElementById("car3");
					if (rand<.25){
						car3BowserEffect='reverse';
						car3CurVelocity=0-car3CurVelocity;
						car3Accel=0-car3Accel;
						car3TopSpeed=0-car3TopSpeed;
						carElem.style.webkitTransform='rotate(90deg)';
						carElem.style.MozTransform='rotate(90deg)';
						carElem.style.transform='rotate(90deg)';
					} else if (rand<.5){
						car3BowserEffect='stopped';
					} else if (rand<.75){
						car3BowserEffect='mini';
						carElem.style.width='50px';
						carElem.style.height='25px';
					} else {
						car3BowserEffect='none';
					}
					rand=Math.random();
					carElem=document.getElementById("car4");
					if (rand<.25){
						car4BowserEffect='reverse';
						car4CurVelocity=0-car4CurVelocity;
						car4Accel=0-car4Accel;
						car4TopSpeed=0-car4TopSpeed;
						carElem.style.webkitTransform='rotate(90deg)';
						carElem.style.MozTransform='rotate(90deg)';
						carElem.style.transform='rotate(90deg)';
					} else if (rand<.5){
						car4BowserEffect='stopped';
					} else if (rand<.75){
						car4BowserEffect='mini';
						carElem.style.width='50px';
						carElem.style.height='25px';
					} else {
						car4BowserEffect='none';
					}
				}
			}
			
			function moveAllCars(){
				elapsedTime += .01;
				if (car1Location < distance) {
					car1CurVelocity = car1CurVelocity + 0.01*car1Accel;
					if (car1Egged||car1BowserEffect=='stopped'){
						car1CurVelocity=0;
					}
					if (Math.abs(car1CurVelocity) > Math.abs(car1TopSpeed)) {
						car1CurVelocity=car1TopSpeed;
					}
					if (car1BowserEffect=='mini'){
						if (car1CurVelocity > car1TopSpeed/4) {
							car1CurVelocity=car1TopSpeed/4;
						}
					}
					car1Location = car1Location + car1CurVelocity * .01;
					
					if (car1Location >= distance) {
						if (firstPlace == null) {
							firstPlace = "car1";
							document.getElementById("firstPlaceTimeForm").value=elapsedTime;
						} else if (secondPlace == null) {
							secondPlace = "car1";
							document.getElementById("secondPlaceTimeForm").value=elapsedTime;
						} else if (thirdPlace == null) {
							thirdPlace = "car1";
							document.getElementById("thirdPlaceTimeForm").value=elapsedTime;
							finishedRace = true;
						}
					} else {
						car1.style.bottom = 50+580*(car1Location%lapDistance)/lapDistance+"px";

						if (car1Location/lapDistance<(car1Lap-1)){
							car1Lap=car1Lap-1;
							car1CurVelocity=car1CurVelocity*car1LapEfficiency;
						} else if (car1Location/lapDistance>car1Lap){
							car1Lap+=1;
							car1CurVelocity=car1CurVelocity*car1LapEfficiency;
							if (Math.random()<.25){
								yoshiHatesCar1=true;
							} else {
								yoshiHatesCar1=false;
							}
							if (car1Lap==2){
								track1.className="tracklap2";
								car1TopSpeed=${racer1.topSpeed * (1-((1-racer1.reliability)*Math.random()))};
								car1Accel=${racer1.acceleration * (1-((1-racer1.reliability)*Math.random()))};
							} else if (car1Lap==3){
								track1.className="tracklap3";
								car1TopSpeed=${racer1.topSpeed * (1-((1-racer1.reliability)*Math.random()))};
								car1Accel=${racer1.acceleration * (1-((1-racer1.reliability)*Math.random()))};
							} else if (car1Lap==4){
								track1.className="tracklap4";
								car1TopSpeed=${racer1.topSpeed * (1-((1-racer1.reliability)*Math.random()))};
								car1Accel=${racer1.acceleration * (1-((1-racer1.reliability)*Math.random()))};
							} else if (car1Lap==5){
								track1.className="tracklap5";
								car1TopSpeed=${racer1.topSpeed * (1-((1-racer1.reliability)*Math.random()))};
								car1Accel=${racer1.acceleration * (1-((1-racer1.reliability)*Math.random()))};
							}
						}
					}
				}

				if (car2Location < distance) {
					car2CurVelocity = car2CurVelocity + 0.01*car2Accel;
					if (car2Egged||car2BowserEffect=='stopped'){
						car2CurVelocity=0;
					}
					if (Math.abs(car2CurVelocity) > Math.abs(car2TopSpeed)) {
						car2CurVelocity=car2TopSpeed;
					}
					if (car2BowserEffect=='mini'){
						if (car2CurVelocity > car2TopSpeed/4) {
							car2CurVelocity=car2TopSpeed/4;
						}
					}
					car2Location = car2Location + car2CurVelocity * .01;
					
					if (car2Location >= distance) {
						if (firstPlace == null) {
							firstPlace = "car2";
							document.getElementById("firstPlaceTimeForm").value=elapsedTime;
						} else if (secondPlace == null) {
							secondPlace = "car2";
							document.getElementById("secondPlaceTimeForm").value=elapsedTime;
						} else if (thirdPlace == null) {
							thirdPlace = "car2";
							document.getElementById("thirdPlaceTimeForm").value=elapsedTime;
							finishedRace = true;
						}
					} else {
						car2.style.bottom = 50+580*(car2Location%lapDistance)/lapDistance+"px";

						if (car2Location/lapDistance<(car2Lap-1)){
							car2Lap=car2Lap-1;
							car2CurVelocity=car2CurVelocity*car2LapEfficiency;
						} else if (car2Location/lapDistance>car2Lap){
							car2Lap+=1;
							car2CurVelocity=car2CurVelocity*car2LapEfficiency;
							if (Math.random()<.25){
								yoshiHatesCar2=true;
							} else {
								yoshiHatesCar2=false;
							}
							if (car2Lap==2){
								track2.className="tracklap2";
								car2TopSpeed=${racer2.topSpeed * (1-((1-racer2.reliability)*Math.random()))};
								car2Accel=${racer2.acceleration * (1-((1-racer2.reliability)*Math.random()))};
							} else if (car2Lap==3){
								track2.className="tracklap3";
								car2TopSpeed=${racer2.topSpeed * (1-((1-racer2.reliability)*Math.random()))};
								car2Accel=${racer2.acceleration * (1-((1-racer2.reliability)*Math.random()))};
							} else if (car2Lap==4){
								track2.className="tracklap4";
								car2TopSpeed=${racer2.topSpeed * (1-((1-racer2.reliability)*Math.random()))};
								car2Accel=${racer2.acceleration * (1-((1-racer2.reliability)*Math.random()))};
							} else if (car2Lap==5){
								track2.className="tracklap5";
								car2TopSpeed=${racer2.topSpeed * (1-((1-racer2.reliability)*Math.random()))};
								car2Accel=${racer2.acceleration * (1-((1-racer2.reliability)*Math.random()))};
							}
						}
					}
				}

				if (car3Location < distance) {
					car3CurVelocity = car3CurVelocity + 0.01*car3Accel;
					if (car3Egged||car3BowserEffect=='stopped'){
						car3CurVelocity=0;
					}
					if (Math.abs(car3CurVelocity) > Math.abs(car3TopSpeed)) {
						car3CurVelocity=car3TopSpeed;
					}
					if (car3BowserEffect=='mini'){
						if (car3CurVelocity > car3TopSpeed/4) {
							car3CurVelocity=car3TopSpeed/4;
						}
					}
					car3Location = car3Location + car3CurVelocity * .01;
					
					if (car3Location >= distance) {
						if (firstPlace == null) {
							firstPlace = "car3";
							document.getElementById("firstPlaceTimeForm").value=elapsedTime;
						} else if (secondPlace == null) {
							secondPlace = "car3";
							document.getElementById("secondPlaceTimeForm").value=elapsedTime;
						} else if (thirdPlace == null) {
							thirdPlace = "car3";
							document.getElementById("thirdPlaceTimeForm").value=elapsedTime;
							finishedRace = true;
						}
					} else {
						car3.style.bottom = 50+580*(car3Location%lapDistance)/lapDistance+"px";

						if (car3Location/lapDistance<(car3Lap-1)){
							car3Lap=car3Lap-1;
							car3CurVelocity=car3CurVelocity*car3LapEfficiency;
						} else if (car3Location/lapDistance>car3Lap){
							car3Lap+=1;
							car3CurVelocity=car3CurVelocity*car3LapEfficiency;
							if (Math.random()<.25){
								yoshiHatesCar3=true;
							} else {
								yoshiHatesCar3=false;
							}
							if (car3Lap==2){
								track3.className="tracklap2";
								car3TopSpeed=${racer3.topSpeed * (1-((1-racer3.reliability)*Math.random()))};
								car3Accel=${racer3.acceleration * (1-((1-racer3.reliability)*Math.random()))};
							} else if (car3Lap==3){
								track3.className="tracklap3";
								car3TopSpeed=${racer3.topSpeed * (1-((1-racer3.reliability)*Math.random()))};
								car3Accel=${racer3.acceleration * (1-((1-racer3.reliability)*Math.random()))};
							} else if (car3Lap==4){
								track3.className="tracklap4";
								car3TopSpeed=${racer3.topSpeed * (1-((1-racer3.reliability)*Math.random()))};
								car3Accel=${racer3.acceleration * (1-((1-racer3.reliability)*Math.random()))};
							} else if (car3Lap==5){
								track3.className="tracklap5";
								car3TopSpeed=${racer3.topSpeed * (1-((1-racer3.reliability)*Math.random()))};
								car3Accel=${racer3.acceleration * (1-((1-racer3.reliability)*Math.random()))};
							}
						}
					}
				}

				if (car4Location < distance) {
					car4CurVelocity = car4CurVelocity + 0.01*car4Accel;
					if (car4Egged||car4BowserEffect=='stopped'){
						car4CurVelocity=0;
					}
					if (Math.abs(car4CurVelocity) > Math.abs(car4TopSpeed)) {
						car4CurVelocity=car4TopSpeed;
					}
					if (car4BowserEffect=='mini'){
						if (car4CurVelocity > car4TopSpeed/4) {
							car4CurVelocity=car4TopSpeed/4;
						}
					}
					car4Location = car4Location + car4CurVelocity * .01;
					
					if (car4Location >= distance) {
						if (firstPlace == null) {
							firstPlace = "car4";
							document.getElementById("firstPlaceTimeForm").value=elapsedTime;
						} else if (secondPlace == null) {
							secondPlace = "car4";
							document.getElementById("secondPlaceTimeForm").value=elapsedTime;
						} else if (thirdPlace == null) {
							thirdPlace = "car4";
							document.getElementById("thirdPlaceTimeForm").value=elapsedTime;
							finishedRace = true;
						} else {
							
						}
					} else {
						car4.style.bottom = 50+580*(car4Location%lapDistance)/lapDistance+"px";

						if (car4Location/lapDistance<(car4Lap-1)){
							car4Lap=car4Lap-1;
							car4CurVelocity=car4CurVelocity*car4LapEfficiency;
						} else if (car4Location/lapDistance>car4Lap){
							car4Lap+=1;
							car4CurVelocity=car4CurVelocity*car4LapEfficiency;
							if (Math.random()<.25){
								yoshiHatesCar4=true;
							} else {
								yoshiHatesCar4=false;
							}
							if (car4Lap==2){
								track4.className="tracklap2";
								car4TopSpeed=${racer4.topSpeed * (1-((1-racer4.reliability)*Math.random()))};
								car4Accel=${racer4.acceleration * (1-((1-racer4.reliability)*Math.random()))};
							} else if (car4Lap==3){
								track4.className="tracklap3";
								car4TopSpeed=${racer4.topSpeed * (1-((1-racer4.reliability)*Math.random()))};
								car4Accel=${racer4.acceleration * (1-((1-racer4.reliability)*Math.random()))};
							} else if (car4Lap==4){
								track4.className="tracklap4";
								car4TopSpeed=${racer4.topSpeed * (1-((1-racer4.reliability)*Math.random()))};
								car4Accel=${racer4.acceleration * (1-((1-racer4.reliability)*Math.random()))};
							} else if (car4Lap==5){
								track4.className="tracklap5";
								car4TopSpeed=${racer4.topSpeed * (1-((1-racer4.reliability)*Math.random()))};
								car4Accel=${racer4.acceleration * (1-((1-racer4.reliability)*Math.random()))};
							}
						}
					}
				}

				if (finishedRace) {
					clearInterval(raceid);
					document.getElementById("firstPlaceForm").value=firstPlace;
					document.getElementById("secondPlaceForm").value=secondPlace;
					document.getElementById("thirdPlaceForm").value=thirdPlace;
					resultForm.submit();
				}

				triggerCharacterAnimations();
			}

			var raceid = setInterval(moveAllCars, 10);

		}
	</script>
	
	<div class="splits">
		<img class="peach" id="peach" src='img/sprites/peach-twirl-1.png'/>
	</div>
	<div class="tracklap1" id="track1">
			<img class="car" id="car1" src="img/cars/${racer1.model}"/>
	</div>
	<div class="splits">
		<img class="crab" id="crab1" src='img/sprites/crab-1.png'/>
		<img class="yoshi" id="yoshi1" src='img/sprites/yoshi-eat-14.png'/>
		<img class="crab" id="crab2" src='img/sprites/crab-1.png'/>
	</div>
	<div class="tracklap1" id="track2">
		<img class="car" id="car2" src="img/cars/${racer2.model}">
	</div>
	<div class="middle">
		<img class="bowser" id="bowser" src='img/sprites/bowser-falling-1.png'/>
	</div>
	<div class="tracklap1" id="track3">
		<img class="car" id="car3" src="img/cars/${racer3.model}">
	</div>
	<div class="splits">
		<img class="crab" id="crab3" src='img/sprites/crab-1.png'/>
		<img class="yoshiflip" id="yoshi2" src='img/sprites/yoshi-eat-14.png'/>
		<img class="crab" id="crab4" src='img/sprites/crab-1.png'/>
	</div>
	<div class="tracklap1" id="track4">
		<img class="car" id="car4" src="img/cars/${racer4.model}">
	</div>
	<div class="splits">
		<img class="mario" id="mario" src='img/sprites/mario_thumbsup-1.png'/>
	</div>
	<form:form method="POST" id="resultForm" action="spectateResults" commandName="raceResult">
		<form:input id="classForm" type="hidden" path="racingClass" value="${raceInfo.racingClass}"/>
		<form:input id="raceType" type="hidden" path="raceType" value="spectate"/>
		<form:input id="firstPlaceForm" type="hidden" path="place1"/>
		<form:input id="firstPlaceTimeForm" type="hidden" path="place1Time"/>
		<form:input id="secondPlaceForm" type="hidden" path="place2"/>
		<form:input id="secondPlaceTimeForm" type="hidden" path="place2Time"/>
		<form:input id="thirdPlaceForm" type="hidden" path="place3"/>
		<form:input id="thirdPlaceTimeForm" type="hidden" path="place3Time"/>
		<form:input id="fourthPlaceForm" type="hidden" path="place4"/>
		<form:input id="fourthPlaceTimeForm" type="hidden" path="place4Time"/>
	</form:form>
	<script>
		document.getElementById("crab1").style.bottom=475+Math.random()*125+'px';
		document.getElementById("crab1").style.marginLeft='11px';
		document.getElementById("crab2").style.bottom=250+(Math.random()*125)/2+'px';
		document.getElementById("crab2").style.marginLeft='11px';
		document.getElementById("crab3").style.bottom=475+Math.random()*125+'px';
		document.getElementById("crab3").style.marginLeft='11px';
		document.getElementById("crab4").style.bottom=250+(Math.random()*125)/2+'px';
		document.getElementById("crab4").style.marginLeft='11px';
		startRace();
	</script>
</body>
</html>