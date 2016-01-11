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
	private static List<BlitzballTech> techList;

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
			league=dao.getActiveLeagueByTeamID(info);
			//league.setDivisionOpponents(dao.getDivisionsOpponents(league.getLeagueID()));
			//league.setNonDivisionOpponents(dao.getNonDivisionsOpponents(info, league.getLeagueID()));
			league.setSchedule(dao.getLeagueSchedule(league.getLeagueID()));
			league.setPlayerStatistics(dao.getLeaguePlayerStatistics(league.getLeagueID()));
		} catch (Exception e){//TODO get specific catch
			e.printStackTrace();
			Long newLeagueID=generateRandomLeague(info);
			league=dao.getActiveLeagueByTeamID(info);
			league.setSchedule(dao.getLeagueSchedule(league.getLeagueID()));
			league.setPlayerStatistics(dao.getLeaguePlayerStatistics(league.getLeagueID()));
			//league=generateRandomLeague(info);
		}
		return league;
	}
	
	public static BlitzballTeam getLeagueOpponentByID(BlitzballLeague leagueInfo){
		BlitzballTeam leagueOpponent=null;
		List<BlitzballGame> weeksGames=leagueInfo.getSchedule().get(leagueInfo.getWeeksComplete()+1);
		outer:
		for (BlitzballGame game : weeksGames){
			if (game.getTeam1().getTeamID()==leagueInfo.getGameID()){
				for (BlitzballTeam team : leagueInfo.getDivisionOpponents()){
					if (team.getTeamID()==game.getTeam2().getTeamID()){
						leagueOpponent=team;
						break outer;
					}
				}
				for (BlitzballTeam team : leagueInfo.getNonDivisionOpponents()){
					if (team.getTeamID()==game.getTeam2().getTeamID()){
						leagueOpponent=team;
						break outer;
					}
				}
				break;//TODO print exception here?
			}
		}
		return leagueOpponent;
	}
	
	public static Long generateRandomLeague(BlitzballInfo info){
		//BlitzballLeague league=new BlitzballLeague();
		BlitzballDao dao = new BlitzballDaoImpl();
		List<Long> teamIDs = new ArrayList<Long>();
		for (BlitzballTeam opp : info.getOpponents()){
			teamIDs.add(opp.getTeamID());
		}
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
		//league.setSchedule(schedule);
		//league.setWeeksComplete(0);
		Long leagueID=dao.insertNewLeague(info.getTeam().getTeamID(), divisionOppIDs, schedule);
		//league.setLeagueID(leagueID);
		//league.setGameID(info.getTeam().getTeamID());
		//league.setDivisionOpponents(dao.getDivisionsOpponents(leagueID));
		return leagueID;
	}
	
	public static BlitzballTeam getUpdatedRoster(BlitzballTeam origTeam, BlitzballGameRoster selectedRoster){
		BlitzballTeam adjustedTeam = new BlitzballTeam();
		adjustedTeam.setTeamID(origTeam.getTeamID());
		adjustedTeam.setTeamName(origTeam.getTeamName());
		adjustedTeam.setAvailableCash(origTeam.getAvailableCash());
		adjustedTeam.setWins(origTeam.getWins());
		adjustedTeam.setLosses(origTeam.getLosses());
		
		List<BlitzballPlayer> teamPlayers = new ArrayList<BlitzballPlayer>();
		teamPlayers.add(origTeam.getLeftWing());
		teamPlayers.add(origTeam.getRightWing());
		teamPlayers.add(origTeam.getMidfielder());
		teamPlayers.add(origTeam.getLeftBack());
		teamPlayers.add(origTeam.getRightBack());
		teamPlayers.add(origTeam.getKeeper());
		if (origTeam.getBench1()!=null){
			teamPlayers.add(origTeam.getBench1());
			if (origTeam.getBench2()!=null){
				teamPlayers.add(origTeam.getBench2());
			}
		}

		Iterator<BlitzballPlayer> it = teamPlayers.iterator();
		Integer playerID=selectedRoster.getLeftWing();
		while (it.hasNext()){
			BlitzballPlayer currPlayer = it.next();
			if (currPlayer.getPlayerID().equals(playerID)){
				adjustedTeam.setLeftWing(currPlayer);
				it.remove();
				break;
			}
		}
		
		it = teamPlayers.iterator();
		playerID=selectedRoster.getRightWing();
		while (it.hasNext()){
			BlitzballPlayer currPlayer = it.next();
			if (currPlayer.getPlayerID().equals(playerID)){
				adjustedTeam.setRightWing(currPlayer);
				it.remove();
				break;
			}
		}
		
		it = teamPlayers.iterator();
		playerID=selectedRoster.getMidfielder();
		while (it.hasNext()){
			BlitzballPlayer currPlayer = it.next();
			if (currPlayer.getPlayerID().equals(playerID)){
				adjustedTeam.setMidfielder(currPlayer);
				it.remove();
				break;
			}
		}
		
		it = teamPlayers.iterator();
		playerID=selectedRoster.getLeftBack();
		while (it.hasNext()){
			BlitzballPlayer currPlayer = it.next();
			if (currPlayer.getPlayerID().equals(playerID)){
				adjustedTeam.setLeftBack(currPlayer);
				it.remove();
				break;
			}
		}
		
		it = teamPlayers.iterator();
		playerID=selectedRoster.getRightBack();
		while (it.hasNext()){
			BlitzballPlayer currPlayer = it.next();
			if (currPlayer.getPlayerID().equals(playerID)){
				adjustedTeam.setRightBack(currPlayer);
				it.remove();
				break;
			}
		}
		
		it = teamPlayers.iterator();
		playerID=selectedRoster.getKeeper();
		while (it.hasNext()){
			BlitzballPlayer currPlayer = it.next();
			if (currPlayer.getPlayerID().equals(playerID)){
				adjustedTeam.setKeeper(currPlayer);
				it.remove();
				break;
			}
		}

		it = teamPlayers.iterator();
		if (it.hasNext()){
			adjustedTeam.setBench1(it.next());
			if (it.hasNext()){
				adjustedTeam.setBench2(it.next());
			}
		}
		if (adjustedTeam.getLeftWing()==null||adjustedTeam.getRightWing()==null||adjustedTeam.getMidfielder()==null
				||adjustedTeam.getLeftBack()==null||adjustedTeam.getRightBack()==null||adjustedTeam.getKeeper()==null){
			throw new IllegalStateException("Adjusted Team does not have proper number of players");
		}
		
		return adjustedTeam;
	}
	
	public static BlitzballTech getTechFromTechID(Integer techID){
		if (techList==null){
			getTechList();
		}
		for (BlitzballTech tech : techList){
			if (tech.getTechID()==techID){
				return tech;
			}
		}
		return null;
	}
	
	public static BlitzballTeam getUpdatedTeamTechs(BlitzballTeam team, BlitzballGameTechs techs){
		team.getLeftWing().setTech1(getTechFromTechID(techs.getLeftWingTech1()));
		team.getLeftWing().setTech2(getTechFromTechID(techs.getLeftWingTech2()));
		team.getLeftWing().setTech3(getTechFromTechID(techs.getLeftWingTech3()));
		team.getLeftWing().setTech4(getTechFromTechID(techs.getLeftWingTech4()));
		team.getLeftWing().setTech5(getTechFromTechID(techs.getLeftWingTech5()));
		team.getRightWing().setTech1(getTechFromTechID(techs.getRightWingTech1()));
		team.getRightWing().setTech2(getTechFromTechID(techs.getRightWingTech2()));
		team.getRightWing().setTech3(getTechFromTechID(techs.getRightWingTech3()));
		team.getRightWing().setTech4(getTechFromTechID(techs.getRightWingTech4()));
		team.getRightWing().setTech5(getTechFromTechID(techs.getRightWingTech5()));
		team.getMidfielder().setTech1(getTechFromTechID(techs.getMidfielderTech1()));
		team.getMidfielder().setTech2(getTechFromTechID(techs.getMidfielderTech2()));
		team.getMidfielder().setTech3(getTechFromTechID(techs.getMidfielderTech3()));
		team.getMidfielder().setTech4(getTechFromTechID(techs.getMidfielderTech4()));
		team.getMidfielder().setTech5(getTechFromTechID(techs.getMidfielderTech5()));
		team.getLeftBack().setTech1(getTechFromTechID(techs.getLeftBackTech1()));
		team.getLeftBack().setTech2(getTechFromTechID(techs.getLeftBackTech2()));
		team.getLeftBack().setTech3(getTechFromTechID(techs.getLeftBackTech3()));
		team.getLeftBack().setTech4(getTechFromTechID(techs.getLeftBackTech4()));
		team.getLeftBack().setTech5(getTechFromTechID(techs.getLeftBackTech5()));
		team.getRightBack().setTech1(getTechFromTechID(techs.getRightBackTech1()));
		team.getRightBack().setTech2(getTechFromTechID(techs.getRightBackTech2()));
		team.getRightBack().setTech3(getTechFromTechID(techs.getRightBackTech3()));
		team.getRightBack().setTech4(getTechFromTechID(techs.getRightBackTech4()));
		team.getRightBack().setTech5(getTechFromTechID(techs.getRightBackTech5()));
		team.getKeeper().setTech1(getTechFromTechID(techs.getKeeperTech1()));
		team.getKeeper().setTech2(getTechFromTechID(techs.getKeeperTech2()));
		team.getKeeper().setTech3(getTechFromTechID(techs.getKeeperTech3()));
		team.getKeeper().setTech4(getTechFromTechID(techs.getKeeperTech4()));
		team.getKeeper().setTech5(getTechFromTechID(techs.getKeeperTech5()));
		return team;
	}
	
	public static List<BlitzballTech> getTechList(){
		if (techList==null){
			BlitzballDao dao = new BlitzballDaoImpl();
			techList = dao.getFullBlitzballTechList();
		}
		return techList;
	}
	
	public static BlitzballPlayer getBlitzballPlayer(BlitzballInfo info, Integer playerID){
		BlitzballPlayer selectedPlayer = null;
		if (info.getTeam().getLeftWing().getPlayerID()==playerID){
			return info.getTeam().getLeftWing();
		} else if (info.getTeam().getRightWing().getPlayerID()==playerID){
			return info.getTeam().getRightWing();
		} else if (info.getTeam().getMidfielder().getPlayerID()==playerID){
			return info.getTeam().getMidfielder();
		} else if (info.getTeam().getLeftBack().getPlayerID()==playerID){
			return info.getTeam().getLeftBack();
		} else if (info.getTeam().getRightBack().getPlayerID()==playerID){
			return info.getTeam().getRightBack();
		} else if (info.getTeam().getKeeper().getPlayerID()==playerID){
			return info.getTeam().getKeeper();
		} else if (info.getTeam().getBench1()!=null&&info.getTeam().getBench1().getPlayerID()==playerID){
			return info.getTeam().getBench1();
		} else if (info.getTeam().getBench2()!=null&&info.getTeam().getBench2().getPlayerID()==playerID){
			return info.getTeam().getBench2();
		}
		for (BlitzballTeam team : info.getOpponents()){
			if (team.getLeftWing().getPlayerID()==playerID){
				selectedPlayer = team.getLeftWing();
				break;
			} else if (team.getRightWing().getPlayerID()==playerID){
				selectedPlayer = team.getRightWing();
				break;
			} else if (team.getMidfielder().getPlayerID()==playerID){
				selectedPlayer = team.getMidfielder();
				break;
			} else if (team.getLeftBack().getPlayerID()==playerID){
				selectedPlayer = team.getLeftBack();
				break;
			} else if (team.getRightBack().getPlayerID()==playerID){
				selectedPlayer = team.getRightBack();
				break;
			} else if (team.getKeeper().getPlayerID()==playerID){
				selectedPlayer = team.getKeeper();
				break;
			}
		}
		return selectedPlayer;
	}
}
