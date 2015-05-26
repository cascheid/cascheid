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
			car=new Racecar(1, 100, 10, 0.7, "silver_audi2", 1000);
		} else if (carID==2){
			car=new Racecar(2, 120, 9, 0.5, "red_fer", 750);
		} else if (carID==3){
			car=new Racecar(3, 90, 9, 0.9, "red_sedan", 400);
		} else if (carID==4){
			car=new Racecar(4, 150, 8, 0.35, "black_lambo", 2000);
		}else if (carID==5){
			car=new Racecar(5, 130, 8, 0.65, "silver_chevvy", 1500);
		} else {
			car=null;
		}
		return car;
	}
	
	public static Racecar getRandomOponentByClass(char racingClass){
		Racecar car=new Racecar(null, 200*(Math.random()/2), 18*(Math.random()/2), 1.5*(Math.random()/2), "red_sedan", 0);
		return car;
	}
	
	public static String formatMoney(double value){
		NumberFormat formatter = NumberFormat.getCurrencyInstance();
		return formatter.format(value);
	}
}
