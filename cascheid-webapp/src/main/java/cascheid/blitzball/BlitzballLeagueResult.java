package cascheid.blitzball;

public class BlitzballLeagueResult implements java.io.Serializable {
	
	private static final long serialVersionUID = -3513308707571176506L;
	
	private Integer prize;
	private Long firstPlaceTeam;
	private Long secondPlaceTeam;
	private Long topScorerTeam;
	private String topScorerPlayerName;
	
	public BlitzballLeagueResult(){}

	public Integer getPrize() {
		return prize;
	}

	public void setPrize(Integer prize) {
		this.prize = prize;
	}

	public Long getFirstPlaceTeam() {
		return firstPlaceTeam;
	}

	public void setFirstPlaceTeam(Long firstPlaceTeam) {
		this.firstPlaceTeam = firstPlaceTeam;
	}

	public Long getSecondPlaceTeam() {
		return secondPlaceTeam;
	}

	public void setSecondPlaceTeam(Long secondPlaceTeam) {
		this.secondPlaceTeam = secondPlaceTeam;
	}

	public Long getTopScorerTeam() {
		return topScorerTeam;
	}

	public void setTopScorerTeam(Long topScorerTeam) {
		this.topScorerTeam = topScorerTeam;
	}

	public String getTopScorerPlayerName() {
		return topScorerPlayerName;
	}

	public void setTopScorerPlayerName(String topScorerPlayerName) {
		this.topScorerPlayerName = topScorerPlayerName;
	}

}
