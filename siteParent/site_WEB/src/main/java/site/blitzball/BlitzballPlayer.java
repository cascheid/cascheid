package site.blitzball;

import java.util.List;

public class BlitzballPlayer implements java.io.Serializable {
	
	private static final long serialVersionUID = 560180821141886924L;
	
	private Integer playerID;
	private Long teamID;
	private String name;
	private Integer level;
	private Integer nextExp;
	private Integer speed;
	private Integer endurance;
	private Integer hp;
	private Integer attack;
	private Integer pass;
	private Integer shot;
	private Integer block;
	private Integer cat;//catch
	private Integer salary;
	private Integer contractLength;
	private List<Integer> learnedTechs;
	private List<Integer> learnableTechs;
	private Integer tech1;
	private Integer tech2;
	private Integer tech3;
	private Integer tech4;
	private Integer tech5;
	private Integer keyTech1;
	private Integer keyTech2;
	private Integer keyTech3;
	
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
	public Integer getSalary() {
		return salary;
	}
	public void setSalary(Integer salary) {
		this.salary = salary;
	}
	public Integer getContractLength() {
		return contractLength;
	}
	public void setContractLength(Integer contractLength) {
		this.contractLength = contractLength;
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
	public Integer getTech1() {
		return tech1;
	}
	public void setTech1(Integer tech1) {
		this.tech1 = tech1;
	}
	public Integer getTech2() {
		return tech2;
	}
	public void setTech2(Integer tech2) {
		this.tech2 = tech2;
	}
	public Integer getTech3() {
		return tech3;
	}
	public void setTech3(Integer tech3) {
		this.tech3 = tech3;
	}
	public Integer getTech4() {
		return tech4;
	}
	public void setTech4(Integer tech4) {
		this.tech4 = tech4;
	}
	public Integer getTech5() {
		return tech5;
	}
	public void setTech5(Integer tech5) {
		this.tech5 = tech5;
	}
	public Integer getKeyTech1() {
		return keyTech1;
	}
	public void setKeyTech1(Integer keyTech1) {
		this.keyTech1 = keyTech1;
	}
	public Integer getKeyTech2() {
		return keyTech2;
	}
	public void setKeyTech2(Integer keyTech2) {
		this.keyTech2 = keyTech2;
	}
	public Integer getKeyTech3() {
		return keyTech3;
	}
	public void setKeyTech3(Integer keyTech3) {
		this.keyTech3 = keyTech3;
	}
}
