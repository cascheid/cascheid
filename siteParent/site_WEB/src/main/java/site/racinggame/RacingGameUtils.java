package site.racinggame;

import java.math.BigDecimal;
import java.text.NumberFormat;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;

import site.dao.RacingGameDao;
import site.dao.RacingGameDaoImpl;

public class RacingGameUtils {
	
	private static int classEPrize = 500;
	private static int classDPrize = 1500;
	private static int classCPrize = 5000;
	private static int classBPrize = 10000;
	private static int classAPrize = 25000;
	private static int classSPrize = 100000;
	
	public static RacingGame getRacingGameObject(Long racingGameIdentifier, Long identifier){
		RacingGame racingGame;
		RacingGameDao dao = new RacingGameDaoImpl();
		if (racingGameIdentifier==null||racingGameIdentifier<=0){
			racingGame=new RacingGame();
			racingGame.setRacingClass("E");
			racingGame.setSelectedClass("E");
			racingGame.setAvailableCash(new BigDecimal(100));
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
	
	public static List<Racecar> getSpectateCarsByClass(String racingClass){
		List<Racecar> carList = new ArrayList<Racecar>();
		try{
			int repCarID=1;
			if ("E".equals(racingClass)){
				repCarID=1;
			} else if ("D".equals(racingClass)){
				repCarID=20;
			} else if ("C".equals(racingClass)){
				repCarID=9;
			} else if ("B".equals(racingClass)){
				repCarID=35;
			} else if ("A".equals(racingClass)){
				repCarID=23;
			} else if ("S".equals(racingClass)){
				repCarID=40;
			}
			RacingGameDao dao = new RacingGameDaoImpl();
			Racecar car = null;
			car= dao.getRacecarByID(repCarID);
			carList.add(car);
			car = new Racecar(car.getCarID(), car.getRacingClass(), car.getTopSpeed(), car.getAcceleration(), car.getReliability(), car.getLapEfficiency(), car.getModel(), car.getPrice(), car.getName());
			carList.add(car);
			car = new Racecar(car.getCarID(), car.getRacingClass(), car.getTopSpeed(), car.getAcceleration(), car.getReliability(), car.getLapEfficiency(), car.getModel(), car.getPrice(), car.getName());
			carList.add(car);
			car = new Racecar(car.getCarID(), car.getRacingClass(), car.getTopSpeed(), car.getAcceleration(), car.getReliability(), car.getLapEfficiency(), car.getModel(), car.getPrice(), car.getName());
			carList.add(car);
		}catch (Exception e){
			throw new IllegalStateException("Failed to get spectate cars for racing class: " + racingClass,e);
		}
		return carList;
	}
	
	public static LinkedHashMap<String, Integer> getFeeMap(){
		LinkedHashMap<String, Integer> feeMap=new LinkedHashMap<String, Integer>();
		feeMap.put("E", 0);
		feeMap.put("D", classDPrize/10);
		feeMap.put("C", classCPrize/10);
		feeMap.put("B", classBPrize/10);
		feeMap.put("A", classAPrize/10);
		feeMap.put("S", classSPrize/10);
		return feeMap;
	}
	
	public static List<Racecar> getRandomOpponentsByClass(String racingClass){
		List<Racecar> carList;
		try{
			RacingGameDao dao = new RacingGameDaoImpl();
			String nextClass=null;
			int numNextClass=0;
			if ("E".equals(racingClass)){
				carList = dao.getRandomOpponentsByClass(racingClass, 5);
			} else {
				double rand = Math.random();
				if (rand<.1){
					numNextClass=3;
				} else if (rand<.6){
					numNextClass=2;
				} else if (rand<.9){
					numNextClass=1;
				}
				if ("D".equals(racingClass)){
					nextClass="C";
				} else if ("C".equals(racingClass)){
					nextClass="B";
				} else if ("B".equals(racingClass)){
					nextClass="A";
				} else if ("A".equals(racingClass)){
					nextClass="S";
				} else if ("S".equals(racingClass)){
					nextClass="SS";
				}
				carList = dao.getRandomOpponentsByClass(racingClass, 5-numNextClass);
				if (numNextClass>0){
					carList.addAll(dao.getRandomOpponentsByClass(nextClass, numNextClass));
				}
			}
		} catch (Exception e){
			throw new IllegalStateException("Failed to get Opponents for racing class: " + racingClass,e);
		}
		for (Racecar car : carList){
			car.setTopSpeed((int)Math.round(car.getTopSpeed()*(1-(.5-Math.random())/4)));
			car.setAcceleration((int)Math.round(car.getAcceleration()*(1-(.5-Math.random())/4)));
			car.setReliability(car.getReliability().multiply(new BigDecimal(1-(.5-Math.random())/4)));
			car.setLapEfficiency(car.getLapEfficiency().multiply(new BigDecimal(1-(.5-Math.random())/4)));
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
	
	public static BigDecimal getPurseByClass(String racingClass, Integer place){
		BigDecimal dReturn=new BigDecimal(0);
		Integer purse=classEPrize;
		if ("D".equals(racingClass)){
			purse=classDPrize;
		} else if ("C".equals(racingClass)){
			purse=classCPrize;
		} else if ("B".equals(racingClass)){
			purse=classBPrize;
		} else if ("A".equals(racingClass)){
			purse=classAPrize;
		} else if ("S".equals(racingClass)){
			purse=classSPrize;
		}
		if (place==1){
			dReturn = new BigDecimal(purse);
		} else if (place==2){
			dReturn = new BigDecimal(purse).divide(new BigDecimal(2));
		} else if (place==3){
			dReturn = new BigDecimal(purse).divide(new BigDecimal(5));
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
	
	public static String formatMoney(BigDecimal value){
		NumberFormat formatter = NumberFormat.getCurrencyInstance();
		return formatter.format(value);
	}
	
	public static void updateRacingGame(Long racingGameIdentifier, BigDecimal availableCash, String racingClass){
		RacingGameDao dao = new RacingGameDaoImpl();
		dao.updateRacingGame(racingGameIdentifier, availableCash, racingClass);
	}
}
