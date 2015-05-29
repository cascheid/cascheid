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
	
	
}
