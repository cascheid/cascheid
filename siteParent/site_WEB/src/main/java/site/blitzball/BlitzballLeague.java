package site.blitzball;

import java.util.HashMap;
import java.util.List;

public class BlitzballLeague implements java.io.Serializable {

	private static final long serialVersionUID = 5319892078982833787L;

	private Long leagueID;
	private Long gameID;
	private Integer weeksComplete;
	private List<BlitzballTeam> divisionOpponents;
	private HashMap<Integer, List<BlitzballGame>> schedule;
	private List<BlitzballPlayerStatistics> playerStatistics;
	
	public BlitzballLeague(){}
	public Long getLeagueID() {
		return leagueID;
	}
	public void setLeagueID(Long leagueID) {
		this.leagueID = leagueID;
	}
	public Long getGameID() {
		return gameID;
	}
	public void setGameID(Long teamID) {
		this.gameID = teamID;
	}
	public Integer getWeeksComplete() {
		return weeksComplete;
	}
	public void setWeeksComplete(Integer weeksComplete) {
		this.weeksComplete = weeksComplete;
	}
	public List<BlitzballTeam> getDivisionOpponents() {
		return divisionOpponents;
	}
	public void setDivisionOpponents(List<BlitzballTeam> divisionOpponents) {
		this.divisionOpponents = divisionOpponents;
	}
	public HashMap<Integer, List<BlitzballGame>> getSchedule() {
		return schedule;
	}
	public void setSchedule(HashMap<Integer, List<BlitzballGame>> schedule) {
		this.schedule = schedule;
	}
	public List<BlitzballPlayerStatistics> getPlayerStatistics() {
		return playerStatistics;
	}
	public void setPlayerStatistics(List<BlitzballPlayerStatistics> playerStatistics) {
		this.playerStatistics = playerStatistics;
	} 
}
