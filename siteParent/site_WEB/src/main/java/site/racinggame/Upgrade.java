package site.racinggame;

import java.math.BigDecimal;

public class Upgrade implements java.io.Serializable{
	private static final long serialVersionUID = -40202005388083042L;
	
	private Integer upgradeID;
	private Integer topSpeedMod;
	private String racingClass;
	private Integer accelerationMod;
	private BigDecimal reliabilityMod;
	private BigDecimal efficiencyMod;
	private BigDecimal price;
	
	public Upgrade(){
	}

	public Integer getUpgradeID() {
		return upgradeID;
	}

	public void setUpgradeID(Integer upgradeID) {
		this.upgradeID = upgradeID;
	}

	public String getRacingClass() {
		return racingClass;
	}

	public void setRacingClass(String racingClass) {
		this.racingClass = racingClass;
	}

	public Integer getTopSpeedMod() {
		return topSpeedMod;
	}

	public void setTopSpeedMod(Integer topSpeedMod) {
		this.topSpeedMod = topSpeedMod;
	}

	public Integer getAccelerationMod() {
		return accelerationMod;
	}

	public void setAccelerationMod(Integer accelerationMod) {
		this.accelerationMod = accelerationMod;
	}

	public BigDecimal getReliabilityMod() {
		return reliabilityMod;
	}

	public void setReliabilityMod(BigDecimal reliabilityMod) {
		this.reliabilityMod = reliabilityMod;
	}

	public BigDecimal getEfficiencyMod() {
		return efficiencyMod;
	}

	public void setEfficiencyMod(BigDecimal efficiencyMod) {
		this.efficiencyMod = efficiencyMod;
	}

	public BigDecimal getPrice() {
		return price;
	}

	public void setPrice(BigDecimal price) {
		this.price = price;
	}
}
