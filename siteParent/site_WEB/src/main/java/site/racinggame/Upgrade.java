package site.racinggame;

public class Upgrade implements java.io.Serializable{
	private static final long serialVersionUID = -40202005388083042L;
	
	private Integer upgradeID;
	private Integer topSpeedMod;
	private char racingClass;
	private Double accelerationMod;
	private Double reliabilityMod;
	private Double efficiencyMod;
	private Double price;
	
	public Upgrade(){
	}

	public Integer getUpgradeID() {
		return upgradeID;
	}

	public void setUpgradeID(Integer upgradeID) {
		this.upgradeID = upgradeID;
	}

	public char getRacingClass() {
		return racingClass;
	}

	public void setRacingClass(char racingClass) {
		this.racingClass = racingClass;
	}

	public Integer getTopSpeedMod() {
		return topSpeedMod;
	}

	public void setTopSpeedMod(Integer topSpeedMod) {
		this.topSpeedMod = topSpeedMod;
	}

	public Double getAccelerationMod() {
		return accelerationMod;
	}

	public void setAccelerationMod(Double accelerationMod) {
		this.accelerationMod = accelerationMod;
	}

	public Double getReliabilityMod() {
		return reliabilityMod;
	}

	public void setReliabilityMod(Double reliabilityMod) {
		this.reliabilityMod = reliabilityMod;
	}

	public Double getEfficiencyMod() {
		return efficiencyMod;
	}

	public void setEfficiencyMod(Double efficiencyMod) {
		this.efficiencyMod = efficiencyMod;
	}

	public Double getPrice() {
		return price;
	}

	public void setPrice(Double price) {
		this.price = price;
	}
}
