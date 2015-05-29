package site.racinggame;

public class Upgrade implements java.io.Serializable{
	private static final long serialVersionUID = -40202005388083042L;
	
	private double upgradeID;
	private double topSpeedMod;
	private double accelerationMod;
	private double reliabilityMod;
	private double efficiencyMod;
	private double price;
	
	public Upgrade(){
	}

	public double getUpgradeID() {
		return upgradeID;
	}

	public void setUpgradeID(double upgradeID) {
		this.upgradeID = upgradeID;
	}

	public double getTopSpeedMod() {
		return topSpeedMod;
	}

	public void setTopSpeedMod(double topSpeedMod) {
		this.topSpeedMod = topSpeedMod;
	}

	public double getAccelerationMod() {
		return accelerationMod;
	}

	public void setAccelerationMod(double accelerationMod) {
		this.accelerationMod = accelerationMod;
	}

	public double getReliabilityMod() {
		return reliabilityMod;
	}

	public void setReliabilityMod(double reliabilityMod) {
		this.reliabilityMod = reliabilityMod;
	}

	public double getEfficiencyMod() {
		return efficiencyMod;
	}

	public void setEfficiencyMod(double efficiencyMod) {
		this.efficiencyMod = efficiencyMod;
	}

	public double getPrice() {
		return price;
	}

	public void setPrice(double price) {
		this.price = price;
	}
}
