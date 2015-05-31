package site.racinggame;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.text.NumberFormat;
import java.util.Properties;

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
		Racecar car=null;
		Properties prop=new Properties();
		InputStream input=null;
		try {
			input=Thread.currentThread().getContextClassLoader().getResourceAsStream("CarList.properties");
			prop.load(input);
			char racingClass=prop.getProperty(carID+"Class").charAt(0);
			double topSpeed=Double.parseDouble(prop.getProperty(carID+"TopSpeed"));
			double accel=Double.parseDouble(prop.getProperty(carID+"Acceleration"));
			double reliability=Double.parseDouble(prop.getProperty(carID+"Reliability"));
			double lapEfficiency=Double.parseDouble(prop.getProperty(carID+"LapEfficiency"));
			double price=Double.parseDouble(prop.getProperty(carID+"Price"));
			String model = prop.getProperty(carID+"Model");
			car = new Racecar(carID, racingClass, topSpeed, accel, reliability, lapEfficiency, model, price);
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			if (input!=null){
				try {
					input.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
		return car;
	}
	
	public static Upgrade getUpgradeByID(Integer upgradeID, char carClass){
		Upgrade upgrade = new Upgrade();
		upgrade.setUpgradeID(upgradeID);
		if (carClass=='E'){
			upgrade.setPrice(100);
		} else if (carClass=='D'){
			upgrade.setPrice(500);
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
		Racecar car=null;
		if (racingClass=='E'){
			car = getRacecarByID(1);
		} else if (racingClass=='D'){
			car = getRacecarByID(2);
		} else if (racingClass=='C'){
			car = getRacecarByID(3);
		}  else if (racingClass=='B'){
			car = getRacecarByID(4);
		}  else if (racingClass=='A'){
			car = getRacecarByID(5);
		}  else if (racingClass=='S'){
			car = getRacecarByID(6);
		} 
		car.setTopSpeed(car.getTopSpeed()*(1-(.5-Math.random())/2));
		car.setAcceleration(car.getAcceleration()*(1-(.5-Math.random())/2));
		car.setReliability(car.getReliability()*(1-(.5-Math.random())/2));
		car.setLapEfficiency(car.getLapEfficiency()*(1-(.5-Math.random())/2));
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
