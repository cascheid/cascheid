package site.blitzball;

import java.util.List;

public class BlitzballInfo implements java.io.Serializable {
	private static final long serialVersionUID = 5974332443976940930L;
	
	private Long userID;
	private BlitzballTeam team;
	private List<BlitzballTeam> opponents;
	private BlitzballLeague league;
	private Integer availableCash;
	private Integer leagueWins;
	private Integer tournamentWins;
	private Integer teamLevel;
	private Integer teamExp;
	
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

	public BlitzballLeague getLeague() {
		return league;
	}

	public void setLeague(BlitzballLeague league) {
		this.league = league;
	}

	public Integer getAvailableCash() {
		return availableCash;
	}

	public void setAvailableCash(Integer availableCash) {
		this.availableCash = availableCash;
	}

	public Integer getLeagueWins() {
		return leagueWins;
	}

	public void setLeagueWins(Integer leagueWins) {
		this.leagueWins = leagueWins;
	}

	public Integer getTournamentWins() {
		return tournamentWins;
	}

	public void setTournamentWins(Integer tournamentWins) {
		this.tournamentWins = tournamentWins;
	}

	public Integer getTeamLevel() {
		return teamLevel;
	}

	public void setTeamLevel(Integer teamLevel) {
		this.teamLevel = teamLevel;
	}
	
	public Integer getTeamExp() {
		return teamExp;
	}

	public void setTeamExp(Integer teamExp) {
		this.teamExp = teamExp;
	}

	public Integer getNumberOfPlayers(){
		int numPlayers = 0;
		for (BlitzballPlayer player : this.team.getAllPlayers()){
			numPlayers++;
		}
		return numPlayers;
	}
}
