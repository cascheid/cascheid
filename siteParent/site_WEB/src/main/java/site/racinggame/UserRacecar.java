package site.racinggame;

public class UserRacecar extends Racecar implements java.io.Serializable{
	
	private static final long serialVersionUID = 1843972156627922738L;
	
	private Upgrade upgrade1;
	private Upgrade upgrade2;
	private Upgrade upgrade3;
	private Upgrade upgrade4;
	private Upgrade upgrade5;
	
	public UserRacecar(){
	}

	public UserRacecar(Racecar car){
		super(car.getCarID(), car.getRacingClass(), car.getTopSpeed(), car.getAcceleration(), car.getReliability(), car.getLapEfficiency(), car.getModel(), car.getPrice());
	}

	public Upgrade getUpgrade1() {
		return upgrade1;
	}

	public void setUpgrade1(Upgrade upgrade1) {
		this.upgrade1 = upgrade1;
	}

	public Upgrade getUpgrade2() {
		return upgrade2;
	}

	public void setUpgrade2(Upgrade upgrade2) {
		this.upgrade2 = upgrade2;
	}

	public Upgrade getUpgrade3() {
		return upgrade3;
	}

	public void setUpgrade3(Upgrade upgrade3) {
		this.upgrade3 = upgrade3;
	}

	public Upgrade getUpgrade4() {
		return upgrade4;
	}

	public void setUpgrade4(Upgrade upgrade4) {
		this.upgrade4 = upgrade4;
	}

	public Upgrade getUpgrade5() {
		return upgrade5;
	}

	public void setUpgrade5(Upgrade upgrade5) {
		this.upgrade5 = upgrade5;
	}
	
	@Override
	public double getTopSpeed(){
		double dReturn = super.getTopSpeed();
		if (upgrade1!=null&&upgrade1.getTopSpeedMod()!=0){
			dReturn+=upgrade1.getTopSpeedMod();
		}
		if (upgrade2!=null&&upgrade2.getTopSpeedMod()!=0){
			dReturn+=upgrade2.getTopSpeedMod();
		}
		if (upgrade3!=null&&upgrade3.getTopSpeedMod()!=0){
			dReturn+=upgrade3.getTopSpeedMod();
		}
		if (upgrade4!=null&&upgrade4.getTopSpeedMod()!=0){
			dReturn+=upgrade4.getTopSpeedMod();
		}
		if (upgrade5!=null&&upgrade5.getTopSpeedMod()!=0){
			dReturn+=upgrade5.getTopSpeedMod();
		}
		return dReturn;
	}
	
	@Override
	public double getAcceleration(){
		double dReturn = super.getAcceleration();
		if (upgrade1!=null&&upgrade1.getAccelerationMod()!=0){
			dReturn+=upgrade1.getAccelerationMod();
		}
		if (upgrade2!=null&&upgrade2.getAccelerationMod()!=0){
			dReturn+=upgrade2.getAccelerationMod();
		}
		if (upgrade3!=null&&upgrade3.getAccelerationMod()!=0){
			dReturn+=upgrade3.getAccelerationMod();
		}
		if (upgrade4!=null&&upgrade4.getAccelerationMod()!=0){
			dReturn+=upgrade4.getAccelerationMod();
		}
		if (upgrade5!=null&&upgrade5.getAccelerationMod()!=0){
			dReturn+=upgrade5.getAccelerationMod();
		}
		return dReturn;
	}
	
	@Override
	public double getReliability(){
		double dReturn = super.getReliability();
		if (upgrade1!=null&&upgrade1.getReliabilityMod()!=0){
			dReturn+=upgrade1.getReliabilityMod();
		}
		if (upgrade2!=null&&upgrade2.getReliabilityMod()!=0){
			dReturn+=upgrade2.getReliabilityMod();
		}
		if (upgrade3!=null&&upgrade3.getReliabilityMod()!=0){
			dReturn+=upgrade3.getReliabilityMod();
		}
		if (upgrade4!=null&&upgrade4.getReliabilityMod()!=0){
			dReturn+=upgrade4.getReliabilityMod();
		}
		if (upgrade5!=null&&upgrade5.getReliabilityMod()!=0){
			dReturn+=upgrade5.getReliabilityMod();
		}
		return dReturn;
	}
	
	@Override
	public double getLapEfficiency(){
		double dReturn = super.getLapEfficiency();
		if (upgrade1!=null&&upgrade1.getEfficiencyMod()!=0){
			dReturn+=upgrade1.getEfficiencyMod();
		}
		if (upgrade2!=null&&upgrade2.getEfficiencyMod()!=0){
			dReturn+=upgrade2.getEfficiencyMod();
		}
		if (upgrade3!=null&&upgrade3.getEfficiencyMod()!=0){
			dReturn+=upgrade3.getEfficiencyMod();
		}
		if (upgrade4!=null&&upgrade4.getEfficiencyMod()!=0){
			dReturn+=upgrade4.getEfficiencyMod();
		}
		if (upgrade5!=null&&upgrade5.getEfficiencyMod()!=0){
			dReturn+=upgrade5.getEfficiencyMod();
		}
		return dReturn;
	}
	
}
