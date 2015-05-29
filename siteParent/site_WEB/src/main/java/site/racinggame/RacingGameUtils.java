package site.racinggame;

import java.text.NumberFormat;

public class RacingGameUtils {
	public static String getNewRacingGameIdentifier(){
		return "54321";
	}
	
	public static RacingGame getRacingGameObject(Long racingGameIdentifier){
		RacingGame racingGame;
		if (racingGameIdentifier==null){
			racingGame=new RacingGame();
		} else {
			racingGame=new RacingGame();//TODO, dao implementation
		}
		return racingGame;
	}
	
	public static Racecar getRacecarByID(Integer carID){
		Racecar car;
		if (carID==1){
			car=new Racecar(1, 'E', 100, 20, 0.7, 0.3, "silver_audi2", 1000);
		} else if (carID==2){
			car=new Racecar(2, 'E', 120, 18, 0.5, 0.35, "red_fer", 750);
		} else if (carID==3){
			car=new Racecar(3, 'E', 90, 18, 0.9, 0.5, "red_sedan", 400);
		} else if (carID==4){
			car=new Racecar(4, 'E', 150, 16, 0.35, 0.35, "black_lambo", 2000);
		}else if (carID==5){
			car=new Racecar(5, 'E', 130, 16, 0.65, 0.4, "silver_chevvy", 1500);
		} else {
			car=null;
		}
		return car;
	}
	
	public static Upgrade getUpgradeByID(Integer upgradeID, char carClass){
		Upgrade upgrade = new Upgrade();
		if (carClass=='E'){
			upgrade.setPrice(500);
		} else if (carClass=='D'){
			upgrade.setPrice(1000);
		} else if (carClass=='C'){
			upgrade.setPrice(2000);
		} else if (carClass=='B'){
			upgrade.setPrice(5000);
		} else if (carClass=='A'){
			upgrade.setPrice(15000);
		} else if (carClass=='S'){
			upgrade.setPrice(30000);
		}
		if (upgradeID==1){
			upgrade.setTopSpeedMod(20);
		} else if (upgradeID==2){
			upgrade.setAccelerationMod(4);
		} else if (upgradeID==3){
			upgrade.setReliabilityMod(.1);
		} else if (upgradeID==4){
			upgrade.setEfficiencyMod(.075);
		}else if (upgradeID==5){
			upgrade.setTopSpeedMod(10);
			upgrade.setAccelerationMod(2);
		}
		return upgrade;
	}
	
	public static Racecar getRandomOponentByClass(char racingClass){
		String model;
		if (racingClass=='E'){
			model="red_sedan";
		} else {
			model="red_fer";
		}
		Racecar car=new Racecar(null, racingClass, 100*(1-(Math.random()/4)), 20*(1-(Math.random()/4)), .7*(1-(Math.random()/4)), .5*(1-(Math.random()/2)), model, 0);
		return car;
	}
	
	public static double getPurseByClass(char racingClass, Integer place){
		double dReturn=0.0;
		if (racingClass=='E'){
			if (place==1){
				dReturn = 500;
			} else if (place==2){
				dReturn = 250;
			} else if (place==3){
				dReturn = 100;
			}
		} else if (racingClass=='D'){
			if (place==1){
				dReturn = 1500;
			} else if (place==2){
				dReturn = 750;
			} else if (place==3){
				dReturn = 300;
			}
		} else if (racingClass=='C'){
			if (place==1){
				dReturn = 5000;
			} else if (place==2){
				dReturn = 2500;
			} else if (place==3){
				dReturn = 1000;
			}
		} else if (racingClass=='B'){
			if (place==1){
				dReturn = 10000;
			} else if (place==2){
				dReturn = 5000;
			} else if (place==3){
				dReturn = 2000;
			}
		} else if (racingClass=='A'){
			if (place==1){
				dReturn = 25000;
			} else if (place==2){
				dReturn = 12500;
			} else if (place==3){
				dReturn = 5000;
			}
		} else if (racingClass=='S'){
			if (place==1){
				dReturn = 100000;
			} else if (place==2){
				dReturn = 25000;
			} else if (place==3){
				dReturn = 10000;
			}
		}
		return dReturn;
	}
	
	public static Integer getNumberOfLaps(){
		Integer iReturn;
		double rand = Math.random();
		if (rand<.1){
			iReturn=2;
		} else if (rand<.5){
			iReturn=3;
		} else if (rand<.8){
			iReturn=4;
		} else {
			iReturn=5;
		}
		return iReturn;
	}
	
	public static Integer getLapDistanceByClass(char racingClass){
		Integer iReturn=500;
		double rand = Math.random();
		if (racingClass=='E'){
			if (rand<.2){
				iReturn=300;
			} else if (rand<.4){
				iReturn=400;
			} else if (rand<.6){
				iReturn=500;
			} else if (rand<.8){
				iReturn=600;
			} else {
				iReturn=700;
			}
		} else if (racingClass=='D'){
			if (rand<.2){
				iReturn=300;
			} else if (rand<.4){
				iReturn=400;
			} else if (rand<.6){
				iReturn=500;
			} else if (rand<.8){
				iReturn=600;
			} else {
				iReturn=700;
			}	
		} else if (racingClass=='C'){
			if (rand<.2){
				iReturn=300;
			} else if (rand<.4){
				iReturn=400;
			} else if (rand<.6){
				iReturn=500;
			} else if (rand<.8){
				iReturn=600;
			} else {
				iReturn=700;
			}	
		} else if (racingClass=='B'){
			if (rand<.2){
				iReturn=300;
			} else if (rand<.4){
				iReturn=400;
			} else if (rand<.6){
				iReturn=500;
			} else if (rand<.8){
				iReturn=600;
			} else {
				iReturn=700;
			}	
		} else if (racingClass=='A'){
			if (rand<.2){
				iReturn=300;
			} else if (rand<.4){
				iReturn=400;
			} else if (rand<.6){
				iReturn=500;
			} else if (rand<.8){
				iReturn=600;
			} else {
				iReturn=700;
			}	
		} else if (racingClass=='S'){
			if (rand<.2){
				iReturn=300;
			} else if (rand<.4){
				iReturn=400;
			} else if (rand<.6){
				iReturn=500;
			} else if (rand<.8){
				iReturn=600;
			} else {
				iReturn=700;
			}	
		}
		return iReturn;
	}
	
	public static String formatMoney(double value){
		NumberFormat formatter = NumberFormat.getCurrencyInstance();
		return formatter.format(value);
	}
}
