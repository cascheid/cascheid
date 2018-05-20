package cascheid.blitzball;

import java.util.ArrayList;
import java.util.List;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

@Component
@Scope("session")
public class BlitzballGame implements java.io.Serializable {

	private static final long serialVersionUID = 8611214264626497385L;

	private Long leagueGameID;
	private Long tourneyGameID;
	private BlitzballTeam team1;
	private BlitzballTeam team2;
	private Integer team1Score;
	private Integer team2Score;
	private Integer weekNumber;
	private Integer halvesComplete;
	private List<BlitzballPlayerStatistics> playerStatistics;
	private Boolean isOvertimeGame;
	
	public BlitzballGame(){
		this.isOvertimeGame=false;
	}
	public BlitzballGame(BlitzballTeam team1, BlitzballTeam team2){
		this.team1=team1;
		this.team2=team2;
		this.team1Score=0;
		this.team2Score=0;
		this.playerStatistics = new ArrayList<BlitzballPlayerStatistics>();
		playerStatistics.add(new BlitzballPlayerStatistics(team1.getLeftWing().getPlayerID()));
		playerStatistics.add(new BlitzballPlayerStatistics(team1.getRightWing().getPlayerID()));
		playerStatistics.add(new BlitzballPlayerStatistics(team1.getMidfielder().getPlayerID()));
		playerStatistics.add(new BlitzballPlayerStatistics(team1.getLeftBack().getPlayerID()));
		playerStatistics.add(new BlitzballPlayerStatistics(team1.getRightBack().getPlayerID()));
		playerStatistics.add(new BlitzballPlayerStatistics(team1.getKeeper().getPlayerID()));
		playerStatistics.add(new BlitzballPlayerStatistics(team2.getLeftWing().getPlayerID()));
		playerStatistics.add(new BlitzballPlayerStatistics(team2.getRightWing().getPlayerID()));
		playerStatistics.add(new BlitzballPlayerStatistics(team2.getMidfielder().getPlayerID()));
		playerStatistics.add(new BlitzballPlayerStatistics(team2.getLeftBack().getPlayerID()));
		playerStatistics.add(new BlitzballPlayerStatistics(team2.getRightBack().getPlayerID()));
		playerStatistics.add(new BlitzballPlayerStatistics(team2.getKeeper().getPlayerID()));
		this.halvesComplete=0;
		this.isOvertimeGame=false;
	}
	
	public Long getLeagueGameID() {
		return leagueGameID;
	}
	public void setLeagueGameID(Long leagueGameID) {
		this.leagueGameID = leagueGameID;
	}
	public Long getTourneyGameID() {
		return tourneyGameID;
	}
	public void setTourneyGameID(Long tourneyGameID) {
		this.tourneyGameID = tourneyGameID;
	}
	public BlitzballTeam getTeam1() {
		return team1;
	}
	public void setTeam1(BlitzballTeam team1) {
		this.team1 = team1;
	}
	public BlitzballTeam getTeam2() {
		return team2;
	}
	public void setTeam2(BlitzballTeam team2) {
		this.team2 = team2;
	}
	public Integer getTeam1Score() {
		return team1Score;
	}
	public void setTeam1Score(Integer team1Score) {
		this.team1Score = team1Score;
	}
	public Integer getTeam2Score() {
		return team2Score;
	}
	public void setTeam2Score(Integer team2Score) {
		this.team2Score = team2Score;
	}

	public Integer getWeekNumber() {
		return weekNumber;
	}

	public void setWeekNumber(Integer weekNumber) {
		this.weekNumber = weekNumber;
	}

	public Integer getHalvesComplete() {
		return halvesComplete;
	}
	public void setHalvesComplete(Integer halvesComplete) {
		this.halvesComplete = halvesComplete;
	}
	public List<BlitzballPlayerStatistics> getPlayerStatistics() {
		return playerStatistics;
	}

	public void setPlayerStatistics(List<BlitzballPlayerStatistics> playerStatistics) {
		this.playerStatistics = playerStatistics;
	}
	public Boolean getIsOvertimeGame() {
		return isOvertimeGame;
	}
	public void setIsOvertimeGame(Boolean isOvertimeGame) {
		this.isOvertimeGame = isOvertimeGame;
	}
}
