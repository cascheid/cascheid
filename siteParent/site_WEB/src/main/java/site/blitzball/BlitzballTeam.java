package site.blitzball;

public class BlitzballTeam implements java.io.Serializable {

	private static final long serialVersionUID = 9069740686801226048L;

	private Long teamID;
	private String teamName;
	private BlitzballPlayer rightWing;
	private BlitzballPlayer leftWing;
	private BlitzballPlayer midfielder;
	private BlitzballPlayer rightBack;
	private BlitzballPlayer leftBack;
	private BlitzballPlayer keeper;
	private BlitzballPlayer bench1;
	private BlitzballPlayer bench2;
	private Integer wins;
	private Integer losses;
	private Integer ties;
	private Integer availableCash;
	
	public BlitzballTeam(){}
	public BlitzballTeam(Long teamID){
		this.teamID=teamID;
	}
	
	public Long getTeamID() {
		return teamID;
	}
	public void setTeamID(Long teamID) {
		this.teamID = teamID;
	}
	public String getTeamName() {
		return teamName;
	}
	public void setTeamName(String teamName) {
		this.teamName = teamName;
	}
	public BlitzballPlayer getRightWing() {
		return rightWing;
	}
	public void setRightWing(BlitzballPlayer rightWing) {
		this.rightWing = rightWing;
	}
	public BlitzballPlayer getLeftWing() {
		return leftWing;
	}
	public void setLeftWing(BlitzballPlayer leftWing) {
		this.leftWing = leftWing;
	}
	public BlitzballPlayer getMidfielder() {
		return midfielder;
	}
	public void setMidfielder(BlitzballPlayer midfielder) {
		this.midfielder = midfielder;
	}
	public BlitzballPlayer getRightBack() {
		return rightBack;
	}
	public void setRightBack(BlitzballPlayer rightBack) {
		this.rightBack = rightBack;
	}
	public BlitzballPlayer getLeftBack() {
		return leftBack;
	}
	public void setLeftBack(BlitzballPlayer leftBack) {
		this.leftBack = leftBack;
	}
	public BlitzballPlayer getKeeper() {
		return keeper;
	}
	public void setKeeper(BlitzballPlayer keeper) {
		this.keeper = keeper;
	}
	public BlitzballPlayer getBench1() {
		return bench1;
	}
	public void setBench1(BlitzballPlayer bench1) {
		this.bench1 = bench1;
	}
	public BlitzballPlayer getBench2() {
		return bench2;
	}
	public void setBench2(BlitzballPlayer bench2) {
		this.bench2 = bench2;
	}
	public Integer getWins() {
		return wins;
	}
	public void setWins(Integer wins) {
		this.wins = wins;
	}
	public Integer getLosses() {
		return losses;
	}
	public void setLosses(Integer losses) {
		this.losses = losses;
	}
	public Integer getTies() {
		return ties;
	}
	public void setTies(Integer ties) {
		this.ties = ties;
	}
	public Integer getAvailableCash() {
		return availableCash;
	}
	public void setAvailableCash(Integer availableCash) {
		this.availableCash = availableCash;
	}
}
