package site.racinggame;

public class Racecar implements java.io.Serializable{
	
	private static final long serialVersionUID = -6448889763873084248L;
	
	private Integer carID;
	private double topSpeed;
	private double acceleration;
	private double reliability;
	private String model;
	private double price;
	
	public Racecar(){
	}

	public Racecar(Integer carID, double topSpeed, double acceleration, double reliability, String model, double price){
		this.carID=carID;
		this.topSpeed=topSpeed;
		this.acceleration=acceleration;
		this.reliability=reliability;
		this.model=model;
		this.setPrice(price);
	}
	
	public Integer getCarID() {
		return carID;
	}

	public void setCarID(Integer carID) {
		this.carID = carID;
	}

	public double getTopSpeed() {
		return topSpeed;
	}

	public void setTopSpeed(double topSpeed) {
		this.topSpeed = topSpeed;
	}

	public double getAcceleration() {
		return acceleration;
	}

	public void setAcceleration(double acceleration) {
		this.acceleration = acceleration;
	}

	public double getReliability() {
		return reliability;
	}

	public void setReliability(double reliability) {
		this.reliability = reliability;
	}

	public String getModel() {
		return model;
	}

	public void setModel(String model) {
		this.model = model;
	}

	public double getPrice() {
		return price;
	}

	public void setPrice(double price) {
		this.price = price;
	}
}
