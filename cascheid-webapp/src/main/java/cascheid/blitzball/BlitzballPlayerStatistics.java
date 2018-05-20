package cascheid.blitzball;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

public class BlitzballPlayerStatistics implements Serializable{

	private static final long serialVersionUID = 7686223340965135147L;

	private Integer playerID;
	private String playerName;
	private String model;
	private Integer goals;
	private Integer shots;
	private Integer assists;
	private Integer goalsAgainst;
	private Integer shotsAgainst;
	private Integer tackles;
	private Integer blocks;
	private Integer breaks;
	private Integer turnovers;
	private Integer expGained;
	private List<BlitzballTech> techsLearned;
	
	public BlitzballPlayerStatistics(){}
	public BlitzballPlayerStatistics(Integer playerID){
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
		this.expGained=0;
		this.techsLearned=new ArrayList<BlitzballTech>();
	}
	public BlitzballPlayerStatistics(Integer playerID, String name, String model){
		this(playerID);
		this.playerName=name;
		this.model=model;
	}
	public Integer getPlayerID() {
		return playerID;
	}
	public void setPlayerID(Integer playerID) {
		this.playerID = playerID;
	}
	public String getPlayerName() {
		return playerName;
	}
	public void setPlayerName(String playerName) {
		this.playerName = playerName;
	}
	public String getModel() {
		return model;
	}
	public void setModel(String model) {
		this.model = model;
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
	public Integer getExpGained() {
		return expGained;
	}
	public void setExpGained(Integer expGained) {
		this.expGained = expGained;
	}
	public List<BlitzballTech> getTechsLearned() {
		return techsLearned;
	}
	public void setTechsLearned(List<BlitzballTech> techsLearned) {
		this.techsLearned = techsLearned;
	}
}
