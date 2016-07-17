package site.blitzball;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import site.blitzball.BlitzballLeagueStandings.BlitzballTeamResults;

public class BlitzballLeague implements java.io.Serializable {

	private static final long serialVersionUID = 5319892078982833787L;

	private Long leagueID;
	private Long gameID;
	private Integer weeksComplete;
	private Integer prize;
	private BlitzballTeam myTeam;
	private List<BlitzballTeam> divisionOpponents;
	private List<BlitzballTeam> nonDivisionOpponents;
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
	public Integer getPrize() {
		return prize;
	}
	public void setPrize(Integer prize) {
		this.prize = prize;
	}
	public BlitzballTeam getMyTeam() {
		return myTeam;
	}
	public void setMyTeam(BlitzballTeam myTeam) {
		this.myTeam = myTeam;
	}
	public List<BlitzballTeam> getDivisionOpponents() {
		return divisionOpponents;
	}
	public void setDivisionOpponents(List<BlitzballTeam> divisionOpponents) {
		this.divisionOpponents = divisionOpponents;
	}
	public List<BlitzballTeam> getNonDivisionOpponents() {
		return nonDivisionOpponents;
	}
	public void setNonDivisionOpponents(List<BlitzballTeam> nonDivisionOpponents) {
		this.nonDivisionOpponents = nonDivisionOpponents;
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
	
	public BlitzballLeagueStandings getLeagueStandings(){
		BlitzballLeagueStandings standings = new BlitzballLeagueStandings();
		
		List<BlitzballTeamResults> div1Results = new ArrayList<BlitzballTeamResults>();
		div1Results.add(standings.new BlitzballTeamResults(myTeam));
		div1Results.add(standings.new BlitzballTeamResults(divisionOpponents.get(0)));
		div1Results.add(standings.new BlitzballTeamResults(divisionOpponents.get(1)));
		div1Results.add(standings.new BlitzballTeamResults(divisionOpponents.get(2)));
		List<BlitzballTeamResults> div2Results = new ArrayList<BlitzballTeamResults>();
		div2Results.add(standings.new BlitzballTeamResults(nonDivisionOpponents.get(0)));
		div2Results.add(standings.new BlitzballTeamResults(nonDivisionOpponents.get(1)));
		div2Results.add(standings.new BlitzballTeamResults(nonDivisionOpponents.get(2)));
		div2Results.add(standings.new BlitzballTeamResults(nonDivisionOpponents.get(3)));
		
		for (int i=0; i<weeksComplete; i++){
			List<BlitzballGame> weeksGames = schedule.get(i+1);
			for (BlitzballGame game : weeksGames){
				for (BlitzballTeamResults team : div1Results){
					if (game.getTeam1().getTeamID()==team.getTeamID()){
						if (game.getTeam1Score()>game.getTeam2Score()){//win
							team.setWins(team.getWins()+1);
							team.setPoints(team.getPoints()+3);
						} else if (game.getTeam1Score()==game.getTeam2Score()){//tie
							team.setTies(team.getTies()+1);
							team.setPoints(team.getPoints()+1);
						} else {
							team.setLosses(team.getLosses()+1);
						}
					}
					if (game.getTeam2().getTeamID()==team.getTeamID()){
						if (game.getTeam2Score()>game.getTeam1Score()){//win
							team.setWins(team.getWins()+1);
							team.setPoints(team.getPoints()+3);
						} else if (game.getTeam1Score()==game.getTeam2Score()){//tie
							team.setTies(team.getTies()+1);
							team.setPoints(team.getPoints()+1);
						} else {
							team.setLosses(team.getLosses()+1);
						}
					}
				}
				for (BlitzballTeamResults team : div2Results){
					if (game.getTeam1().getTeamID()==team.getTeamID()){
						if (game.getTeam1Score()>game.getTeam2Score()){//win
							team.setWins(team.getWins()+1);
							team.setPoints(team.getPoints()+3);
						} else if (game.getTeam1Score()==game.getTeam2Score()){//tie
							team.setTies(team.getTies()+1);
							team.setPoints(team.getPoints()+1);
						} else {
							team.setLosses(team.getLosses()+1);
						}
					}
					if (game.getTeam2().getTeamID()==team.getTeamID()){
						if (game.getTeam2Score()>game.getTeam1Score()){//win
							team.setWins(team.getWins()+1);
							team.setPoints(team.getPoints()+3);
						} else if (game.getTeam1Score()==game.getTeam2Score()){//tie
							team.setTies(team.getTies()+1);
							team.setPoints(team.getPoints()+1);
						} else {
							team.setLosses(team.getLosses()+1);
						}
					}
				}
			}
		}
		standings.setDivision1Standings(div1Results);
		standings.setDivision2Standings(div2Results);
		
		standings.sortDivisions();
		
		return standings;
	}
}
