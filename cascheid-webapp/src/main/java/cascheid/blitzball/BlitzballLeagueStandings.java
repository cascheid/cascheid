package cascheid.blitzball;

import java.util.Collections;
import java.util.Comparator;
import java.util.List;

public class BlitzballLeagueStandings implements java.io.Serializable {
	private static final long serialVersionUID = -3372685488314814440L;
	
	private List<BlitzballTeamResults> division1Standings;
	private List<BlitzballTeamResults> division2Standings;
	
	public BlitzballLeagueStandings(){}
	
	public List<BlitzballTeamResults> getDivision1Standings() {
		return division1Standings;
	}

	public void setDivision1Standings(List<BlitzballTeamResults> division1Standings) {
		this.division1Standings = division1Standings;
	}

	public List<BlitzballTeamResults> getDivision2Standings() {
		return division2Standings;
	}

	public void setDivision2Standings(List<BlitzballTeamResults> division2Standings) {
		this.division2Standings = division2Standings;
	}
	
	public void sortDivisions(){
		Comparator<BlitzballTeamResults> comp = new Comparator<BlitzballTeamResults>(){
			public int compare(BlitzballTeamResults team1, BlitzballTeamResults team2) {
				//reverse sorting, more points=earlier sort
				return team2.getPoints().compareTo(team1.getPoints());
			}
			
		};
		Collections.sort(division1Standings, comp);
		Collections.sort(division2Standings, comp);
	}
	
	public class BlitzballTeamResults{
		private Long teamID;
		private String teamName;
		private Integer wins;
		private Integer losses;
		private Integer ties;
		private Integer points;
		
		public BlitzballTeamResults(){
			this.wins=0;
			this.losses=0;
			this.ties=0;
			this.points=0;
		}
		public BlitzballTeamResults(BlitzballTeam team){
			this();
			this.teamID=team.getTeamID();
			this.teamName=team.getTeamName();
		}
		
		public Long getTeamID() {
			return teamID;
		}
		public void setTeamID(Long teamID) {
			this.teamID = teamID;
		}
		public String getTeamName() {
			return teamName;
		}
		public void setTeamName(String teamName) {
			this.teamName = teamName;
		}
		public Integer getWins() {
			return wins;
		}
		public void setWins(Integer wins) {
			this.wins = wins;
		}
		public Integer getLosses() {
			return losses;
		}
		public void setLosses(Integer losses) {
			this.losses = losses;
		}
		public Integer getTies() {
			return ties;
		}
		public void setTies(Integer ties) {
			this.ties = ties;
		}
		public Integer getPoints() {
			return points;
		}
		public void setPoints(Integer points) {
			this.points = points;
		}
	}
}