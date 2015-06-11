package site.racinggame;

import java.util.ArrayList;
import java.util.List;

public class RacingGame implements java.io.Serializable{

	private static final long serialVersionUID = -1729577202981441935L;
	
	private Long racingIdentifier;
	private Integer carID;
	private UserRacecar selectedCar;
	private Double availableCash;
	private String racingClass;
	private String selectedClass;
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

	public String getRacingClass() {
		return racingClass;
	}

	public void setRacingClass(String racingClass) {
		this.racingClass = racingClass;
	}
	
	public String getSelectedClass() {
		return selectedClass;
	}

	public void setSelectedClass(String selectedClass) {
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
