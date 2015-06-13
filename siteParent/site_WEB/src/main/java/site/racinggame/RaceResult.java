package site.racinggame;

import java.math.BigDecimal;


public class RaceResult implements java.io.Serializable{
	
	private static final long serialVersionUID = 7462149165977234290L;
	
	private String racingClass;
	private String raceType;
	private String place1;
	private BigDecimal place1Time;
	private String place2;
	private BigDecimal place2Time;
	private String place3;
	private BigDecimal place3Time;
	private String place4;
	private BigDecimal place4Time;
	private String place5;
	private BigDecimal place5Time;
	private String place6;
	private BigDecimal place6Time;
	
	public RaceResult(){
	}
	
	public String getRacingClass() {
		return racingClass;
	}

	public void setRacingClass(String racingClass) {
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

	public BigDecimal getPlace1Time() {
		return place1Time;
	}

	public void setPlace1Time(BigDecimal place1Time) {
		this.place1Time = place1Time;
	}

	public String getPlace2() {
		return place2;
	}

	public void setPlace2(String place2) {
		this.place2 = place2;
	}

	public BigDecimal getPlace2Time() {
		return place2Time;
	}

	public void setPlace2Time(BigDecimal place2Time) {
		this.place2Time = place2Time;
	}

	public String getPlace3() {
		return place3;
	}

	public void setPlace3(String place3) {
		this.place3 = place3;
	}

	public BigDecimal getPlace3Time() {
		return place3Time;
	}

	public void setPlace3Time(BigDecimal place3Time) {
		this.place3Time = place3Time;
	}

	public String getPlace4() {
		return place4;
	}

	public void setPlace4(String place4) {
		this.place4 = place4;
	}

	public BigDecimal getPlace4Time() {
		return place4Time;
	}

	public void setPlace4Time(BigDecimal place4Time) {
		this.place4Time = place4Time;
	}

	public String getPlace5() {
		return place5;
	}

	public void setPlace5(String place5) {
		this.place5 = place5;
	}

	public BigDecimal getPlace5Time() {
		return place5Time;
	}

	public void setPlace5Time(BigDecimal place5Time) {
		this.place5Time = place5Time;
	}

	public String getPlace6() {
		return place6;
	}

	public void setPlace6(String place6) {
		this.place6 = place6;
	}

	public BigDecimal getPlace6Time() {
		return place6Time;
	}

	public void setPlace6Time(BigDecimal place6Time) {
		this.place6Time = place6Time;
	}

}
