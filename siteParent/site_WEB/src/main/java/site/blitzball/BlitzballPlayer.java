package site.blitzball;

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
}
