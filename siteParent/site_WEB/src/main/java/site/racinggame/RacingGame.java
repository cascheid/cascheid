package site.racinggame;

import java.util.ArrayList;
import java.util.List;

public class RacingGame implements java.io.Serializable{

	private static final long serialVersionUID = -1729577202981441935L;
	
	private String racingIdentifier;
	private Integer carID;
	private double availableCash;
	private char racingClass;
	private List<UserRacecar> carList;
	
	public RacingGame(){
		this.racingIdentifier = RacingGameUtils.getNewRacingGameIdentifier();
		this.setCarID(1);
		this.setAvailableCash(500.00);
		this.setRacingClass('D');
		this.addNewCar(RacingGameUtils.getRacecarByID(1));
	}
	
	public RacingGame(String racingIdentifier){
		this.racingIdentifier=racingIdentifier;
	}
	
	public String getRacingIdentifier(){
		return racingIdentifier;
	}

	public Integer getCarID() {
		return carID;
	}

	public void setCarID(Integer carID) {
		this.carID = carID;
	}

	public double getAvailableCash() {
		return availableCash;
	}

	public void setAvailableCash(double availableCash) {
		this.availableCash = availableCash;
	}

	public char getRacingClass() {
		return racingClass;
	}

	public void setRacingClass(char racingClass) {
		this.racingClass = racingClass;
	}
	
	public List<UserRacecar> getCarList(){
		return carList;
	}
	
	public void addNewCar(Racecar car){
		if (carList==null){
			carList=new ArrayList<UserRacecar>();
		}
		carList.add(new UserRacecar(car));
	}
}
