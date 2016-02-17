package site.dao;

import java.util.HashMap;
import java.util.List;

import site.blitzball.BlitzballGame;
import site.blitzball.BlitzballInfo;
import site.blitzball.BlitzballLeague;
import site.blitzball.BlitzballPlayer;
import site.blitzball.BlitzballPlayerStatistics;
import site.blitzball.BlitzballTeam;
import site.blitzball.BlitzballTech;

public interface BlitzballDao {
	public BlitzballInfo getBlitzballByIdentifier(Long identifier);
	public void deleteBlitzballGameInfo(Long gameID);
	public Long insertNewBlitzballGame(Long identifier, String teamName);
	public BlitzballLeague getActiveLeagueByTeamID(BlitzballInfo info);
	public Long insertNewLeague(Long teamID, List<Long> divisionOpponents, HashMap<Integer, List<BlitzballGame>> schedule);
	public HashMap<Integer, List<BlitzballGame>> getLeagueSchedule(Long leagueID);
	public List<BlitzballPlayerStatistics> getLeaguePlayerStatistics(Long leagueID);
	public List<BlitzballTech> getFullBlitzballTechList();
	public void saveLeagueGameInfo(BlitzballGame game);
	public void advanceLeagueWeek(BlitzballLeague league);
	public List<BlitzballPlayer> advancePlayerContracts(BlitzballInfo info, String teamIDString);
}
