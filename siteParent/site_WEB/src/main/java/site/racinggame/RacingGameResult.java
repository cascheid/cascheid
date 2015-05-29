package site.racinggame;

public class RacingGameResult implements java.io.Serializable{
	
	private static final long serialVersionUID = 6545498549477509325L;
	
	private char racingClass;
	private String firstPlace;
	private double firstPlaceTime;
	private String secondPlace;
	private double secondPlaceTime;
	private String thirdPlace;
	private double thirdPlaceTime;
	
	public RacingGameResult(){
	}

	public char getRacingClass() {
		return racingClass;
	}

	public void setRacingClass(char racingClass) {
		this.racingClass = racingClass;
	}

	public String getFirstPlace() {
		return firstPlace;
	}

	public void setFirstPlace(String firstPlace) {
		this.firstPlace = firstPlace;
	}

	public double getFirstPlaceTime() {
		return firstPlaceTime;
	}

	public void setFirstPlaceTime(double firstPlaceTime) {
		this.firstPlaceTime = firstPlaceTime;
	}

	public String getSecondPlace() {
		return secondPlace;
	}

	public void setSecondPlace(String secondPlace) {
		this.secondPlace = secondPlace;
	}

	public double getSecondPlaceTime() {
		return secondPlaceTime;
	}

	public void setSecondPlaceTime(double secondPlaceTime) {
		this.secondPlaceTime = secondPlaceTime;
	}

	public String getThirdPlace() {
		return thirdPlace;
	}

	public void setThirdPlace(String thirdPlace) {
		this.thirdPlace = thirdPlace;
	}

	public double getThirdPlaceTime() {
		return thirdPlaceTime;
	}

	public void setThirdPlaceTime(double thirdPlaceTime) {
		this.thirdPlaceTime = thirdPlaceTime;
	}
	
	public void reset(){
		this.firstPlace=null;
		this.firstPlaceTime=0;
		this.secondPlace=null;
		this.secondPlaceTime=0;
		this.thirdPlace=null;
		this.thirdPlaceTime=0;
		this.racingClass=' ';
	}
	
}
