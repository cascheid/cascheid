package site.racinggame;

import java.util.ArrayList;
import java.util.List;

public class UserRacecar extends Racecar implements java.io.Serializable{
	
	private static final long serialVersionUID = 1843972156627922738L;
	
	private Long userRacecarID;
	private List<Upgrade> upgradeList = new ArrayList<Upgrade>();
	
	public UserRacecar(){
	}

	public UserRacecar(Racecar car){
		super(car.getCarID(), car.getRacingClass(), car.getTopSpeed(), car.getAcceleration(), car.getReliability(), car.getLapEfficiency(), car.getModel(), car.getPrice(), car.getName());
	}

	public Long getUserRacecarID() {
		return userRacecarID;
	}

	public void setUserRacecarID(Long userRacecarID) {
		this.userRacecarID = userRacecarID;
	}
	
	public List<Upgrade> getUpgradeList() {
		return upgradeList;
	}

	public void setUpgradeList(List<Upgrade> upgradeList) {
		if (upgradeList!=null){
			this.upgradeList = upgradeList;
		}
	}
	
	public void addUpgrade(Upgrade upgrade){
		upgradeList.add(upgrade);
	}

	@Override
	public Integer getTopSpeed(){
		Integer iReturn = super.getTopSpeed();
		for (Upgrade upgrade : upgradeList){
			if (upgrade.getTopSpeedMod()!=null){
				iReturn+=upgrade.getTopSpeedMod();
			}
		}
		return iReturn>400?400:iReturn;
	}
	
	@Override
	public Double getAcceleration(){
		Double dReturn = super.getAcceleration();
		for (Upgrade upgrade : upgradeList){
			if (upgrade.getAccelerationMod()!=null){
				dReturn+=upgrade.getAccelerationMod();
			}
		}
		return dReturn>80?80:dReturn;
	}
	
	@Override
	public Double getReliability(){
		Double dReturn = super.getReliability();
		for (Upgrade upgrade : upgradeList){
			if (upgrade.getReliabilityMod()!=null){
				dReturn+=upgrade.getReliabilityMod();
			}
		}
		return dReturn>1?1:dReturn;
	}
	
	@Override
	public Double getLapEfficiency(){
		Double dReturn = super.getLapEfficiency();
		for (Upgrade upgrade : upgradeList){
			if (upgrade.getEfficiencyMod()!=null){
				dReturn+=upgrade.getEfficiencyMod();
			}
		}
		return dReturn>.8?.8:dReturn;
	}
	
	@Override
	public String getRacingClass(){
		if (super.getRacingClass().equals("SS")){
			return "S";
		} else {
			return super.getRacingClass();
		}
	}
	
}
