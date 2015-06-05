package site.racinggame;

import java.math.BigDecimal;


public class RaceInfo implements java.io.Serializable{
	
	private static final long serialVersionUID = 7462149165977234290L;
	
	private char racingClass;
	private String courseType;
	private String raceType;
	private BigDecimal racingFee;
	private Integer lapDistance;
	private Integer noLaps;
	
	public RaceInfo(){
	}
	
	public char getRacingClass() {
		return racingClass;
	}

	public void setRacingClass(char racingClass) {
		this.racingClass = racingClass;
	}

	public String getCourseType() {
		return courseType;
	}

	public void setCourseType(String courseType) {
		this.courseType = courseType;
	}

	public String getRaceType() {
		return raceType;
	}

	public void setRaceType(String raceType) {
		this.raceType = raceType;
	}

	public BigDecimal getRacingFee() {
		return racingFee;
	}

	public void setRacingFee(BigDecimal racingFee) {
		this.racingFee = racingFee;
	}

	public Integer getLapDistance() {
		return lapDistance;
	}

	public void setLapDistance(Integer lapDistance) {
		this.lapDistance = lapDistance;
	}

	public Integer getNoLaps() {
		return noLaps;
	}

	public void setNoLaps(Integer noLaps) {
		this.noLaps = noLaps;
	}

}
