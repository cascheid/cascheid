package site.racinggame;

import java.math.BigDecimal;

public class Racecar implements java.io.Serializable{
	
	private static final long serialVersionUID = -6448889763873084248L;
	
	private Integer carID;
	private String racingClass;
	private Integer topSpeed;
	private Integer acceleration;
	private BigDecimal reliability;
	private BigDecimal lapEfficiency;
	private String model;
	private BigDecimal price;
	private String name;
	
	public Racecar(){
	}

	public Racecar(Integer carID, String racingClass, Integer topSpeed, Integer acceleration, BigDecimal reliability, BigDecimal lapEfficiency, String model, BigDecimal price, String name){
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

	public Integer getAcceleration() {
		return acceleration;
	}

	public void setAcceleration(Integer acceleration) {
		this.acceleration = acceleration;
	}

	public BigDecimal getReliability() {
		return reliability;
	}

	public void setReliability(BigDecimal reliability) {
		this.reliability = reliability;
	}

	public BigDecimal getLapEfficiency() {
		return lapEfficiency;
	}

	public void setLapEfficiency(BigDecimal lapEfficiency) {
		this.lapEfficiency = lapEfficiency;
	}

	public String getModel() {
		return model;
	}

	public void setModel(String model) {
		this.model = model;
	}

	public BigDecimal getPrice() {
		return price;
	}

	public void setPrice(BigDecimal price) {
		this.price = price;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
}
