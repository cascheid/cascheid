package site.blitzball;

import java.util.List;

public class BlitzballWeekResults implements java.io.Serializable {

	private static final long serialVersionUID = 5319892078982833787L;
	
	private Integer weekNo;
	private List<BlitzballGame> gameResults;
	private List<BlitzballPlayer> expiredPlayers;
	private List<BlitzballPlayer> renewedPlayers;
	
	public BlitzballWeekResults(){}

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
}
