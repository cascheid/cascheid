package site.racinggame;

import java.math.BigDecimal;


public class RaceResult{
	
	private String racingClass;
	private String raceType;
	private String firstPlace;
	private BigDecimal firstPlaceTime;
	private String secondPlace;
	private BigDecimal secondPlaceTime;
	private String thirdPlace;
	private BigDecimal thirdPlaceTime;
	private Integer userFinish;
	private String newClass;
	
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
	public String getFirstPlace() {
		return firstPlace;
	}
	public void setFirstPlace(String firstPlace) {
		this.firstPlace = firstPlace;
	}
	public BigDecimal getFirstPlaceTime() {
		return firstPlaceTime;
	}
	public void setFirstPlaceTime(BigDecimal firstPlaceTime) {
		this.firstPlaceTime = firstPlaceTime;
	}
	public String getSecondPlace() {
		return secondPlace;
	}
	public void setSecondPlace(String secondPlace) {
		this.secondPlace = secondPlace;
	}
	public BigDecimal getSecondPlaceTime() {
		return secondPlaceTime;
	}
	public void setSecondPlaceTime(BigDecimal secondPlaceTime) {
		this.secondPlaceTime = secondPlaceTime;
	}
	public String getThirdPlace() {
		return thirdPlace;
	}
	public void setThirdPlace(String thirdPlace) {
		this.thirdPlace = thirdPlace;
	}
	public BigDecimal getThirdPlaceTime() {
		return thirdPlaceTime;
	}
	public void setThirdPlaceTime(BigDecimal thirdPlaceTime) {
		this.thirdPlaceTime = thirdPlaceTime;
	}
	public Integer getUserFinish() {
		return userFinish;
	}
	public void setUserFinish(Integer userFinish) {
		this.userFinish = userFinish;
	}
	public String getNewClass() {
		return newClass;
	}
	public void setNewClass(String newClass) {
		this.newClass = newClass;
	}
	
}
