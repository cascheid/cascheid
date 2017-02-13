package site.racinggame;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public class RacingGame implements java.io.Serializable{

	private static final long serialVersionUID = -1729577202981441935L;
	
	private Long racingIdentifier;
	private UserRacecar selectedCar;
	private BigDecimal availableCash;
	private String racingClass;
	private String selectedClass;
	private List<UserRacecar> carList;
	private Map<String, List<Racecar>> purchaseableCars;
	private String selectedMode;
	
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

	public UserRacecar getSelectedCar() {
		return selectedCar;
	}

	public void setSelectedCar(UserRacecar selectedCar) {
		this.selectedCar = selectedCar;
	}

	public BigDecimal getAvailableCash() {
		return availableCash;
	}

	public void setAvailableCash(BigDecimal availableCash) {
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
	
	public void addNewCar(UserRacecar car){
		if (carList==null){
			carList=new ArrayList<UserRacecar>();
		}
		carList.add(new UserRacecar(car));
	}

	public String getSelectedMode() {
		return selectedMode;
	}

	public void setSelectedMode(String selectedMode) {
		this.selectedMode = selectedMode;
	}

	public Map<String, List<Racecar>> getPurchaseableCars() {
		return purchaseableCars;
	}

	public void setPurchaseableCars(Map<String, List<Racecar>> purchaseableCars) {
		this.purchaseableCars = purchaseableCars;
	}
}
