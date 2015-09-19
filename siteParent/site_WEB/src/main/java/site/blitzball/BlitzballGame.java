package site.blitzball;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

@Component
@Scope("session")
public class BlitzballGame implements java.io.Serializable {

	private static final long serialVersionUID = 8611214264626497385L;

	private BlitzballTeam team1;
	private BlitzballTeam team2;
	private Integer team1Score;
	private Integer team2Score;
	private Integer weekNumber;
	
	public BlitzballGame(){}
	
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
}
