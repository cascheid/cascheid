package site.blitzball;

import java.util.ArrayList;
import java.util.List;

public class BlitzballPlayer implements java.io.Serializable {
	
	private static final long serialVersionUID = 560180821141886924L;
	
	private Integer playerID;
	private Long teamID;
	private String name;
	private Integer level;
	private Integer experience;
	private Integer nextExp;
	private Integer speed;
	private Integer endurance;
	private Integer hp;
	private Integer attack;
	private Integer pass;
	private Integer shot;
	private Integer block;
	private Integer cat;//catch
	private Integer contractLength;
	private String model;
	private List<Integer> learnedTechs;
	private List<Integer> learnableTechs;
	private BlitzballTech tech1;
	private BlitzballTech tech2;
	private BlitzballTech tech3;
	private BlitzballTech tech4;
	private BlitzballTech tech5;
	private BlitzballTech keyTech1;
	private BlitzballTech keyTech2;
	private BlitzballTech keyTech3;
	
	public BlitzballPlayer(){}
	
	public Integer getPlayerID() {
		return playerID;
	}
	public void setPlayerID(Integer playerID) {
		this.playerID = playerID;
	}
	public Long getTeamID() {
		return teamID;
	}
	public void setTeamID(Long teamID) {
		this.teamID = teamID;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Integer getLevel() {
		return level;
	}
	public void setLevel(Integer level) {
		this.level = level;
	}
	public Integer getExperience() {
		return experience;
	}

	public void setExperience(Integer experience) {
		this.experience = experience;
	}

	public Integer getNextExp() {
		return nextExp;
	}
	public void setNextExp(Integer nextExp) {
		this.nextExp = nextExp;
	}
	public Integer getSpeed() {
		return speed;
	}
	public void setSpeed(Integer speed) {
		this.speed = speed;
	}
	public Integer getEndurance() {
		return endurance;
	}
	public void setEndurance(Integer endurance) {
		this.endurance = endurance;
	}
	public Integer getHp() {
		return hp;
	}
	public void setHp(Integer hp) {
		this.hp = hp;
	}
	public Integer getAttack() {
		return attack;
	}
	public void setAttack(Integer attack) {
		this.attack = attack;
	}
	public Integer getPass() {
		return pass;
	}
	public void setPass(Integer pass) {
		this.pass = pass;
	}
	public Integer getShot() {
		return shot;
	}
	public void setShot(Integer shot) {
		this.shot = shot;
	}
	public Integer getBlock() {
		return block;
	}
	public void setBlock(Integer block) {
		this.block = block;
	}
	public Integer getCat() {
		return cat;
	}
	public void setCat(Integer cat) {
		this.cat = cat;
	}
	public Integer getContractLength() {
		return contractLength;
	}
	public void setContractLength(Integer contractLength) {
		this.contractLength = contractLength;
	}
	public String getModel() {
		return model;
	}

	public void setModel(String model) {
		this.model = model;
	}

	public List<Integer> getLearnedTechs() {
		return learnedTechs;
	}
	public void setLearnedTechs(List<Integer> learnedTechs) {
		this.learnedTechs = learnedTechs;
	}
	public List<Integer> getLearnableTechs() {
		return learnableTechs;
	}
	public void setLearnableTechs(List<Integer> learnableTechs) {
		this.learnableTechs = learnableTechs;
	}
	public BlitzballTech getTech1() {
		return tech1;
	}
	public void setTech1(BlitzballTech tech1) {
		this.tech1 = tech1;
	}
	public BlitzballTech getTech2() {
		return tech2;
	}
	public void setTech2(BlitzballTech tech2) {
		this.tech2 = tech2;
	}
	public BlitzballTech getTech3() {
		return tech3;
	}
	public void setTech3(BlitzballTech tech3) {
		this.tech3 = tech3;
	}
	public BlitzballTech getTech4() {
		return tech4;
	}
	public void setTech4(BlitzballTech tech4) {
		this.tech4 = tech4;
	}
	public BlitzballTech getTech5() {
		return tech5;
	}
	public void setTech5(BlitzballTech tech5) {
		this.tech5 = tech5;
	}
	public BlitzballTech getKeyTech1() {
		return keyTech1;
	}
	public void setKeyTech1(BlitzballTech keyTech1) {
		this.keyTech1 = keyTech1;
	}
	public BlitzballTech getKeyTech2() {
		return keyTech2;
	}
	public void setKeyTech2(BlitzballTech keyTech2) {
		this.keyTech2 = keyTech2;
	}
	public BlitzballTech getKeyTech3() {
		return keyTech3;
	}
	public void setKeyTech3(BlitzballTech keyTech3) {
		this.keyTech3 = keyTech3;
	}
	public List<Integer> getCurrentTechs(){
		List<Integer> returnList = new ArrayList<Integer>();
		if (tech1!=null){
			returnList.add(tech1.getTechID());
		}
		if (tech2!=null){
			returnList.add(tech2.getTechID());
		}
		if (tech3!=null){
			returnList.add(tech3.getTechID());
		}
		if (tech4!=null){
			returnList.add(tech4.getTechID());
		}
		if (tech5!=null){
			returnList.add(tech5.getTechID());
		}
		return returnList;
	}
}
