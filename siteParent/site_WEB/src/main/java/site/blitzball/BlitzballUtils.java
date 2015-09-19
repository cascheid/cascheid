package site.blitzball;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;

import site.dao.BlitzballDao;
import site.dao.BlitzballDaoImpl;

public class BlitzballUtils {

	public static BlitzballInfo getBlitsballInfo(Long identifier){
		BlitzballDao dao = new BlitzballDaoImpl();
		BlitzballInfo info=null;
		try {
			info = dao.getBlitzballByIdentifier(identifier);
		} catch (Exception e){
			e.printStackTrace();
		}
		return info;
	}
	
	public static BlitzballInfo getNewBlitzballGameInfo(Long identifier, String teamName){
		BlitzballDao dao = new BlitzballDaoImpl();
		dao.insertNewBlitzballGame(identifier, teamName);
		BlitzballInfo info = dao.getBlitzballByIdentifier(identifier);
		return info;
	}
	
	public static BlitzballLeague getActiveLeague(BlitzballInfo info){
		BlitzballDao dao = new BlitzballDaoImpl();
		BlitzballLeague league=null;
		try {
			league=dao.getActiveLeagueByTeamID(info.getTeam().getTeamID());
			league.setDivisionOpponents(dao.getDivisionsOpponents(league.getLeagueID()));
			league.setSchedule(dao.getLeagueSchedule(league.getLeagueID()));
			league.setPlayerStatistics(dao.getLeaguePlayerStatistics(league.getLeagueID()));
		} catch (Exception e){//TODO get specific catch
			league=generateRandomLeague(info);
		}
		return league;
	}
	
	public static BlitzballTeam getLeagueOpponentByID(BlitzballLeague leagueInfo){
		BlitzballDao dao = new BlitzballDaoImpl();
		return dao.getLeagueOpponent(leagueInfo);
	}
	
	public static BlitzballLeague generateRandomLeague(BlitzballInfo info){
		BlitzballLeague league=new BlitzballLeague();
		BlitzballDao dao = new BlitzballDaoImpl();
		List<Long> teamIDs = new ArrayList<Long>(info.getOpponentIDs());
		Collections.shuffle(teamIDs);
		List<Long> divisionOppIDs = Arrays.asList(teamIDs.get(0), teamIDs.get(1), teamIDs.get(2));
		List<Long> nonDivOppIDs = Arrays.asList(teamIDs.get(3), teamIDs.get(4), teamIDs.get(5), teamIDs.get(6));
		//league.setDivisionOpponents(divisionOppIDs);
		
		HashMap<Integer, List<BlitzballGame>> schedule = new HashMap<Integer, List<BlitzballGame>>();
		
		for (int i=1; i<=10; i++){
			List<BlitzballGame> weekGames = new ArrayList<BlitzballGame>();
			if (Arrays.asList(1, 2, 5, 6, 9, 10).contains(i)){//inter division game
				//user's division
				List<Long> tempList = new ArrayList<Long>(divisionOppIDs);
				int oppOffset=0;
				if (i==2||i==9){
					oppOffset=1;
				} else if (i==5||i==10){
					oppOffset=2;
				}
				BlitzballGame newGame = new BlitzballGame();
				BlitzballTeam team1 = new BlitzballTeam(info.getTeam().getTeamID());
				BlitzballTeam team2 = new BlitzballTeam(tempList.get(0+oppOffset));
				tempList.remove(0+oppOffset);
				newGame.setTeam1(team1);
				newGame.setTeam2(team2);
				newGame.setWeekNumber(1);
				weekGames.add(newGame);

				newGame = new BlitzballGame();
				Iterator<Long> it = tempList.iterator();
				//while (it.hasNext()){
				team1 = new BlitzballTeam(it.next());
				team2 = new BlitzballTeam(it.next());
				//}
				newGame.setTeam1(team1);
				newGame.setTeam2(team2);
				newGame.setWeekNumber(i);
				weekGames.add(newGame);

				
				//other division
				tempList = new ArrayList<Long>(nonDivOppIDs);
				newGame = new BlitzballGame();
				team1 = new BlitzballTeam(tempList.get(3));
				team2 = new BlitzballTeam(tempList.get(0+oppOffset));
				tempList.remove(0+oppOffset);
				newGame.setTeam1(team1);
				newGame.setTeam2(team2);
				newGame.setWeekNumber(1);
				weekGames.add(newGame);

				newGame = new BlitzballGame();
				Iterator<Long> it2 = tempList.iterator();
				//while (it.hasNext()){
				team1 = new BlitzballTeam(it2.next());
				team2 = new BlitzballTeam(it2.next());
				//}
				newGame.setTeam1(team1);
				newGame.setTeam2(team2);
				newGame.setWeekNumber(i);
				weekGames.add(newGame);
			} else {
				int oppOffset=0;
				if (i==4){
					oppOffset=1;
				} else if (i==7){
					oppOffset=2;
				} else if (i==8){
					oppOffset=3;
				}
				BlitzballGame newGame = new BlitzballGame();
				BlitzballTeam team1 = new BlitzballTeam(info.getTeam().getTeamID());
				BlitzballTeam team2 = new BlitzballTeam(nonDivOppIDs.get(0+oppOffset));
				newGame.setTeam1(team1);
				newGame.setTeam2(team2);
				newGame.setWeekNumber(i);
				weekGames.add(newGame);
				
				for (int j=0; j<3; j++){
					newGame = new BlitzballGame();
					team1 = new BlitzballTeam(divisionOppIDs.get(0+j));
					team2 = new BlitzballTeam(nonDivOppIDs.get((1+j+oppOffset)%4));
					newGame.setTeam1(team1);
					newGame.setTeam2(team2);
					newGame.setWeekNumber(i);
					weekGames.add(newGame);
				}
			}
			schedule.put(i, weekGames);
		}
		league.setSchedule(schedule);
		league.setWeeksComplete(0);
		Long leagueID=dao.insertNewLeague(info.getTeam().getTeamID(), divisionOppIDs, schedule);
		league.setLeagueID(leagueID);
		league.setDivisionOpponents(dao.getDivisionsOpponents(leagueID));
		return league;
	}
}
