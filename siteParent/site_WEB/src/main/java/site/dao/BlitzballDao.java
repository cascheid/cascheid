package site.dao;

import java.util.HashMap;
import java.util.List;

import site.blitzball.BlitzballGame;
import site.blitzball.BlitzballInfo;
import site.blitzball.BlitzballLeague;
import site.blitzball.BlitzballLeagueResult;
import site.blitzball.BlitzballPlayer;
import site.blitzball.BlitzballPlayerStatistics;
import site.blitzball.BlitzballTech;

public interface BlitzballDao {
	public BlitzballPlayer getPlayerByID(Integer playerID, Long gameID, Integer optionalLevel);
	public BlitzballInfo getBlitzballByIdentifier(Long identifier);
	public void updateBlitzballInfo(BlitzballInfo info);
	public void resetBlitzballGameInfo(Long gameID);
	public Long insertNewBlitzballGame(Long identifier, String teamName);
	public BlitzballLeague getActiveLeagueByTeamID(BlitzballInfo info);
	public Long insertNewLeague(Long teamID, List<Long> divisionOpponents, HashMap<Integer, List<BlitzballGame>> schedule);
	public HashMap<Integer, List<BlitzballGame>> getLeagueSchedule(BlitzballLeague league);
	public List<BlitzballPlayerStatistics> getLeaguePlayerStatistics(Long leagueID, Long gameID);
	public List<BlitzballTech> getFullBlitzballTechList();
	public HashMap<Integer, Integer> getExpLevelMilestones();
	public HashMap<Integer, Integer> getTeamLevelMilestones();
	public void saveLeagueGameInfo(BlitzballGame game, Long gameID);
	public void advanceLeagueWeek(BlitzballLeague league);
	public List<BlitzballPlayer> advancePlayerContracts(BlitzballInfo info, String teamIDString);
	public BlitzballPlayer selectReplacementPlayer(BlitzballPlayer player, Long gameID);
	public void signPlayer(Integer playerID, Long gameID, Long signingTeamID, Integer extension, String position);
	public String getCurrentPositionByPlayerID(Long gameID, Integer playerID);
	public List<BlitzballPlayer> getAllGamePlayers(Long gameID);
}
