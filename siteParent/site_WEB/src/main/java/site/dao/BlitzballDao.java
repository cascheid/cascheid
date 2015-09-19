package site.dao;

import java.util.HashMap;
import java.util.List;

import site.blitzball.BlitzballGame;
import site.blitzball.BlitzballInfo;
import site.blitzball.BlitzballLeague;
import site.blitzball.BlitzballPlayerStatistics;
import site.blitzball.BlitzballTeam;

public interface BlitzballDao {
	public BlitzballInfo getBlitzballByIdentifier(Long identifier);
	public Long insertNewBlitzballGame(Long identifier, String teamName);
	public BlitzballLeague getActiveLeagueByTeamID(Long teamID);
	public Long insertNewLeague(Long teamID, List<Long> divisionOpponents, HashMap<Integer, List<BlitzballGame>> schedule);
	public List<BlitzballTeam> getDivisionsOpponents(Long leagueID);
	public BlitzballTeam getLeagueOpponent(BlitzballLeague league);
	public HashMap<Integer, List<BlitzballGame>> getLeagueSchedule(Long leagueID);
	public List<BlitzballPlayerStatistics> getLeaguePlayerStatistics(Long leagueID);
}
