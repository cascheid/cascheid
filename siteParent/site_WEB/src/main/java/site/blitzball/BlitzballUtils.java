package site.blitzball;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map.Entry;

import org.springframework.dao.EmptyResultDataAccessException;

import site.blitzball.BlitzballLeagueStandings.BlitzballTeamResults;
import site.dao.BlitzballDao;
import site.dao.BlitzballDaoImpl;

public class BlitzballUtils {
	private static List<BlitzballTech> techList;
	private static HashMap<Integer, Integer> expLevels;
	private static HashMap<Integer, Integer> teamLevels;
	public static final Integer MAX_LEVEL = 30;
	
	public static void resetBlitzballInfo(Long gameID){
		BlitzballDao dao = new BlitzballDaoImpl();
		dao.resetBlitzballGameInfo(gameID);
	}

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
	
	public static BlitzballInfo getActiveLeague(BlitzballInfo info){
		BlitzballDao dao = new BlitzballDaoImpl();
		BlitzballLeague league=null;
		try {
			league=dao.getActiveLeagueByTeamID(info);
			//league.setDivisionOpponents(dao.getDivisionsOpponents(league.getLeagueID()));
			//league.setNonDivisionOpponents(dao.getNonDivisionsOpponents(info, league.getLeagueID()));
			league.setSchedule(dao.getLeagueSchedule(league));
			league.setPlayerStatistics(dao.getLeaguePlayerStatistics(league.getLeagueID(), league.getGameID()));
		} catch (EmptyResultDataAccessException e){
			//e.printStackTrace();
			generateRandomLeague(info);
			league=dao.getActiveLeagueByTeamID(info);
			league.setSchedule(dao.getLeagueSchedule(league));
			league.setPlayerStatistics(dao.getLeaguePlayerStatistics(league.getLeagueID(), league.getGameID()));
			//league=generateRandomLeague(info);
		}
		info.setLeague(league);
		return info;
	}
	
	public static BlitzballWeekResults simulateWeeksGames(BlitzballInfo info, BlitzballGame playerGame){
		BlitzballWeekResults results = new BlitzballWeekResults();
		List<BlitzballGame> gameList = info.getLeague().getSchedule().get(info.getLeague().getWeeksComplete()+1);
		for (BlitzballGame game : gameList){
			if (playerGame==null||(!game.getTeam1().getTeamID().equals(info.getTeam().getTeamID())&&!game.getTeam2().getTeamID().equals(info.getTeam().getTeamID()))){
				BlitzballTeam team1 = null;
				BlitzballTeam team2 = null;
				if (game.getTeam1().getTeamID().equals(info.getTeam().getTeamID())){
					team1=info.getTeam();
				} else if (game.getTeam2().getTeamID().equals(info.getTeam().getTeamID())){
					team2=info.getTeam();
				}
				for (BlitzballTeam team : info.getOpponents()){
					if (game.getTeam1().getTeamID().equals(team.getTeamID())){
						team1=team;
					} else if (game.getTeam2().getTeamID().equals(team.getTeamID())){
						team2=team;
					}
				}
				if (team1==null||team2==null){
					throw new IllegalStateException("Null team in simulating games:"+game.getTeam1().getTeamID() + "-"+ game.getTeam2().getTeamID());
				} else {
					//BlitzballGame newGame = BlitzballUtils.simulateGame(team1, team2);
					BlitzballUtils.simulateGame(game);
					/*game.setHalvesComplete(newGame.getHalvesComplete());
					game.setTeam1Score(newGame.getTeam1Score());
					game.setTeam2Score(newGame.getTeam2Score());
					game.setPlayerStatistics(newGame.getPlayerStatistics());*/
				}
			}
		}
		BlitzballDao dao = new BlitzballDaoImpl();
		info.getLeague().setWeeksComplete(info.getLeague().getWeeksComplete()+1);
		dao.advanceLeagueWeek(info.getLeague());
		String teamString="";
		for (BlitzballTeam team : info.getOpponents()){
			teamString+=team.getTeamID()+",";
		}
		teamString+=info.getTeam().getTeamID();
		List<BlitzballPlayer> expiredPlayers = dao.advancePlayerContracts(info, teamString);
		List<BlitzballPlayer> myExpiredPlayers = new ArrayList<BlitzballPlayer>();
		Iterator<BlitzballPlayer> it = expiredPlayers.iterator();
		while (it.hasNext()){
			BlitzballPlayer player = it.next();
			if (info.getTeam().getLeftWing().getPlayerID()==player.getPlayerID()||
					info.getTeam().getRightWing().getPlayerID()==player.getPlayerID()||
					info.getTeam().getMidfielder().getPlayerID()==player.getPlayerID()||
					info.getTeam().getLeftBack().getPlayerID()==player.getPlayerID()||
					info.getTeam().getRightBack().getPlayerID()==player.getPlayerID()||
					info.getTeam().getKeeper().getPlayerID()==player.getPlayerID()||
					(info.getTeam().getBench1()!=null&&info.getTeam().getBench1().getPlayerID()==player.getPlayerID())||
					(info.getTeam().getBench2()!=null&&info.getTeam().getBench2().getPlayerID()==player.getPlayerID())){
				it.remove();
				myExpiredPlayers.add(player);
			}
		}
		results.setGameResults(gameList);
		List<BlitzballPlayer> renewedPlayers = new ArrayList<BlitzballPlayer>();
		renewedPlayers.addAll(expiredPlayers);
		for (int i=0; i<renewedPlayers.size(); i++){
			if (Math.random()<0.5){
				renewedPlayers.set(i, dao.selectReplacementPlayer(renewedPlayers.get(i), info.getTeam().getTeamID()));
			} else {
				Integer newContractLength = 5 + (int) Math.round(Math.random()*15);
				renewedPlayers.get(i).setContractLength(newContractLength);
				dao.signPlayer(renewedPlayers.get(i).getPlayerID(), info.getTeam().getTeamID(), renewedPlayers.get(i).getTeamID(), newContractLength, dao.getCurrentPositionByPlayerID(info.getTeam().getTeamID(), renewedPlayers.get(i).getPlayerID()));
			}
		}
		results.setExpiredPlayers(expiredPlayers);
		results.setRenewedPlayers(renewedPlayers);
		results.setWeekNo(info.getLeague().getWeeksComplete());
		return results;
	}
	
