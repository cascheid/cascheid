package site.racinggame;


public class RaceInfo{
	
	private String racingClass;
	private String raceType;
	private Integer lapDistance;
	private Integer noLaps;
	private Racecar racer1;
	private Racecar racer2;
	private Racecar racer3;
	private Racecar racer4;
	private Racecar racer5;
	private Racecar racer6;
	
	public RaceInfo(){
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

	public Racecar getRacer1() {
		return racer1;
	}

	public void setRacer1(Racecar racer1) {
		this.racer1 = racer1;
	}

	public Racecar getRacer2() {
		return racer2;
	}

	public void setRacer2(Racecar racer2) {
		this.racer2 = racer2;
	}

	public Racecar getRacer3() {
		return racer3;
	}

	public void setRacer3(Racecar racer3) {
		this.racer3 = racer3;
	}

	public Racecar getRacer4() {
		return racer4;
	}

	public void setRacer4(Racecar racer4) {
		this.racer4 = racer4;
	}

	public Racecar getRacer5() {
		return racer5;
	}

	public void setRacer5(Racecar racer5) {
		this.racer5 = racer5;
	}

	public Racecar getRacer6() {
		return racer6;
	}

	public void setRacer6(Racecar racer6) {
		this.racer6 = racer6;
	}
	
	public void addRacer(Racecar racer){
		if (this.racer1==null){
			this.racer1=racer;
		} else if (this.racer2==null){
			this.racer2=racer;
		} else if (this.racer3==null){
			this.racer3=racer;
		} else if (this.racer4==null){
			this.racer4=racer;
		} else if (this.racer5==null){
			this.racer5=racer;
		} else if (this.racer6==null){
			this.racer6=racer;
		}
	}

}
