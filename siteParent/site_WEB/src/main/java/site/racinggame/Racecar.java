package site.racinggame;

public class Racecar implements java.io.Serializable{
	
	private static final long serialVersionUID = -6448889763873084248L;
	
	private Integer carID;
	private String racingClass;
	private Integer topSpeed;
	private Double acceleration;
	private Double reliability;
	private Double lapEfficiency;
	private String model;
	private Double price;
	private String name;
	
	public Racecar(){
	}

	public Racecar(Integer carID, String racingClass, Integer topSpeed, Double acceleration, Double reliability, Double lapEfficiency, String model, Double price, String name){
		this.carID=carID;
		this.racingClass=racingClass;
		this.topSpeed=topSpeed;
		this.acceleration=acceleration;
		this.reliability=reliability;
		this.lapEfficiency=lapEfficiency;
		this.model=model;
		this.setPrice(price);
		this.name=name;
	}
	
	public Integer getCarID() {
		return carID;
	}

	public void setCarID(Integer carID) {
		this.carID = carID;
	}

	public String getRacingClass() {
		return racingClass;
	}

	public void setRacingClass(String racingClass) {
		this.racingClass = racingClass;
	}

	public Integer getTopSpeed() {
		return topSpeed;
	}

	public void setTopSpeed(Integer topSpeed) {
		this.topSpeed = topSpeed;
	}

	public Double getAcceleration() {
		return acceleration;
	}

	public void setAcceleration(Double acceleration) {
		this.acceleration = acceleration;
	}

	public Double getReliability() {
		return reliability;
	}

	public void setReliability(Double reliability) {
		this.reliability = reliability;
	}

	public Double getLapEfficiency() {
		return lapEfficiency;
	}

	public void setLapEfficiency(Double lapEfficiency) {
		this.lapEfficiency = lapEfficiency;
	}

	public String getModel() {
		return model;
	}

	public void setModel(String model) {
		this.model = model;
	}

	public Double getPrice() {
		return price;
	}

	public void setPrice(Double price) {
		this.price = price;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
}