	public static void signPlayer(BlitzballInfo info, Integer playerID, String position, Integer contractLength){
		BlitzballDao dao = new BlitzballDaoImpl();
		dao.signPlayer(playerID, info.getTeam().getTeamID(), info.getTeam().getTeamID(), contractLength, position);
	}
	
	public static BlitzballGame getLeagueGame(BlitzballLeague leagueInfo){
		List<BlitzballGame> weeksGames=leagueInfo.getSchedule().get(leagueInfo.getWeeksComplete()+1);
		BlitzballGame leagueGame = null;
		for (BlitzballGame game : weeksGames){
			if (game.getTeam1().getTeamID().equals(leagueInfo.getGameID())||game.getTeam2().getTeamID().equals(leagueInfo.getGameID())){
				leagueGame=game;
				break;
			}
		}
		return leagueGame;
	}
	
	public static BlitzballTeam getLeagueOpponentByID(BlitzballLeague leagueInfo){
		BlitzballTeam leagueOpponent=null;
		List<BlitzballGame> weeksGames=leagueInfo.getSchedule().get(leagueInfo.getWeeksComplete()+1);
		outer:
		for (BlitzballGame game : weeksGames){
			if (game.getTeam1().getTeamID().equals(leagueInfo.getGameID())){
				for (BlitzballTeam team : leagueInfo.getDivisionOpponents()){
					if (team.getTeamID().equals(game.getTeam2().getTeamID())){
						leagueOpponent=team;
						break outer;
					}
				}
				for (BlitzballTeam team : leagueInfo.getNonDivisionOpponents()){
					if (team.getTeamID().equals(game.getTeam2().getTeamID())){
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
		//to keep same point in memory
		origTeam.setLeftWing(adjustedTeam.getLeftWing());
		origTeam.setRightWing(adjustedTeam.getRightWing());
		origTeam.setMidfielder(adjustedTeam.getMidfielder());
		origTeam.setLeftBack(adjustedTeam.getLeftBack());
		origTeam.setRightBack(adjustedTeam.getRightBack());
		origTeam.setKeeper(adjustedTeam.getKeeper());
		origTeam.setBench1(adjustedTeam.getBench1());
		origTeam.setBench2(adjustedTeam.getBench2());
		
		return origTeam;
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
	
	public static BlitzballPlayer advancePlayerExp(BlitzballPlayer player, Integer exp, Long gameID){
		if (player.getLevel()<MAX_LEVEL){
			player.setExperience(player.getExperience()+exp);
			while (player.getExperience()>=getExpForLevel(player.getLevel()+1)&&player.getLevel()<MAX_LEVEL){
				player.setLevel(player.getLevel()+1);
			}
			player.setNextExp(getExpForLevel(player.getLevel()+1));
			BlitzballDao dao = new BlitzballDaoImpl();
			BlitzballPlayer updatedPlayer = dao.getPlayerByID(player.getPlayerID(), gameID, player.getLevel());
			List<String> updatedStats = new ArrayList<String>();
			if (!player.getSpeed().equals(updatedPlayer.getSpeed())){
				updatedStats.add("spd");
				player.setSpeed(updatedPlayer.getSpeed());
			}
			if (!player.getEndurance().equals(updatedPlayer.getEndurance())){
				updatedStats.add("end");
				player.setSpeed(updatedPlayer.getSpeed());
			}
			if (!player.getHp().equals(updatedPlayer.getHp())){
				updatedStats.add("hp");
				player.setHp(updatedPlayer.getHp());
			}
			if (!player.getAttack().equals(updatedPlayer.getAttack())){
				updatedStats.add("atk");
				player.setAttack(updatedPlayer.getAttack());
			}
			if (!player.getPass().equals(updatedPlayer.getPass())){
				updatedStats.add("pas");
				player.setPass(updatedPlayer.getPass());
			}
			if (!player.getShot().equals(updatedPlayer.getShot())){
				updatedStats.add("sht");
				player.setShot(updatedPlayer.getShot());
			}
			if (!player.getBlock().equals(updatedPlayer.getBlock())){
				updatedStats.add("blk");
				player.setBlock(updatedPlayer.getBlock());
			}
			if (!player.getCat().equals(updatedPlayer.getCat())){
				updatedStats.add("cat");
				player.setCat(updatedPlayer.getCat());
			}
			player.setUpdatedStats(updatedStats);
		}
		return player;
	}
	
	public static Integer getTeamLevelByExp(Integer experience){
		if (teamLevels==null){
			BlitzballDao dao = new BlitzballDaoImpl();
			teamLevels = dao.getTeamLevelMilestones();
		}
		int level=0;
		int expForLevel=0;
		while (experience>=expForLevel&&level<10){
			level++;
			expForLevel=teamLevels.get(level+1);
		}
		return level;
	}
	
	public static Integer getExpForLevel(Integer level){
		if (expLevels==null){
			getExpLevelMap();
		}
		return expLevels.get(level);
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
	
	public static HashMap<Integer, Integer> getExpLevelMap(){
		if (expLevels==null){
			BlitzballDao dao = new BlitzballDaoImpl();
			expLevels = dao.getExpLevelMilestones();
		}
		return expLevels;
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
	
	public static boolean addExperienceAndCheckLevelup(BlitzballInfo info, Integer experience){
		info.setTeamExp(info.getTeamExp()+experience);
		Integer level = getTeamLevelByExp(info.getTeamExp());
		if (level>info.getTeamLevel()){
			info.setTeamLevel(level);
			return true;
		}
		return false;
	}
	
	public static boolean persistBlitzballGame(BlitzballGame game, BlitzballInfo info){
		BlitzballDao dao = new BlitzballDaoImpl();
		for (BlitzballPlayer player : game.getTeam1().getActivePlayers()){
			player.setOrigLevel(player.getLevel());
			player.setOrigExp(player.getExperience());
			player.setOrigNextExp(player.getNextExp());
			for (BlitzballPlayerStatistics stats : game.getPlayerStatistics()){
				if (stats.getPlayerID().equals(player.getPlayerID())){
					advancePlayerExp(player, stats.getExpGained(), info.getTeam().getTeamID());
					break;
				}
			}
		}
		for (BlitzballPlayer player : game.getTeam2().getActivePlayers()){
			player.setOrigLevel(player.getLevel());
			player.setOrigExp(player.getExperience());
			player.setOrigNextExp(player.getNextExp());
			for (BlitzballPlayerStatistics stats : game.getPlayerStatistics()){
				if (stats.getPlayerID().equals(player.getPlayerID())){
					advancePlayerExp(player, stats.getExpGained(), info.getTeam().getTeamID());
					break;
				}
			}
		}
		boolean levelUp=false;
		if (game.getHalvesComplete()>=2&&(!game.getIsOvertimeGame()||game.getTeam1Score()!=game.getTeam2Score())){
			if (game.getTeam1Score()>game.getTeam2Score()){
				levelUp=addExperienceAndCheckLevelup(info, 3);
				dao.updateBlitzballInfo(info);
			} else if (game.getTeam1Score()==game.getTeam2Score()){
				levelUp=addExperienceAndCheckLevelup(info, 1);
				dao.updateBlitzballInfo(info);
			}
		}
		if (game.getLeagueGameID()!=null&&game.getTourneyGameID()==null){
			dao.saveLeagueGameInfo(game, info.getTeam().getTeamID());
		} else if (game.getLeagueGameID()==null&&game.getTourneyGameID()!=null){
			//dao.saveTournamentGameInfo(game, gameID);
		}
		return levelUp;
	}
	
	public static BlitzballGame simulateGame(BlitzballGame game){
		//BlitzballDao dao = new BlitzballDaoImpl();
		BlitzballTeam team1 = game.getTeam1();
		BlitzballTeam team2 = game.getTeam2();
		BlitzballPlayer currPlayer = team1.getMidfielder();
		BlitzballPlayer currOppPlayer = team2.getMidfielder();
		BlitzballPlayer dblbreakPlayer = team2.getMidfielder();
		BlitzballPlayer tplbreakPlayer = team2.getMidfielder();
		BlitzballPlayer firstTarget = team1.getLeftWing();
		BlitzballPlayer secondTarget = team1.getRightWing();
		BlitzballTeam currTeam = team1;
		BlitzballTeam currOppTeam = team2;
		HashMap<Integer, BlitzballPlayerStatistics> gameStats = new HashMap<Integer, BlitzballPlayerStatistics>();
		gameStats.put(team1.getLeftWing().getPlayerID(), new BlitzballPlayerStatistics(team1.getLeftWing().getPlayerID()));
		
		gameStats.put(team1.getRightWing().getPlayerID(), new BlitzballPlayerStatistics(team1.getRightWing().getPlayerID()));
		gameStats.put(team1.getMidfielder().getPlayerID(), new BlitzballPlayerStatistics(team1.getMidfielder().getPlayerID()));
		gameStats.put(team1.getLeftBack().getPlayerID(), new BlitzballPlayerStatistics(team1.getLeftBack().getPlayerID()));
		gameStats.put(team1.getRightBack().getPlayerID(), new BlitzballPlayerStatistics(team1.getRightBack().getPlayerID()));
		gameStats.put(team1.getKeeper().getPlayerID(), new BlitzballPlayerStatistics(team1.getKeeper().getPlayerID()));
		gameStats.put(team2.getLeftWing().getPlayerID(), new BlitzballPlayerStatistics(team2.getLeftWing().getPlayerID()));
		gameStats.put(team2.getRightWing().getPlayerID(), new BlitzballPlayerStatistics(team2.getRightWing().getPlayerID()));
		gameStats.put(team2.getMidfielder().getPlayerID(), new BlitzballPlayerStatistics(team2.getMidfielder().getPlayerID()));
		gameStats.put(team2.getLeftBack().getPlayerID(), new BlitzballPlayerStatistics(team2.getLeftBack().getPlayerID()));
		gameStats.put(team2.getRightBack().getPlayerID(), new BlitzballPlayerStatistics(team2.getRightBack().getPlayerID()));
		gameStats.put(team2.getKeeper().getPlayerID(), new BlitzballPlayerStatistics(team2.getKeeper().getPlayerID()));
		for (BlitzballPlayer team1Player : team1.getActivePlayers()){
			int learnableCount = 0;
			List<BlitzballTech> learnableTechs = new ArrayList<BlitzballTech>();
			for (BlitzballPlayer team2Player : team2.getActivePlayers()){
				List<BlitzballTech> currTechs = new ArrayList<BlitzballTech>();
				if (team2Player.getTech1()!=null&&team1Player.getLearnableTechs().contains(team2Player.getTech1().getTechID())){
					currTechs.add(team2Player.getTech1());
				}
				if (team2Player.getTech2()!=null&&team1Player.getLearnableTechs().contains(team2Player.getTech2().getTechID())){
					currTechs.add(team2Player.getTech2());
				}
				if (team2Player.getTech3()!=null&&team1Player.getLearnableTechs().contains(team2Player.getTech3().getTechID())){
					currTechs.add(team2Player.getTech3());
				}
				if (team2Player.getTech4()!=null&&team1Player.getLearnableTechs().contains(team2Player.getTech4().getTechID())){
					currTechs.add(team2Player.getTech4());
				}
				if (team2Player.getTech5()!=null&&team1Player.getLearnableTechs().contains(team2Player.getTech5().getTechID())){
					currTechs.add(team2Player.getTech5());
				}
				if (currTechs.size()>learnableCount){
					learnableCount=currTechs.size();
					learnableTechs=currTechs;
				} else if (currTechs.size()==learnableCount&&learnableCount!=0){
					if (Math.random()<.5){
						learnableCount=currTechs.size();
						learnableTechs=currTechs;
					}
				}	
			}
			if (learnableTechs.size()>0){
				List<BlitzballTech> techsLearned = new ArrayList<BlitzballTech>();
				for (BlitzballTech tech : learnableTechs){
					if (Math.random()<.2){
						techsLearned.add(tech);
					}
				}
				gameStats.get(team1Player.getPlayerID()).setTechsLearned(techsLearned);
			}
		}
		for (BlitzballPlayer team1Player : team2.getActivePlayers()){
			int learnableCount = 0;
			List<BlitzballTech> learnableTechs = new ArrayList<BlitzballTech>();
			for (BlitzballPlayer team2Player : team1.getActivePlayers()){
				List<BlitzballTech> currTechs = new ArrayList<BlitzballTech>();
				if (team2Player.getTech1()!=null&&team1Player.getLearnableTechs().contains(team2Player.getTech1().getTechID())){
					currTechs.add(team2Player.getTech1());
				}
				if (team2Player.getTech2()!=null&&team1Player.getLearnableTechs().contains(team2Player.getTech2().getTechID())){
					currTechs.add(team2Player.getTech2());
				}
				if (team2Player.getTech3()!=null&&team1Player.getLearnableTechs().contains(team2Player.getTech3().getTechID())){
					currTechs.add(team2Player.getTech3());
				}
				if (team2Player.getTech4()!=null&&team1Player.getLearnableTechs().contains(team2Player.getTech4().getTechID())){
					currTechs.add(team2Player.getTech4());
				}
				if (team2Player.getTech5()!=null&&team1Player.getLearnableTechs().contains(team2Player.getTech5().getTechID())){
					currTechs.add(team2Player.getTech5());
				}
				if (currTechs.size()>learnableCount){
					learnableCount=currTechs.size();
					learnableTechs=currTechs;
				} else if (currTechs.size()==learnableCount&&learnableCount!=0){
					if (Math.random()<.5){
						learnableCount=currTechs.size();
						learnableTechs=currTechs;
					}
				}	
			}
			if (learnableTechs.size()>0){
				List<BlitzballTech> techsLearned = new ArrayList<BlitzballTech>();
				for (BlitzballTech tech : learnableTechs){
					if (Math.random()<.2){
						techsLearned.add(tech);
					}
				}
				gameStats.get(team1Player.getPlayerID()).setTechsLearned(techsLearned);
			}
		}
		double rand=0;
		int possessions=1;
		double passChance=.8;
		double oneBreakChance=0;
		double twoBreakChance=0;
		double threeBreakChance=0;
		
		List<BlitzballPlayer> breakingPlayers = new ArrayList<BlitzballPlayer>();
		Comparator<BlitzballPlayer> breakComparator = new Comparator<BlitzballPlayer>(){
			public int compare(BlitzballPlayer p1, BlitzballPlayer p2) {
				if (p1.getAttack()>p2.getAttack()){
					return -1;
				} else if (p2.getAttack()>p1.getAttack()){
					return 1;
				} else if (p1.getBlock()>p2.getBlock()){
					return -1;
				} else if (p2.getBlock()>p1.getBlock()){
					return 1;
				}
				return 0;
			}
			
		};
		
		int numPossessions = (int)Math.round((.875+Math.random()/2)*30);
		
		possessionLoop:
		while (possessions<=numPossessions){
			breakingPlayers = new ArrayList<BlitzballPlayer>();
			if (currPlayer==currTeam.getMidfielder()){
				firstTarget = currTeam.getLeftWing();
				secondTarget = currTeam.getRightWing();
				currOppPlayer=currOppTeam.getMidfielder();
				rand=Math.random();
				if (rand<.2){
					dblbreakPlayer=currOppTeam.getLeftWing();
					tplbreakPlayer = currOppTeam.getRightWing();
					passChance=1.0;
				} else if (rand<.4) {
					dblbreakPlayer = currOppTeam.getRightWing();
					tplbreakPlayer = currOppTeam.getLeftWing();
					passChance=1.0;
				} else if (rand<.6) {
					dblbreakPlayer = currOppTeam.getRightBack();
					tplbreakPlayer = currOppTeam.getRightWing();
					passChance=.8;
				} else if (rand<.8) {
					dblbreakPlayer = currOppTeam.getLeftBack();
					tplbreakPlayer = currOppTeam.getLeftWing();
					passChance=.8;
				} else if (rand<.9){
					dblbreakPlayer = currOppTeam.getLeftBack();
					tplbreakPlayer = currOppTeam.getRightBack();
					passChance=.5;
				} else {
					dblbreakPlayer = currOppTeam.getRightBack();
					tplbreakPlayer = currOppTeam.getLeftBack();
					passChance=.5;
				}
				
				oneBreakChance=Math.min((Math.random()/2)*Math.max(1+(double)(currOppPlayer.getSpeed()-currPlayer.getSpeed())/50, 0),1);
				twoBreakChance=Math.min((Math.random()/2)*Math.max(.6+(double)(dblbreakPlayer.getSpeed()-currPlayer.getSpeed())/50, 0),1);
				threeBreakChance=Math.min((Math.random()/2)*Math.max(.2+(double)(tplbreakPlayer.getSpeed()-currPlayer.getSpeed())/50, 0),1);
			} else if (currPlayer==currTeam.getLeftWing()){
				rand=Math.random();
				if (rand<.5){
					firstTarget = currTeam.getMidfielder();
					secondTarget = currTeam.getRightWing();
				} else if (rand<.75){
					firstTarget = currTeam.getLeftBack();
					secondTarget = currTeam.getRightWing();
				} else {
					firstTarget = currTeam.getMidfielder();
					secondTarget = currTeam.getLeftBack();
				}
				currOppPlayer=currOppTeam.getRightBack();
				rand=Math.random();
				if (rand<.5){
					dblbreakPlayer = currOppTeam.getMidfielder();
					tplbreakPlayer = currOppTeam.getRightWing();
				} else {
					dblbreakPlayer = currOppTeam.getMidfielder();
					tplbreakPlayer = currOppTeam.getLeftBack();
				}

				oneBreakChance=Math.min((Math.random()/2)*Math.max(1.2+(double)(currOppPlayer.getSpeed()-currPlayer.getSpeed())/50, 0),1);
				twoBreakChance=Math.min((Math.random()/2)*Math.max(.8+(double)(dblbreakPlayer.getSpeed()-currPlayer.getSpeed())/50, 0),1);
				threeBreakChance=Math.min((Math.random()/2)*Math.max(.4+(double)(tplbreakPlayer.getSpeed()-currPlayer.getSpeed())/50, 0),1);
			} else if (currPlayer==currTeam.getRightWing()){
				rand=Math.random();
				if (rand<.5){
					firstTarget = currTeam.getMidfielder();
					secondTarget = currTeam.getLeftWing();
				} else if (rand<.75){
					firstTarget = currTeam.getRightBack();
					secondTarget = currTeam.getLeftWing();
				} else {
					firstTarget = currTeam.getMidfielder();
					secondTarget = currTeam.getRightBack();
				}
				currOppPlayer=currOppTeam.getLeftBack();
				rand=Math.random();
				passChance=0.5;
				if (rand<.5){
					dblbreakPlayer = currOppTeam.getMidfielder();
					tplbreakPlayer = currOppTeam.getLeftWing();
				} else {
					dblbreakPlayer = currOppTeam.getMidfielder();
					tplbreakPlayer = currOppTeam.getRightBack();
				}

				oneBreakChance=Math.min((Math.random()/2)*Math.max(1.2+(double)(currOppPlayer.getSpeed()-currPlayer.getSpeed())/50, 0),1);
				twoBreakChance=Math.min((Math.random()/2)*Math.max(.8+(double)(dblbreakPlayer.getSpeed()-currPlayer.getSpeed())/50, 0),1);
				threeBreakChance=Math.min((Math.random()/2)*Math.max(.4+(double)(tplbreakPlayer.getSpeed()-currPlayer.getSpeed())/50, 0),1);
			} else if (currPlayer==currTeam.getLeftBack()){
				rand=Math.random();
				if (rand<.5){
					firstTarget = currTeam.getMidfielder();
					secondTarget = currTeam.getLeftWing();
				} else if (rand<.75){
					firstTarget = currTeam.getRightBack();
					secondTarget = currTeam.getLeftWing();
				} else {
					firstTarget = currTeam.getMidfielder();
					secondTarget = currTeam.getRightBack();
				}
				currOppPlayer=currOppTeam.getRightWing();
				rand=Math.random();
				dblbreakPlayer = currOppTeam.getMidfielder();
				tplbreakPlayer = currOppTeam.getLeftWing();
				passChance=1.0;

				oneBreakChance=Math.min((Math.random()/2)*Math.max(.8+(double)(currOppPlayer.getSpeed()-currPlayer.getSpeed())/50, 0),1);
				twoBreakChance=Math.min((Math.random()/2)*Math.max(.4+(double)(dblbreakPlayer.getSpeed()-currPlayer.getSpeed())/50, 0),1);
				threeBreakChance=Math.min((Math.random()/2)*Math.max(.2+(double)(tplbreakPlayer.getSpeed()-currPlayer.getSpeed())/50, 0),1);
			} else if (currPlayer==currTeam.getRightBack()){
				rand=Math.random();
				if (rand<.5){
					firstTarget = currTeam.getMidfielder();
					secondTarget = currTeam.getRightWing();
				} else if (rand<.75){
					firstTarget = currTeam.getLeftBack();
					secondTarget = currTeam.getRightWing();
				} else {
					firstTarget = currTeam.getMidfielder();
					secondTarget = currTeam.getLeftBack();
				}
				currOppPlayer=currOppTeam.getLeftWing();
				rand=Math.random();
				dblbreakPlayer = currOppTeam.getMidfielder();
				tplbreakPlayer = currOppTeam.getRightWing();
				passChance=1.0;

				oneBreakChance=Math.min((Math.random()/2)*Math.max(.8+(double)(currOppPlayer.getSpeed()-currPlayer.getSpeed())/50, 0),1);
				twoBreakChance=Math.min((Math.random()/2)*Math.max(.4+(double)(dblbreakPlayer.getSpeed()-currPlayer.getSpeed())/50, 0),1);
				threeBreakChance=Math.min((Math.random()/2)*Math.max(.2+(double)(tplbreakPlayer.getSpeed()-currPlayer.getSpeed())/50, 0),1);
			} else {
				currPlayer = currTeam.getMidfielder();
				continue possessionLoop;
			}
			if (Math.random()<oneBreakChance){
				breakingPlayers.add(currOppPlayer);
			}
			if (Math.random()<twoBreakChance){
				breakingPlayers.add(dblbreakPlayer);
			}
			if (Math.random()<threeBreakChance){
				breakingPlayers.add(tplbreakPlayer);
			}
			Collections.sort(breakingPlayers, breakComparator);
			/*if (Math.random()<dblBreakChance){
				breakingPlayers.add(currOppPlayer);
				breakingPlayers.add(dblbreakPlayer);
				Collections.sort(breakingPlayers, breakComparator);
			} else if (Math.random()<tplBreakChance){
				breakingPlayers.add(currOppPlayer);
				breakingPlayers.add(dblbreakPlayer);
				breakingPlayers.add(tplbreakPlayer);
				Collections.sort(breakingPlayers, breakComparator);
			} else {
				breakingPlayers.add(currOppPlayer);
			}*/
			Integer expectedBreakLeft = currPlayer.getEndurance();
			int numBreaks=0;
			for (BlitzballPlayer player : breakingPlayers){
				expectedBreakLeft-=player.getAttack();
				if (expectedBreakLeft<=0){
					int brokenCount=0;
					int expectedPassLeft = currPlayer.getPass();
					for (BlitzballPlayer blocker : breakingPlayers){
						if (brokenCount>=numBreaks){
							expectedPassLeft-=blocker.getBlock();
						}
						brokenCount++;
					}
					if (expectedPassLeft<expectedBreakLeft){
						numBreaks++;
					}
					break;
				} else {
					numBreaks++;
				}
			}
			
			rand = Math.random();
			int breakLeft = currPlayer.getEndurance();
			int valueLeft=0;
			int techValue=0;
			boolean shooting=false;
			if (rand<passChance){
				shooting=false;

				List<Integer> techValues = new ArrayList<Integer>();
				techValues.add(0);
				if (currPlayer.getTech1()!=null&&currPlayer.getTech1().getTechType().equals("PASS")){
					techValues.add(currPlayer.getTech1().getStatMod());
				}
				if (currPlayer.getTech2()!=null&&currPlayer.getTech2().getTechType().equals("PASS")){
					techValues.add(currPlayer.getTech2().getStatMod());
				}
				if (currPlayer.getTech3()!=null&&currPlayer.getTech3().getTechType().equals("PASS")){
					techValues.add(currPlayer.getTech3().getStatMod());
				}
				if (currPlayer.getTech4()!=null&&currPlayer.getTech4().getTechType().equals("PASS")){
					techValues.add(currPlayer.getTech4().getStatMod());
				}
				if (currPlayer.getTech5()!=null&&currPlayer.getTech5().getTechType().equals("PASS")){
					techValues.add(currPlayer.getTech5().getStatMod());
				}
				Collections.shuffle(techValues);
				techValue=techValues.get(0);
				valueLeft= currPlayer.getPass() - 3;// + techValues.get(0) - 3;
			} else {
				shooting=true;
				List<Integer> techValues = new ArrayList<Integer>();
				techValues.add(0);
				if (currPlayer.getTech1()!=null&&currPlayer.getTech1().getTechType().equals("SHOT")){
					techValues.add(currPlayer.getTech1().getStatMod());
				}
				if (currPlayer.getTech2()!=null&&currPlayer.getTech2().getTechType().equals("SHOT")){
					techValues.add(currPlayer.getTech2().getStatMod());
				}
				if (currPlayer.getTech3()!=null&&currPlayer.getTech3().getTechType().equals("SHOT")){
					techValues.add(currPlayer.getTech3().getStatMod());
				}
				if (currPlayer.getTech4()!=null&&currPlayer.getTech4().getTechType().equals("SHOT")){
					techValues.add(currPlayer.getTech4().getStatMod());
				}
				if (currPlayer.getTech5()!=null&&currPlayer.getTech5().getTechType().equals("SHOT")){
					techValues.add(currPlayer.getTech5().getStatMod());
				}
				Collections.shuffle(techValues);
				techValue=techValues.get(0);
				valueLeft = currPlayer.getShot();// + Math.round(techValue/techCount);
			}
			
			int counter=0;
			BlitzballPlayerStatistics currStats = gameStats.get(currPlayer.getPlayerID());
			for (BlitzballPlayer player : breakingPlayers){
				counter++;
				if (counter>numBreaks){
					valueLeft-=Math.round(((.5+Math.random())*player.getBlock()));
					if (valueLeft<=0){
						BlitzballPlayerStatistics attackerStats = gameStats.get(player.getPlayerID());
						attackerStats.setBlocks(attackerStats.getBlocks()+1);
						currStats.setTurnovers(currStats.getTurnovers()+1);
						attackerStats.setExpGained(attackerStats.getExpGained()+3);
						currStats.setExpGained(currStats.getExpGained()+1);
						currPlayer = player;
						if (currTeam==team1){
							currTeam=team2;
							currOppTeam=team1;
						} else {
							currTeam=team1;
							currOppTeam=team2;
						}
						possessions++;
						continue possessionLoop;
					}
				} else {
					List<Integer> techValues = new ArrayList<Integer>();
					techValues.add(0);
					if (player.getTech1()!=null&&player.getTech1().getTechType().equals("ATTACK")){
						techValues.add(player.getTech1().getStatMod());
					}
					if (player.getTech2()!=null&&player.getTech2().getTechType().equals("ATTACK")){
						techValues.add(player.getTech2().getStatMod());
					}
					if (player.getTech3()!=null&&player.getTech3().getTechType().equals("ATTACK")){
						techValues.add(player.getTech3().getStatMod());
					}
					if (player.getTech4()!=null&&player.getTech4().getTechType().equals("ATTACK")){
						techValues.add(player.getTech4().getStatMod());
					}
					if (player.getTech5()!=null&&player.getTech5().getTechType().equals("ATTACK")){
						techValues.add(player.getTech5().getStatMod());
					}
					Collections.shuffle(techValues);
					BlitzballPlayerStatistics attackerStats = gameStats.get(player.getPlayerID());
					int aTechValue=techValues.get(0);
					if (aTechValue>0){
						if (aTechValue>5){
							attackerStats.setExpGained(attackerStats.getExpGained()+2);
						} else if (aTechValue>3){
							attackerStats.setExpGained(attackerStats.getExpGained()+3);
						} else {
							attackerStats.setExpGained(attackerStats.getExpGained()+4);
						}
					} else {
						attackerStats.setExpGained(attackerStats.getExpGained()+1);
					}
					breakLeft-=Math.round(((.5+Math.random())*(player.getAttack()+techValues.get(0))));
					if (breakLeft<=0){
						attackerStats.setTackles(attackerStats.getTackles()+1);
						attackerStats.setExpGained(attackerStats.getExpGained()+3);
						currStats.setTurnovers(currStats.getTurnovers()+1);
						currPlayer = player;
						if (currTeam==team1){
							currTeam=team2;
							currOppTeam=team1;
						} else {
							currTeam=team1;
							currOppTeam=team2;
						}
						possessions++;
						continue possessionLoop;
					} else {
						currStats.setBreaks(currStats.getTurnovers()+1);
						currStats.setExpGained(currStats.getExpGained()+1);
						if (counter==numBreaks){
							valueLeft += techValue;
							if (techValue>0){
								if (techValue>5){
									currStats.setExpGained(currStats.getExpGained()+2);
								} else if (techValue>3){
									currStats.setExpGained(currStats.getExpGained()+3);
								} else {
									currStats.setExpGained(currStats.getExpGained()+4);
								}
							} else {
								currStats.setExpGained(currStats.getExpGained()+1);
							}
						}
					}
				}
			}
				
			if (valueLeft>0){
				if (shooting){
					
					double saveValue = currOppTeam.getKeeper().getCat();
					BlitzballPlayerStatistics keeperStats = gameStats.get(currOppTeam.getKeeper().getPlayerID());
					if (currOppTeam.getKeeper().getTech1()!=null&&currOppTeam.getKeeper().getTech1().getTechName().equals("Super Goalie")||
							currOppTeam.getKeeper().getTech1()!=null&&currOppTeam.getKeeper().getTech1().getTechName().equals("Super Goalie")||
							currOppTeam.getKeeper().getTech1()!=null&&currOppTeam.getKeeper().getTech1().getTechName().equals("Super Goalie")||
							currOppTeam.getKeeper().getTech1()!=null&&currOppTeam.getKeeper().getTech1().getTechName().equals("Super Goalie")||
							currOppTeam.getKeeper().getTech1()!=null&&currOppTeam.getKeeper().getTech1().getTechName().equals("Super Goalie")){
						if (Math.random()<.6){
							saveValue+=Math.random()*10;
							keeperStats.setExpGained(keeperStats.getExpGained()+3);
						}
					}
					double shotValue = (valueLeft)*0.9 - saveValue*(Math.random()+.5);
					//double shotValue = calculateShotValue(currPlayer, currOppTeam.getKeeper(), 0);
					currStats.setShots(currStats.getShots()+1);
					keeperStats.setShotsAgainst(keeperStats.getShotsAgainst()+1);
					if (shotValue>=1){
						currStats.setGoals(currStats.getGoals()+1);
						currStats.setExpGained(currStats.getExpGained()+3);
						keeperStats.setGoalsAgainst(keeperStats.getGoalsAgainst()+1);
						possessions++;//extra if scored
					} else {
						double catchChance=.5;
						if (currOppTeam.getKeeper().getTech1()!=null&&currOppTeam.getKeeper().getTech1().getTechName().equals("Grip Gloves")||
								currOppTeam.getKeeper().getTech1()!=null&&currOppTeam.getKeeper().getTech1().getTechName().equals("Grip Gloves")||
								currOppTeam.getKeeper().getTech1()!=null&&currOppTeam.getKeeper().getTech1().getTechName().equals("Grip Gloves")||
								currOppTeam.getKeeper().getTech1()!=null&&currOppTeam.getKeeper().getTech1().getTechName().equals("Grip Gloves")||
								currOppTeam.getKeeper().getTech1()!=null&&currOppTeam.getKeeper().getTech1().getTechName().equals("Grip Gloves")){
							catchChance=.8;
						}
						if (Math.random()<catchChance){
							if (currTeam==team1){
								currTeam=team2;
								currOppTeam=team1;
							} else {
								currTeam=team2;
								currOppTeam=team1;
							}
							keeperStats.setExpGained(keeperStats.getExpGained()+3);
						} else {
							if (Math.random()<.667){
								if (currTeam==team1){
									currTeam=team2;
									currOppTeam=team1;
								} else {
									currTeam=team2;
									currOppTeam=team1;
								}
							}
							keeperStats.setExpGained(keeperStats.getExpGained()+3);
						}
						int randomSel = (int) Math.floor(Math.random()*5);
						if (randomSel==1){
							currPlayer=currTeam.getLeftWing();
						} else if (randomSel==2){
							currPlayer=currTeam.getRightWing();
						} else if (randomSel==3){
							currPlayer=currTeam.getLeftBack();
						} else if (randomSel==4){
							currPlayer=currTeam.getRightBack();
						} else {
							currPlayer=currTeam.getMidfielder();
						}
					}
					possessions++;
				} else {
					currStats.setExpGained(currStats.getExpGained()+2);
					if (Math.random()<.5){
						currPlayer = firstTarget;
					} else {
						currPlayer = secondTarget;
					}
				}
			}
		}
		
		/*BlitzballGame simGame = new BlitzballGame();
		simGame.setTeam1(team1);
		simGame.setTeam2(team2);*/
		int team1Score = gameStats.get(team1.getLeftWing().getPlayerID()).getGoals()+
				gameStats.get(team1.getRightWing().getPlayerID()).getGoals()+
				gameStats.get(team1.getMidfielder().getPlayerID()).getGoals()+
				gameStats.get(team1.getLeftBack().getPlayerID()).getGoals()+
				gameStats.get(team1.getRightBack().getPlayerID()).getGoals();
		int team2Score = gameStats.get(team2.getLeftWing().getPlayerID()).getGoals()+
				gameStats.get(team2.getRightWing().getPlayerID()).getGoals()+
				gameStats.get(team2.getMidfielder().getPlayerID()).getGoals()+
				gameStats.get(team2.getLeftBack().getPlayerID()).getGoals()+
				gameStats.get(team2.getRightBack().getPlayerID()).getGoals();
		game.setTeam1Score(team1Score);
		game.setTeam2Score(team2Score);
		game.setHalvesComplete(2);
		List<BlitzballPlayerStatistics> list = new ArrayList<BlitzballPlayerStatistics>();
		Iterator<Entry<Integer, BlitzballPlayerStatistics>> it = gameStats.entrySet().iterator();
		while (it.hasNext()){
			Entry<Integer, BlitzballPlayerStatistics> e = it.next();
			list.add(e.getValue());
		}
		game.setPlayerStatistics(list);
		return game;
	}
	
	public static List<BlitzballPlayer> getAllPlayers(Long gameID){
		BlitzballDao dao = new BlitzballDaoImpl();
		return dao.getAllGamePlayers(gameID);
	}
	
	public static BlitzballLeagueResult handleLeagueComplete(BlitzballInfo info, BlitzballWeekResults weekResults){
		BlitzballLeagueResult result = new BlitzballLeagueResult();
		result.setPrize(info.getLeague().getPrize());
		BlitzballLeagueStandings standings = info.getLeague().getLeagueStandings();
		BlitzballTeamResults div1Winner = standings.getDivision1Standings().get(0);
		BlitzballTeamResults div2Winner = standings.getDivision2Standings().get(0);
		if (div1Winner.getPoints()>div2Winner.getPoints()){
			result.setFirstPlaceTeam(div1Winner.getTeamID());
			result.setSecondPlaceTeam(div2Winner.getTeamID());
		} else if (div2Winner.getPoints()>div1Winner.getPoints()){
			result.setFirstPlaceTeam(div2Winner.getTeamID());
			result.setSecondPlaceTeam(div1Winner.getTeamID());
		} else {//if they're not in the same division, they only played once
			Iterator<Entry<Integer, List<BlitzballGame>>> it = info.getLeague().getSchedule().entrySet().iterator();
			topLoop: while (it.hasNext()){
				Entry<Integer, List<BlitzballGame>> e = it.next();
				for (BlitzballGame game : e.getValue()){
					if (game.getTeam1().getTeamID()==div1Winner.getTeamID()&&game.getTeam2().getTeamID()==div2Winner.getTeamID()){
						if (game.getTeam1Score()>game.getTeam2Score()){
							result.setFirstPlaceTeam(div1Winner.getTeamID());
							result.setSecondPlaceTeam(div2Winner.getTeamID());
						} else if (game.getTeam2Score()>game.getTeam1Score()){
							result.setFirstPlaceTeam(div2Winner.getTeamID());
							result.setSecondPlaceTeam(div1Winner.getTeamID());
						}
						break topLoop;
					} else if (game.getTeam1().getTeamID()==div2Winner.getTeamID()&&game.getTeam2().getTeamID()==div1Winner.getTeamID()){
						if (game.getTeam1Score()>game.getTeam2Score()){
							result.setFirstPlaceTeam(div2Winner.getTeamID());
							result.setSecondPlaceTeam(div1Winner.getTeamID());
						} else if (game.getTeam2Score()>game.getTeam1Score()){
							result.setFirstPlaceTeam(div1Winner.getTeamID());
							result.setSecondPlaceTeam(div2Winner.getTeamID());
						}
						break topLoop;
					}
				}
			}
			if (result.getFirstPlaceTeam()==null){//they tied
				if (div1Winner.getWins()>div2Winner.getWins()){
					result.setFirstPlaceTeam(div1Winner.getTeamID());
					result.setSecondPlaceTeam(div2Winner.getTeamID());
				} else if (div2Winner.getWins()>div1Winner.getWins()){
					result.setFirstPlaceTeam(div2Winner.getTeamID());
					result.setSecondPlaceTeam(div1Winner.getTeamID());
				} else {//tough luck division 2, i'm not writing more code for this
					result.setFirstPlaceTeam(div1Winner.getTeamID());
					result.setSecondPlaceTeam(div2Winner.getTeamID());
				}
			}
		}
		
		List<BlitzballPlayerStatistics> statistics = info.getLeague().getPlayerStatistics();
		statistics.sort(new Comparator<BlitzballPlayerStatistics>(){
			public int compare(BlitzballPlayerStatistics p1, BlitzballPlayerStatistics p2) {
				int comp = p2.getGoals().compareTo(p1.getGoals());
				if (comp!=0){
					return comp;
				} else {
					comp = p1.getShots().compareTo(p2.getShots());
					if (comp!=0){
						return comp;
					} else {
						return p1.getTurnovers().compareTo(p2.getTurnovers());
					}
				}
			};
		});
		result.setTopScorerPlayerName(statistics.get(0).getPlayerName());
		for (BlitzballPlayer player : info.getTeam().getAllPlayers()){
			if (player.getPlayerID().equals(statistics.get(0).getPlayerID())){
				info.setAvailableCash(info.getAvailableCash()+info.getLeague().getPrize());
			}
		}
		boolean teamLevelup=false;
		if (info.getTeam().getTeamID().equals(result.getFirstPlaceTeam())){
			info.setAvailableCash(info.getAvailableCash()+info.getLeague().getPrize()*3);
			info.setLeagueWins(info.getLeagueWins()+1);
			teamLevelup=addExperienceAndCheckLevelup(info, 30);
		} else if (info.getTeam().getTeamID().equals(result.getSecondPlaceTeam())){
			teamLevelup=addExperienceAndCheckLevelup(info, 15);
			info.setAvailableCash(info.getAvailableCash()+info.getLeague().getPrize()*2);
		} else {
			teamLevelup=addExperienceAndCheckLevelup(info, 5);
			info.setAvailableCash(info.getAvailableCash()+info.getLeague().getPrize());
		}
		if (teamLevelup){
			weekResults.setTeamLevelUp(teamLevelup);
		}
		BlitzballDao dao = new BlitzballDaoImpl();
		dao.updateBlitzballInfo(info);
		return result;
		
	}
}
