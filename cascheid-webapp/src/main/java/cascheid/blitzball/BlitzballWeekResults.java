package cascheid.blitzball;

import java.util.List;

public class BlitzballWeekResults implements java.io.Serializable {

	private static final long serialVersionUID = 5319892078982833787L;
	
	private String type;
	private Integer weekNo;
	private List<BlitzballGame> gameResults;
	private List<BlitzballPlayer> expiredPlayers;
	private List<BlitzballPlayer> renewedPlayers;
	private List<BlitzballPlayer> myExpiredPlayers;
	private boolean teamLevelUp=false;
	private BlitzballLeagueResult leagueResult;
	
	public BlitzballWeekResults(){}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public Integer getWeekNo() {
		return weekNo;
	}

	public void setWeekNo(Integer weekNo) {
		this.weekNo = weekNo;
	}

	public List<BlitzballGame> getGameResults() {
		return gameResults;
	}

	public void setGameResults(List<BlitzballGame> gameResults) {
		this.gameResults = gameResults;
	}

	public List<BlitzballPlayer> getExpiredPlayers() {
		return expiredPlayers;
	}

	public void setExpiredPlayers(List<BlitzballPlayer> expiredPlayers) {
		this.expiredPlayers = expiredPlayers;
	}

	public List<BlitzballPlayer> getRenewedPlayers() {
		return renewedPlayers;
	}

	public void setRenewedPlayers(List<BlitzballPlayer> renewedPlayers) {
		this.renewedPlayers = renewedPlayers;
	}

	public List<BlitzballPlayer> getMyExpiredPlayers() {
		return myExpiredPlayers;
	}

	public void setMyExpiredPlayers(List<BlitzballPlayer> myExpiredPlayers) {
		this.myExpiredPlayers = myExpiredPlayers;
	}

	public boolean isTeamLevelUp() {
		return teamLevelUp;
	}

	public void setTeamLevelUp(boolean teamLevelUp) {
		this.teamLevelUp = teamLevelUp;
	}

	public BlitzballLeagueResult getLeagueResult() {
		return leagueResult;
	}

	public void setLeagueResult(BlitzballLeagueResult leagueResult) {
		this.leagueResult = leagueResult;
	}
}
