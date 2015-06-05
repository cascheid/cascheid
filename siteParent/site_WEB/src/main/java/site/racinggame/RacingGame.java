package site.racinggame;

import java.util.ArrayList;
import java.util.List;

public class RacingGame implements java.io.Serializable{

	private static final long serialVersionUID = -1729577202981441935L;
	
	private Long racingIdentifier;
	private Integer carID;
	private UserRacecar selectedCar;
	private Double availableCash;
	private char racingClass;
	private char selectedClass;
	private List<UserRacecar> carList;
	
	public RacingGame(){
	}
	
	public RacingGame(Long racingIdentifier){
		this.racingIdentifier=racingIdentifier;
	}
	
	public Long getRacingIdentifier(){
		return racingIdentifier;
	}
	
	public void setRacingIdentifier(Long racingIdentifier){
		this.racingIdentifier=racingIdentifier;
	}

	public Integer getCarID() {
		return carID;
	}

	public void setCarID(Integer carID) {
		this.carID = carID;
	}

	public UserRacecar getSelectedCar() {
		return selectedCar;
	}

	public void setSelectedCar(UserRacecar selectedCar) {
		this.selectedCar = selectedCar;
	}

	public Double getAvailableCash() {
		return availableCash;
	}

	public void setAvailableCash(Double availableCash) {
		this.availableCash = availableCash;
	}

	public char getRacingClass() {
		return racingClass;
	}

	public void setRacingClass(char racingClass) {
		this.racingClass = racingClass;
	}
	
	public char getSelectedClass() {
		return selectedClass;
	}

	public void setSelectedClass(char selectedClass) {
		this.selectedClass = selectedClass;
	}

	public List<UserRacecar> getCarList(){
		return carList;
	}
	
	public void setCarList(List<UserRacecar> carList){
		if (carList!=null){
			this.carList=carList;
		}
	}
	
	public void addNewCar(Racecar car){
		if (carList==null){
			carList=new ArrayList<UserRacecar>();
		}
		carList.add(new UserRacecar(car));
	}
}
