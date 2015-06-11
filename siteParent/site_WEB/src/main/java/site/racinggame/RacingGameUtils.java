package site.racinggame;

import java.text.NumberFormat;
import java.util.List;

import site.dao.RacingGameDao;
import site.dao.RacingGameDaoImpl;

public class RacingGameUtils {
	
	public static RacingGame getRacingGameObject(Long racingGameIdentifier, Long identifier){
		RacingGame racingGame;
		RacingGameDao dao = new RacingGameDaoImpl();
		if (racingGameIdentifier==null||racingGameIdentifier<=0){
			racingGame=new RacingGame();
			racingGame.setRacingClass("E");
			racingGame.setSelectedClass("E");
			racingGame.setAvailableCash(100.0);
			racingGame.setCarID(1);
			racingGame.addNewCar(getRacecarByID(1));
			racingGame.setSelectedCar(racingGame.getCarList().get(0));
			Long newID;
			try{
				newID=dao.insertNewRacingGame(racingGame, identifier);
			} catch (Exception e){
				throw new IllegalStateException("Failed to insert new Racing Game record.", e);
			}
			racingGame.setRacingIdentifier(newID);
		} else {
			try{
				racingGame=dao.getRacingGameByID(racingGameIdentifier);
				racingGame.setCarID(racingGame.getCarList().get(0).getCarID());
				racingGame.setSelectedCar(racingGame.getCarList().get(0));
				racingGame.setSelectedClass(racingGame.getRacingClass());
			} catch (Exception e){
				throw new IllegalStateException("Failed to get Racing Game record for identifier: " + racingGameIdentifier, e);
			}
		}
		return racingGame;
	}
	
	public static Racecar getRacecarByID(Integer carID){
		Racecar car=null;
		try{
			RacingGameDao dao = new RacingGameDaoImpl();
			car=dao.getRacecarByID(carID);
		} catch (Exception e){
			throw new IllegalStateException("Failed to get Racecar for ID: " + carID,e);
		}
		return car;
	}
	
	public static Upgrade getUpgradeByID(Integer upgradeID){
		Upgrade upgrade = null;
		try{
			RacingGameDao dao = new RacingGameDaoImpl();
			upgrade = dao.getUpgradeByID(upgradeID);
		} catch (Exception e){
			throw new IllegalStateException("Failed to get Upgrade for ID: " + upgradeID,e);
		}
		return upgrade;
	}
	
	public static List<Upgrade> getUpgradesByClass(String racingClass){
		List<Upgrade> upgradeList;
		try{
			RacingGameDao dao = new RacingGameDaoImpl();
			upgradeList = dao.getUpgradesByClass(racingClass);
		} catch (Exception e){
			throw new IllegalStateException("Failed to get Upgrades for racing class: " + racingClass,e);
		}
		return upgradeList;
	}
	
	public static List<Racecar> getRandomOpponentsByClass(String racingClass){
		List<Racecar> carList;
		try{
			RacingGameDao dao = new RacingGameDaoImpl();
			carList = dao.getRandomOpponentsByClass(racingClass);
		} catch (Exception e){
			throw new IllegalStateException("Failed to get Opponents for racing class: " + racingClass,e);
		}
		for (Racecar car : carList){
			car.setTopSpeed((int)Math.round(car.getTopSpeed()*(1-(.5-Math.random())/2)));
			car.setAcceleration(car.getAcceleration()*(1-(.5-Math.random())/2));
			car.setReliability(car.getReliability()*(1-(.5-Math.random())/2));
			car.setLapEfficiency(car.getLapEfficiency()*(1-(.5-Math.random())/2));
		}
		return carList;
	}
	
	public static List<Racecar> getAvailableCarsToPurchase(String racingClass, Long racingIdentifier){
		List<Racecar> carList;
		try{
			RacingGameDao dao = new RacingGameDaoImpl();
			carList = dao.getAvailableCarsToPurchase(racingClass, racingIdentifier);
		} catch (Exception e){
			throw new IllegalStateException("Failed to get Opponents for racing class: " + racingClass,e);
		}
		return carList;
	}
	
	public static Double getPurseByClass(String racingClass, Integer place){
		Double dReturn=0.0;
		if ("E".equals(racingClass)){
			if (place==1){
				dReturn = 500.0;
			} else if (place==2){
				dReturn = 250.0;
			} else if (place==3){
				dReturn = 100.0;
			}
		} else if ("D".equals(racingClass)){
			if (place==1){
				dReturn = 1500.0;
			} else if (place==2){
				dReturn = 750.0;
			} else if (place==3){
				dReturn = 300.0;
			}
		} else if ("C".equals(racingClass)){
			if (place==1){
				dReturn = 5000.0;
			} else if (place==2){
				dReturn = 2500.0;
			} else if (place==3){
				dReturn = 1000.0;
			}
		} else if ("B".equals(racingClass)){
			if (place==1){
				dReturn = 10000.0;
			} else if (place==2){
				dReturn = 5000.0;
			} else if (place==3){
				dReturn = 2000.0;
			}
		} else if ("A".equals(racingClass)){
			if (place==1){
				dReturn = 25000.0;
			} else if (place==2){
				dReturn = 12500.0;
			} else if (place==3){
				dReturn = 5000.0;
			}
		} else if ("S".equals(racingClass)){
			if (place==1){
				dReturn = 100000.0;
			} else if (place==2){
				dReturn = 25000.0;
			} else if (place==3){
				dReturn = 10000.0;
			}
		}
		return dReturn;
	}
	
	public static Integer getNumberOfLaps(){
		Integer iReturn;
		Double rand = Math.random();
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
	
	public static Integer getLapDistanceByClass(String racingClass){
		Integer iReturn=500;
		Double rand = Math.random();
		if ("E".equals(racingClass)){
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
		} else if ("D".equals(racingClass)){
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
		} else if ("C".equals(racingClass)){
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
		} else if ("B".equals(racingClass)){
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
		} else if ("A".equals(racingClass)){
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
		} else if ("S".equals(racingClass)){
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
	
	public static Long saveNewCar(Long racingGameIdentifier, Integer carID){
		RacingGameDao dao = new RacingGameDaoImpl();
		Long lReturn;
		try{
			lReturn=dao.addNewUserRacecar(racingGameIdentifier, carID);
		}catch (Exception e){
			e.printStackTrace();
			throw new IllegalStateException("Failed to add car ID: " + carID + " to racing game: " +racingGameIdentifier, e);
		}
		return lReturn;
	}
	
	public static void addNewUpgrade(UserRacecar userRacecar, Upgrade upgrade){
		RacingGameDao dao = new RacingGameDaoImpl();
		if (!userRacecar.getRacingClass().equals(upgrade.getRacingClass())){
			throw new IllegalStateException("Cannot add upgrade of class " + upgrade.getRacingClass() + " to car of class " + userRacecar.getRacingClass());
		}
		try{
			dao.addNewUpgrade(userRacecar.getUserRacecarID(), upgrade.getUpgradeID());
		}catch (Exception e){
			e.printStackTrace();
			throw new IllegalStateException("Failed to add upgrade ID: " + upgrade.getUpgradeID() + " to user racecar id: " +userRacecar.getUserRacecarID(), e);
		}
	}
	
	public static String formatMoney(Double value){
		NumberFormat formatter = NumberFormat.getCurrencyInstance();
		return formatter.format(value);
	}
	
	public static void updateRacingGame(Long racingGameIdentifier, Double availableCash, String racingClass){
		RacingGameDao dao = new RacingGameDaoImpl();
		dao.updateRacingGame(racingGameIdentifier, availableCash, racingClass);
	}
}
