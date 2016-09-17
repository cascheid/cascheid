package site.blitzball;

import java.util.List;

public class BlitzballTech implements java.io.Serializable {

	private static final long serialVersionUID = 2349234803851167981L;

	private Integer techID;
	private String techName;
	private String techDescription;
	private String techType;
	private Integer hpCost;
	private Integer statMod;
	private Double effectChance;
	
	public BlitzballTech(){}
	
	public Integer getTechID() {
		return techID;
	}
	public void setTechID(Integer techID) {
		this.techID = techID;
	}
	public String getTechName() {
		return techName;
	}
	public void setTechName(String techName) {
		this.techName = techName;
	}
	public String getTechDescription() {
		return techDescription;
	}
	public void setTechDescription(String techDescription) {
		this.techDescription = techDescription;
	}
	public String getTechType() {
		return techType;
	}
	public void setTechType(String techType) {
		this.techType = techType;
	}
	public Integer getHpCost() {
		return hpCost;
	}
	public void setHpCost(Integer hpCost) {
		this.hpCost = hpCost;
	}
	public Integer getStatMod() {
		return statMod;
	}
	public void setStatMod(Integer statMod) {
		this.statMod = statMod;
	}

	public Double getEffectChance() {
		return effectChance;
	}

	public void setEffectChance(Double effectChance) {
		this.effectChance = effectChance;
	}
}
