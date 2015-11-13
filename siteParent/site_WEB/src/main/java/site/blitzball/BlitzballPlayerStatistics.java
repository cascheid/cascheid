package site.blitzball;

import java.io.Serializable;

public class BlitzballPlayerStatistics implements Serializable{

	private static final long serialVersionUID = 7686223340965135147L;

	private Long playerID;
	private String playerName;
	private Integer goals;
	private Integer shots;
	private Integer assists;
	private Integer goalsAgainst;
	private Integer shotsAgainst;
	private Integer tackles;
	private Integer blocks;
	private Integer breaks;
	private Integer turnovers;
	
	public BlitzballPlayerStatistics(){}
	public BlitzballPlayerStatistics(Long playerID){
		this.playerID=playerID;
		this.goals=0;
		this.shots=0;
		this.assists=0;
		this.goalsAgainst=0;
		this.shotsAgainst=0;
		this.tackles=0;
		this.blocks=0;
		this.breaks=0;
		this.turnovers=0;
	}
	public BlitzballPlayerStatistics(Long playerID, String playerName){
		this(playerID);
		this.setPlayerName(playerName);
	}
	public Long getPlayerID() {
		return playerID;
	}
	public void setPlayerID(Long playerID) {
		this.playerID = playerID;
	}
	public String getPlayerName() {
		return playerName;
	}
	public void setPlayerName(String playerName) {
		this.playerName = playerName;
	}
	public Integer getGoals() {
		return goals;
	}
	public void setGoals(Integer goals) {
		this.goals = goals;
	}
	public Integer getShots() {
		return shots;
	}
	public void setShots(Integer shots) {
		this.shots = shots;
	}
	public Integer getAssists() {
		return assists;
	}
	public void setAssists(Integer assists) {
		this.assists = assists;
	}
	public Integer getGoalsAgainst() {
		return goalsAgainst;
	}
	public void setGoalsAgainst(Integer goalsAgainst) {
		this.goalsAgainst = goalsAgainst;
	}
	public Integer getShotsAgainst() {
		return shotsAgainst;
	}
	public void setShotsAgainst(Integer shotsAgainst) {
		this.shotsAgainst = shotsAgainst;
	}
	public Integer getTackles() {
		return tackles;
	}
	public void setTackles(Integer tackles) {
		this.tackles = tackles;
	}
	public Integer getBlocks() {
		return blocks;
	}
	public void setBlocks(Integer blocks) {
		this.blocks = blocks;
	}
	public Integer getBreaks() {
		return breaks;
	}
	public void setBreaks(Integer breaks) {
		this.breaks = breaks;
	}
	public Integer getTurnovers() {
		return turnovers;
	}
	public void setTurnovers(Integer turnovers) {
		this.turnovers = turnovers;
	}
}
