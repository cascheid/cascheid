package site.racinggame;


public class RaceResult implements java.io.Serializable{
	
	private static final long serialVersionUID = 7462149165977234290L;
	
	private char racingClass;
	private String raceType;
	private String place1;
	private Double place1Time;
	private String place2;
	private Double place2Time;
	private String place3;
	private Double place3Time;
	private String place4;
	private Double place4Time;
	private String place5;
	private Double place5Time;
	private String place6;
	private Double place6Time;
	
	public RaceResult(){
	}
	
	public char getRacingClass() {
		return racingClass;
	}

	public void setRacingClass(char racingClass) {
		this.racingClass = racingClass;
	}

	public String getRaceType() {
		return raceType;
	}

	public void setRaceType(String raceType) {
		this.raceType = raceType;
	}

	public String getPlace1() {
		return place1;
	}

	public void setPlace1(String place1) {
		this.place1 = place1;
	}

	public Double getPlace1Time() {
		return place1Time;
	}

	public void setPlace1Time(Double place1Time) {
		this.place1Time = place1Time;
	}

	public String getPlace2() {
		return place2;
	}

	public void setPlace2(String place2) {
		this.place2 = place2;
	}

	public Double getPlace2Time() {
		return place2Time;
	}

	public void setPlace2Time(Double place2Time) {
		this.place2Time = place2Time;
	}

	public String getPlace3() {
		return place3;
	}

	public void setPlace3(String place3) {
		this.place3 = place3;
	}

	public Double getPlace3Time() {
		return place3Time;
	}

	public void setPlace3Time(Double place3Time) {
		this.place3Time = place3Time;
	}

	public String getPlace4() {
		return place4;
	}

	public void setPlace4(String place4) {
		this.place4 = place4;
	}

	public Double getPlace4Time() {
		return place4Time;
	}

	public void setPlace4Time(Double place4Time) {
		this.place4Time = place4Time;
	}

	public String getPlace5() {
		return place5;
	}

	public void setPlace5(String place5) {
		this.place5 = place5;
	}

	public Double getPlace5Time() {
		return place5Time;
	}

	public void setPlace5Time(Double place5Time) {
		this.place5Time = place5Time;
	}

	public String getPlace6() {
		return place6;
	}

	public void setPlace6(String place6) {
		this.place6 = place6;
	}

	public Double getPlace6Time() {
		return place6Time;
	}

	public void setPlace6Time(Double place6Time) {
		this.place6Time = place6Time;
	}

}
