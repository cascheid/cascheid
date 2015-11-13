package site.blitzball;

import java.util.List;

public class BlitzballInfo implements java.io.Serializable {
	private static final long serialVersionUID = 5974332443976940930L;
	
	private Long userID;
	private BlitzballTeam team;
	private List<BlitzballTeam> opponents;
	private Integer totalWins;
	private Integer totalLosses;
	private Integer totalGoals;
	private Integer totalGoalsAgainst;
	
	public BlitzballInfo(){}

	public Long getUserID() {
		return userID;
	}

	public void setUserID(Long userID) {
		this.userID = userID;
	}

	public BlitzballTeam getTeam() {
		return team;
	}

	public void setTeam(BlitzballTeam team) {
		this.team = team;
	}

	public List<BlitzballTeam> getOpponents() {
		return opponents;
	}

	public void setOpponents(List<BlitzballTeam> opponents) {
		this.opponents = opponents;
	}

	public Integer getTotalWins() {
		return totalWins;
	}

	public void setTotalWins(Integer totalWins) {
		this.totalWins = totalWins;
	}

	public Integer getTotalLosses() {
		return totalLosses;
	}

	public void setTotalLosses(Integer totalLosses) {
		this.totalLosses = totalLosses;
	}

	public Integer getTotalGoals() {
		return totalGoals;
	}

	public void setTotalGoals(Integer totalGoals) {
		this.totalGoals = totalGoals;
	}

	public Integer getTotalGoalsAgainst() {
		return totalGoalsAgainst;
	}

	public void setTotalGoalsAgainst(Integer totalGoalsAgainst) {
		this.totalGoalsAgainst = totalGoalsAgainst;
	}	
}
