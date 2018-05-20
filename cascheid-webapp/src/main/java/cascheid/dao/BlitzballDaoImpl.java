package cascheid.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Types;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import org.springframework.jdbc.core.PreparedStatementCreator;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.core.SqlParameter;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.SqlParameterSource;
import org.springframework.jdbc.core.simple.SimpleJdbcCall;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;

import cascheid.blitzball.BlitzballGame;
import cascheid.blitzball.BlitzballInfo;
import cascheid.blitzball.BlitzballLeague;
import cascheid.blitzball.BlitzballLeagueResult;
import cascheid.blitzball.BlitzballPlayer;
import cascheid.blitzball.BlitzballPlayerStatistics;
import cascheid.blitzball.BlitzballTeam;
import cascheid.blitzball.BlitzballTech;
import cascheid.blitzball.BlitzballUtils;

public class BlitzballDaoImpl extends ParentDao implements BlitzballDao{
	private RowMapper<BlitzballPlayer> playerMapper = new RowMapper<BlitzballPlayer>(){
		public BlitzballPlayer mapRow(ResultSet rs, int rowNum) throws SQLException {
			BlitzballPlayer player = new BlitzballPlayer();
			player.setPlayerID(rs.getInt("PLAYER_ID"));
			player.setTeamID(rs.getLong("CURR_TEAM"));
			player.setName(rs.getString("NAME"));
			player.setLevel(rs.getInt("LEVEL"));
			player.setExperience(rs.getInt("EXP"));
			player.setNextExp(BlitzballUtils.getExpForLevel(player.getLevel()+1));
			player.setSpeed(rs.getInt("SPD"));
			player.setEndurance(rs.getInt("ENDUR"));
			player.setHp(rs.getInt("HP"));
			player.setAttack(rs.getInt("ATK"));
			player.setPass(rs.getInt("PASS"));
			player.setShot(rs.getInt("SHOT"));
			player.setBlock(rs.getInt("BLK"));
			player.setCat(rs.getInt("CAT"));
			player.setContractLength(rs.getInt("CONTRACT_LENGTH"));
			player.setSalary(rs.getInt("SALARY"));
			player.setTech1(BlitzballUtils.getTechFromTechID(rs.getInt("TECH1")));
			player.setTech2(BlitzballUtils.getTechFromTechID(rs.getInt("TECH2")));
			player.setTech3(BlitzballUtils.getTechFromTechID(rs.getInt("TECH3")));
			player.setTech4(BlitzballUtils.getTechFromTechID(rs.getInt("TECH4")));
			player.setTech5(BlitzballUtils.getTechFromTechID(rs.getInt("TECH5")));
			player.setKeyTech1(BlitzballUtils.getTechFromTechID(rs.getInt("KEYTECH1")));
			player.setKeyTech2(BlitzballUtils.getTechFromTechID(rs.getInt("KEYTECH2")));
			player.setKeyTech3(BlitzballUtils.getTechFromTechID(rs.getInt("KEYTECH3")));
			player.setLearnableTechs(jdbcTemplate.queryForList("SELECT TECH_ID FROM BB_PLAYER_TECHS WHERE GAME_ID=? AND PLAYER_ID=? AND LEARNED=FALSE", new Object[]{rs.getLong("GAME_ID"), player.getPlayerID()}, Integer.class));
			player.setLearnedTechs(jdbcTemplate.queryForList("SELECT TECH_ID FROM BB_PLAYER_TECHS WHERE GAME_ID=? AND PLAYER_ID=? AND LEARNED=TRUE", new Object[]{rs.getLong("GAME_ID"), player.getPlayerID()}, Integer.class));
			player.setModel(rs.getString("MODEL"));
			return player;
		}
	};
	
	public BlitzballPlayer getPlayerByID(Integer playerID, Long gameID, Integer optionalLevel){
		if (jdbcTemplate==null){
			setDataSource(getDataSource());
		}
		if (optionalLevel==null){
			return jdbcTemplate.queryForObject("SELECT * FROM BB_PLAYERS P INNER JOIN BB_PLAYER_LVL_STATS PLS ON P.LEVEL=PLS.LEVEL AND P.PLAYER_ID=PLS.PLAYER_ID WHERE P.PLAYER_ID=? AND P.GAME_ID=?" , new Object[]{playerID, gameID}, playerMapper);
		} else {
			return jdbcTemplate.queryForObject("SELECT * FROM BB_PLAYERS P INNER JOIN BB_PLAYER_LVL_STATS PLS ON P.PLAYER_ID=PLS.PLAYER_ID WHERE P.PLAYER_ID=? AND P.GAME_ID=? AND PLS.LEVEL=?" , new Object[]{playerID, gameID, optionalLevel}, playerMapper);
		}
	}

	@Override
	public BlitzballInfo getBlitzballByIdentifier(Long identifier) {
		if (jdbcTemplate==null){
			setDataSource(getDataSource());
		}
		BlitzballInfo info = jdbcTemplate.queryForObject("SELECT * FROM BB_INFO WHERE USER_ID=? AND GAME_ID>=0", new Object[]{identifier}, new RowMapper<BlitzballInfo>(){
			public BlitzballInfo mapRow(ResultSet rs, int rowNum) throws SQLException {
				BlitzballInfo info = new BlitzballInfo();
				info.setUserID(identifier);
				info.setLeagueWins(rs.getInt("LEAGUE_WINS"));
				info.setTournamentWins(rs.getInt("TOURNAMENT_WINS"));
				info.setTeamLevel(rs.getInt("TEAM_LVL"));
				info.setTeamExp(rs.getInt("TEAM_EXP"));
				
				final Long gameID=rs.getLong("GAME_ID");
				
				RowMapper<BlitzballTeam> teamMapper = new RowMapper<BlitzballTeam>(){
					public BlitzballTeam mapRow(ResultSet rs, int rowNum) throws SQLException {
						BlitzballTeam myTeam=new BlitzballTeam();
						myTeam.setTeamID(rs.getLong("TEAM_ID"));
						String teamName=rs.getString("TEAM_NAME");
						myTeam.setTeamName(teamName);

						myTeam.setLeftWing(getPlayerByID(rs.getInt("LWING"), gameID, null));
						myTeam.setRightWing(getPlayerByID(rs.getInt("RWING"), gameID, null));
						myTeam.setMidfielder(getPlayerByID(rs.getInt("MID"), gameID, null));
						myTeam.setLeftBack(getPlayerByID(rs.getInt("LBACK"), gameID, null));
						myTeam.setRightBack(getPlayerByID(rs.getInt("RBACK"), gameID, null));
						myTeam.setKeeper(getPlayerByID(rs.getInt("KEEPER"), gameID, null));
						myTeam.getRightWing().setTeamName(teamName);
						myTeam.getLeftWing().setTeamName(teamName);
						myTeam.getMidfielder().setTeamName(teamName);
						myTeam.getRightBack().setTeamName(teamName);
						myTeam.getLeftBack().setTeamName(teamName);
						myTeam.getKeeper().setTeamName(teamName);
						Long tempID=rs.getLong("BENCH1");
						if (tempID!=null&&tempID>0){
							myTeam.setBench1(getPlayerByID(rs.getInt("BENCH1"), gameID, null));
							myTeam.getBench1().setTeamName(teamName);
							tempID=rs.getLong("BENCH2");
							if (tempID!=null&&tempID>0){
								myTeam.setBench2(getPlayerByID(rs.getInt("BENCH2"), gameID, null));
								myTeam.getBench2().setTeamName(teamName);
							}
						}
						return myTeam;
					}
					
				};
				BlitzballTeam myTeam = jdbcTemplate.queryForObject("SELECT * FROM BB_TEAM WHERE TEAM_ID=?", new Object[]{gameID}, teamMapper);
				info.setTeam(myTeam);
				
				List<BlitzballTeam> oppTeams = new ArrayList<BlitzballTeam>();
				oppTeams.add(jdbcTemplate.queryForObject("SELECT * FROM BB_TEAM WHERE TEAM_ID=?", new Object[]{rs.getLong("OPPONENT_1")}, teamMapper));
				oppTeams.add(jdbcTemplate.queryForObject("SELECT * FROM BB_TEAM WHERE TEAM_ID=?", new Object[]{rs.getLong("OPPONENT_2")}, teamMapper));
				oppTeams.add(jdbcTemplate.queryForObject("SELECT * FROM BB_TEAM WHERE TEAM_ID=?", new Object[]{rs.getLong("OPPONENT_3")}, teamMapper));
				oppTeams.add(jdbcTemplate.queryForObject("SELECT * FROM BB_TEAM WHERE TEAM_ID=?", new Object[]{rs.getLong("OPPONENT_4")}, teamMapper));
				oppTeams.add(jdbcTemplate.queryForObject("SELECT * FROM BB_TEAM WHERE TEAM_ID=?", new Object[]{rs.getLong("OPPONENT_5")}, teamMapper));
				oppTeams.add(jdbcTemplate.queryForObject("SELECT * FROM BB_TEAM WHERE TEAM_ID=?", new Object[]{rs.getLong("OPPONENT_6")}, teamMapper));
				oppTeams.add(jdbcTemplate.queryForObject("SELECT * FROM BB_TEAM WHERE TEAM_ID=?", new Object[]{rs.getLong("OPPONENT_7")}, teamMapper));
				info.setOpponents(oppTeams);
				
				return info;
			}
		});
		return info;
	}
	
	public void updateBlitzballInfo(BlitzballInfo info){
		if (jdbcTemplate==null){
			setDataSource(getDataSource());
		}
		
		jdbcTemplate.update("UPDATE BB_INFO SET TEAM_LVL=?, TEAM_EXP=?, AVAILABLE_CASH=?, LEAGUE_WINS=?, TOURNAMENT_WINS=? WHERE GAME_ID=?", new Object[]{info.getTeamLevel(), info.getTeamExp(), info.getAvailableCash(), info.getLeagueWins(), info.getTournamentWins(), info.getTeam().getTeamID()});
	}
	
	public void resetBlitzballGameInfo(Long gameID){
		if (jdbcTemplate==null){
			setDataSource(getDataSource());
		}

		SimpleJdbcCall resetGameProc= new SimpleJdbcCall(this.getDataSource()).withProcedureName("RESET_BLITZBALL_GAME");
		resetGameProc.declareParameters(new SqlParameter("p_game_id", Types.NUMERIC));
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("p_game_id", gameID);
		
		SqlParameterSource src = new MapSqlParameterSource().addValues(params);
		resetGameProc.execute(src);
	}

	@Override
	public Long insertNewBlitzballGame(Long identifier, String teamName) {
		if (jdbcTemplate==null){
			setDataSource(getDataSource());
		}
		SimpleJdbcCall createGameFunc = new SimpleJdbcCall(this.getDataSource()).withFunctionName("CREATE_BLITZBALL_GAME");
		createGameFunc.declareParameters(new SqlParameter("p_identifier", Types.NUMERIC), 
				new SqlParameter("p_team_name", Types.VARCHAR));
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("p_identifier", identifier);
		params.put("p_team_name", teamName);
		
		SqlParameterSource in = new MapSqlParameterSource().addValues(params);
		Integer gameID=createGameFunc.executeFunction(Integer.class, in);
		return new Long(gameID);
	}

	@Override
	public BlitzballLeague getActiveLeagueByTeamID(BlitzballInfo info) {
		if (jdbcTemplate==null){
			setDataSource(getDataSource());
		}
		BlitzballLeague league = jdbcTemplate.queryForObject("SELECT * FROM BB_LEAGUE WHERE GAME_ID=? AND WEEKS_COMPLETE<10", new Object[]{info.getTeam().getTeamID()}, new RowMapper<BlitzballLeague>(){
			public BlitzballLeague mapRow(ResultSet rs, int rowNum) throws SQLException {
				BlitzballLeague league = new BlitzballLeague();
				league.setLeagueID(rs.getLong("LEAGUE_ID"));
				league.setGameID(rs.getLong("GAME_ID"));
				league.setWeeksComplete(rs.getInt("WEEKS_COMPLETE"));
				league.setPrize(rs.getInt("PRIZE"));
				List<Long> divOppIds = new ArrayList<Long>();
				divOppIds.add(rs.getLong("DIV_OPP1"));
				divOppIds.add(rs.getLong("DIV_OPP2"));
				divOppIds.add(rs.getLong("DIV_OPP3"));
				List<BlitzballTeam> divOpps = new ArrayList<BlitzballTeam>();
				List<BlitzballTeam> nonDivOpps = new ArrayList<BlitzballTeam>();
				for (BlitzballTeam opp : info.getOpponents()){
					Integer wins = jdbcTemplate.queryForObject("SELECT COUNT(*) FROM BB_LEAGUE_GAMES WHERE (LEAGUE_ID=? AND TEAM_1=? AND SCORE_1>SCORE_2) OR (LEAGUE_ID=? AND TEAM_2=? AND SCORE_2>SCORE_1)", new Object[]{league.getLeagueID(), opp.getTeamID(), league.getLeagueID(), opp.getTeamID()}, Integer.class);
					Integer losses = jdbcTemplate.queryForObject("SELECT COUNT(*) FROM BB_LEAGUE_GAMES WHERE (LEAGUE_ID=? AND TEAM_1=? AND SCORE_2>SCORE_1) OR (LEAGUE_ID=? AND TEAM_2=? AND SCORE_1>SCORE_2)", new Object[]{league.getLeagueID(), opp.getTeamID(), league.getLeagueID(), opp.getTeamID()}, Integer.class);
					Integer ties = jdbcTemplate.queryForObject("SELECT COUNT(*) FROM BB_LEAGUE_GAMES WHERE LEAGUE_ID=? AND SCORE_1=SCORE_2 AND SCORE_1 IS NOT NULL AND (TEAM_1=? OR TEAM_2=?)", new Object[]{league.getLeagueID(), opp.getTeamID(), opp.getTeamID()}, Integer.class);
					opp.setWins(wins);
					opp.setLosses(losses);
					opp.setTies(ties);
					if (divOppIds.contains(opp.getTeamID())){
						divOpps.add(opp);
					} else {
						nonDivOpps.add(opp);
					}
				}
				BlitzballTeam myTeam = info.getTeam();
				Integer wins = jdbcTemplate.queryForObject("SELECT COUNT(*) FROM BB_LEAGUE_GAMES WHERE (LEAGUE_ID=? AND TEAM_1=? AND SCORE_1>SCORE_2) OR (LEAGUE_ID=? AND TEAM_2=? AND SCORE_2>SCORE_1)", new Object[]{league.getLeagueID(), myTeam.getTeamID(), league.getLeagueID(), myTeam.getTeamID()}, Integer.class);
				Integer losses = jdbcTemplate.queryForObject("SELECT COUNT(*) FROM BB_LEAGUE_GAMES WHERE (LEAGUE_ID=? AND TEAM_1=? AND SCORE_2>SCORE_1) OR (LEAGUE_ID=? AND TEAM_2=? AND SCORE_1>SCORE_2)", new Object[]{league.getLeagueID(), myTeam.getTeamID(), league.getLeagueID(), myTeam.getTeamID()}, Integer.class);
				Integer ties = jdbcTemplate.queryForObject("SELECT COUNT(*) FROM BB_LEAGUE_GAMES WHERE LEAGUE_ID=? AND SCORE_1=SCORE_2 AND SCORE_1 IS NOT NULL AND (TEAM_1=? OR TEAM_2=?)", new Object[]{league.getLeagueID(), myTeam.getTeamID(), myTeam.getTeamID()}, Integer.class);
				myTeam.setWins(wins);
				myTeam.setLosses(losses);
				myTeam.setTies(ties);
				league.setDivisionOpponents(divOpps);
				league.setNonDivisionOpponents(nonDivOpps);
				league.setMyTeam(myTeam);
				return league;
			}
		});
		return league;
	}

	@Override
	public Long insertNewLeague(Long teamID, List<Long> divisionOpponents, HashMap<Integer, List<BlitzballGame>> schedule) {
		if (jdbcTemplate==null){
			setDataSource(getDataSource());
		}
		Long lReturn=null;

		SimpleJdbcCall createGameFunc= new SimpleJdbcCall(this.getDataSource()).withFunctionName("CREATE_LEAGUE");
		createGameFunc.declareParameters(new SqlParameter("p_gameID", Types.NUMERIC),
				new SqlParameter("p_div_opp1", Types.NUMERIC),
				new SqlParameter("p_div_opp2", Types.NUMERIC),
				new SqlParameter("p_div_opp3", Types.NUMERIC));
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("p_gameID", teamID);
		params.put("p_div_opp1", divisionOpponents.get(0));
		params.put("p_div_opp2", divisionOpponents.get(1));
		params.put("p_div_opp3", divisionOpponents.get(2));
		
		SqlParameterSource in = new MapSqlParameterSource().addValues(params);
		Integer leagueID=createGameFunc.executeFunction(Integer.class, in);
		lReturn = new Long(leagueID);
		
		Iterator<Entry<Integer, List<BlitzballGame>>> it = schedule.entrySet().iterator();
		while (it.hasNext()){
			Entry<Integer, List<BlitzballGame>> e = it.next();
			Integer week = e.getKey();
			List<BlitzballGame> weekGames = e.getValue();
			for (BlitzballGame game : weekGames){
				jdbcTemplate.update("INSERT INTO BB_LEAGUE_GAMES(LEAGUE_ID, WEEK, TEAM_1, TEAM_2, HALVES_COMPLETE) VALUES(?,?,?,?,0)", new Object[]{lReturn, week, game.getTeam1().getTeamID(), game.getTeam2().getTeamID()});	
			}
		}
		
		return lReturn;
	}

	//TODO @Override
	public BlitzballTeam getLeagueOpponent(BlitzballLeague league) {
		if (jdbcTemplate==null){
			setDataSource(getDataSource());
		}
		BlitzballTeam opponent=null;
		opponent=jdbcTemplate.queryForObject("SELECT * FROM BB_TEAM WHERE TEAM_ID = (SELECT TEAM_2 FROM BB_LEAGUE_GAMES WHERE LEAGUE_ID=? AND TEAM_1=? AND WEEK=?)", new Object[]{league.getLeagueID(), league.getGameID(), (league.getWeeksComplete()+1)}, new RowMapper<BlitzballTeam>(){
			public BlitzballTeam mapRow(ResultSet rs, int rowNum) throws SQLException {
				BlitzballTeam team = new BlitzballTeam();
				team.setTeamID(rs.getLong("TEAM_ID"));
				String teamName=rs.getString("TEAM_NAME");
				team.setTeamName(teamName);

				team.setLeftWing(getPlayerByID(rs.getInt("LWING"), league.getGameID(), null));
				team.setRightWing(getPlayerByID(rs.getInt("RWING"), league.getGameID(), null));
				team.setMidfielder(getPlayerByID(rs.getInt("MID"), league.getGameID(), null));
				team.setLeftBack(getPlayerByID(rs.getInt("LBACK"), league.getGameID(), null));
				team.setRightBack(getPlayerByID(rs.getInt("RBACK"), league.getGameID(), null));
				team.setKeeper(getPlayerByID(rs.getInt("KEEPER"), league.getGameID(), null));
				team.getRightWing().setTeamName(teamName);
				team.getLeftWing().setTeamName(teamName);
				team.getMidfielder().setTeamName(teamName);
				team.getRightBack().setTeamName(teamName);
				team.getLeftBack().setTeamName(teamName);
				team.getKeeper().setTeamName(teamName);
				Long tempID=rs.getLong("BENCH1");
				if (tempID!=null&&tempID>0){
					team.setBench1(getPlayerByID(rs.getInt("BENCH1"), league.getGameID(), null));
					team.getBench1().setTeamName(teamName);
					tempID=rs.getLong("BENCH2");
					if (tempID!=null&&tempID>0){
						team.setBench2(getPlayerByID(rs.getInt("BENCH2"), league.getGameID(), null));
						team.getBench2().setTeamName(teamName);
					}
				}
				
				return team;
			}
		});
		return opponent;
	}

	@Override
	public HashMap<Integer, List<BlitzballGame>> getLeagueSchedule(BlitzballLeague league) {
		if (jdbcTemplate==null){
			setDataSource(getDataSource());
		}
		HashMap<Integer, List<BlitzballGame>> schedule = new HashMap<Integer, List<BlitzballGame>>();
		for (Integer i=1; i<=10; i++){
			List<BlitzballGame> weeksGames = jdbcTemplate.query("SELECT * FROM BB_LEAGUE_GAMES WHERE LEAGUE_ID=? AND WEEK=?", new Object[]{league.getLeagueID(), i}, new RowMapper<BlitzballGame>(){
				public BlitzballGame mapRow(ResultSet rs, int rowNum) throws SQLException {
					BlitzballGame game = new BlitzballGame();
					game.setLeagueGameID(rs.getLong("LEAGUE_GAME_ID"));
					Long team1ID=rs.getLong("TEAM_1");
					if (team1ID.equals(league.getMyTeam().getTeamID())){
						game.setTeam1(league.getMyTeam());
					} else {
						boolean found = false;
						for (BlitzballTeam team : league.getDivisionOpponents()){
							if (team1ID.equals(team.getTeamID())){
								found=true;
								game.setTeam1(team);
								break;
							}
						}
						if (!found){
							for (BlitzballTeam team : league.getNonDivisionOpponents()){
								if (team1ID.equals(team.getTeamID())){
									game.setTeam1(team);
									break;
								}
							}
						}
					}
					Long team2ID=rs.getLong("TEAM_2");
					if (team2ID.equals(league.getMyTeam().getTeamID())){
						game.setTeam2(league.getMyTeam());
					} else {
						boolean found = false;
						for (BlitzballTeam team : league.getDivisionOpponents()){
							if (team2ID.equals(team.getTeamID())){
								found=true;
								game.setTeam2(team);
								break;
							}
						}
						if (!found){
							for (BlitzballTeam team : league.getNonDivisionOpponents()){
								if (team2ID.equals(team.getTeamID())){
									game.setTeam2(team);
									break;
								}
							}
						}
					}
					game.setTeam1Score(rs.getInt("SCORE_1"));
					game.setTeam2Score(rs.getInt("SCORE_2"));
					game.setWeekNumber(rs.getInt("WEEK"));
					game.setHalvesComplete(rs.getInt("HALVES_COMPLETE"));
					game.setIsOvertimeGame(false);
					return game;
				}
			});
			schedule.put(i, weeksGames);
		}
		return schedule;
	}

	@Override
	public List<BlitzballPlayerStatistics> getLeaguePlayerStatistics(Long leagueID, Long gameID) {
		if (jdbcTemplate==null){
			setDataSource(getDataSource());
		}
		HashMap<Integer, BlitzballPlayerStatistics> map = new HashMap<Integer, BlitzballPlayerStatistics>();
		jdbcTemplate.query("SELECT * FROM BB_LEAGUE_GAME_STATS WHERE LEAGUE_GAME_ID IN (SELECT LEAGUE_GAME_ID FROM BB_LEAGUE_GAMES WHERE LEAGUE_ID=?)", new Object[]{leagueID}, new RowMapper<BlitzballPlayerStatistics>(){
			public BlitzballPlayerStatistics mapRow(ResultSet rs, int rowNum) throws SQLException {
				final Integer playerID=rs.getInt("PLAYER_ID");
				BlitzballPlayerStatistics stats = map.get(playerID);
				if (stats==null){
					stats = jdbcTemplate.queryForObject("SELECT NAME, MODEL FROM BB_PLAYERS WHERE PLAYER_ID=? AND GAME_ID=?", new Object[]{playerID, gameID}, new RowMapper<BlitzballPlayerStatistics>(){
						@Override
						public BlitzballPlayerStatistics mapRow(ResultSet rs, int rowNum) throws SQLException {
							BlitzballPlayerStatistics newStats = new BlitzballPlayerStatistics(playerID, rs.getString("NAME"), rs.getString("MODEL"));
							return newStats;
						}
						
					});
					map.put(playerID, stats);
				}
				stats.setGoals(stats.getGoals()+rs.getInt("GOALS"));
				stats.setShots(stats.getShots()+rs.getInt("SHOTS"));
				stats.setAssists(stats.getAssists()+rs.getInt("ASSISTS"));
				stats.setGoalsAgainst(stats.getGoalsAgainst()+rs.getInt("GOALS_AGAINST"));
				stats.setShotsAgainst(stats.getShotsAgainst()+rs.getInt("SHOTS_AGAINST"));
				stats.setTackles(stats.getTackles()+rs.getInt("TACKLES"));
				stats.setBlocks(stats.getBlocks()+rs.getInt("BLOCKS"));
				stats.setBreaks(stats.getBreaks()+rs.getInt("BREAKS"));
				stats.setTurnovers(stats.getTurnovers()+rs.getInt("TURNOVERS"));
				return stats;
			}			
		});
		
		List<BlitzballPlayerStatistics> list = new ArrayList<BlitzballPlayerStatistics>();
		Iterator<Entry<Integer, BlitzballPlayerStatistics>> it = map.entrySet().iterator();
		while (it.hasNext()){
			Entry<Integer, BlitzballPlayerStatistics> e = it.next();
			list.add(e.getValue());
		}
		return list;
	}
	
	public List<BlitzballTech> getFullBlitzballTechList(){
		if (jdbcTemplate==null){
			setDataSource(getDataSource());
		}
		List<BlitzballTech> list = jdbcTemplate.query("SELECT * FROM BB_TECHS", new RowMapper<BlitzballTech>(){
			public BlitzballTech mapRow(ResultSet rs, int rowNum) throws SQLException {
				BlitzballTech tech = new BlitzballTech();
				tech.setTechID(rs.getInt("TECH_ID"));
				tech.setTechName(rs.getString("TECH_NAME"));
				tech.setTechDescription(rs.getString("DESCRIPTION"));
				tech.setTechType(rs.getString("TECH_TYPE"));
				tech.setHpCost(rs.getInt("HP_COST"));
				tech.setStatMod(rs.getInt("STAT_MOD"));
				tech.setEffectChance(1.0);//TODO
				return tech;
			}
			
		});
		return list;
	}
	
	public HashMap<Integer, Integer> getExpLevelMilestones(){
		if (jdbcTemplate==null){
			setDataSource(getDataSource());
		}
		HashMap<Integer, Integer> expMap = new HashMap<Integer, Integer>();
		jdbcTemplate.query("SELECT * FROM BB_EXP_LVL_LOOKUP", new RowMapper<Void>(){
			public Void mapRow(ResultSet rs, int rowNum) throws SQLException {
				expMap.put(rs.getInt("LEVEL"), rs.getInt("EXP"));
				return null;
			}
			
		});
		return expMap;
	}
	
	public HashMap<Integer, Integer> getTeamLevelMilestones(){
		if (jdbcTemplate==null){
			setDataSource(getDataSource());
		}
		HashMap<Integer, Integer> teamExpMap = new HashMap<Integer, Integer>();
		jdbcTemplate.query("SELECT * FROM BB_TEAM_LVL_LOOKUP", new RowMapper<Void>(){
			public Void mapRow(ResultSet rs, int rowNum) throws SQLException {
				teamExpMap.put(rs.getInt("LEVEL"), rs.getInt("EXP"));
				return null;
			}
			
		});
		return teamExpMap;
	}
	
	public void saveLeagueGameInfo(BlitzballGame game, Long gameID){
		if (jdbcTemplate==null){
			setDataSource(getDataSource());
		}
		jdbcTemplate.update("UPDATE BB_LEAGUE_GAMES SET SCORE_1=?, SCORE_2=?, HALVES_COMPLETE=? WHERE LEAGUE_GAME_ID=?", new Object[]{game.getTeam1Score(), game.getTeam2Score(), game.getHalvesComplete(), game.getLeagueGameID()});
		for (BlitzballPlayerStatistics stats : game.getPlayerStatistics()){
			jdbcTemplate.update("UPDATE BB_PLAYERS P SET EXP=(EXP+?), LEVEL=((SELECT MAX(LEVEL) FROM BB_EXP_LVL_LOOKUP EL WHERE EL.EXP<=(P.EXP+?))) WHERE GAME_ID=? AND PLAYER_ID=?", new Object[]{stats.getExpGained(), stats.getExpGained(), gameID, stats.getPlayerID()});
			Integer count = jdbcTemplate.queryForObject("SELECT COUNT(*) FROM BB_LEAGUE_GAME_STATS WHERE LEAGUE_GAME_ID=? AND PLAYER_ID=?", new Object[]{game.getLeagueGameID(), stats.getPlayerID()}, Integer.class);
			if (count>0){
				jdbcTemplate.update("UPDATE BB_LEAGUE_GAME_STATS SET GOALS=?, SHOTS=?, ASSISTS=?, GOALS_AGAINST=?, SHOTS_AGAINST=?, TACKLES=?, BLOCKS=?, BREAKS=?, TURNOVERS=? WHERE LEAGUE_GAME_ID=? AND PLAYER_ID=?", new Object[]{stats.getGoals(), stats.getShots(), stats.getAssists(), stats.getGoalsAgainst(), stats.getShotsAgainst(), stats.getTackles(), stats.getBlocks(), stats.getBreaks(), stats.getTurnovers(), game.getLeagueGameID(), stats.getPlayerID()});
			} else {
				jdbcTemplate.update("INSERT INTO BB_LEAGUE_GAME_STATS (LEAGUE_GAME_ID, PLAYER_ID, GOALS, SHOTS, ASSISTS, GOALS_AGAINST, SHOTS_AGAINST, TACKLES, BLOCKS, BREAKS, TURNOVERS) VALUES(?,?,?,?,?,?,?,?,?,?,?)", new Object[]{game.getLeagueGameID(), stats.getPlayerID(), stats.getGoals(), stats.getShots(), stats.getAssists(), stats.getGoalsAgainst(), stats.getShotsAgainst(), stats.getTackles(), stats.getBlocks(), stats.getBreaks(), stats.getTurnovers()});
			}
			for (BlitzballTech tech : stats.getTechsLearned()){
				jdbcTemplate.update("DELETE FROM BB_PLAYER_TECHS WHERE GAME_ID=? AND PLAYER_ID=? AND TECH_ID=?", new Object[]{gameID, stats.getPlayerID(), tech.getTechID()});
				jdbcTemplate.update("INSERT INTO BB_PLAYER_TECHS (GAME_ID, PLAYER_ID, TECH_ID, LEARNED) VALUES (?, ?, ?, TRUE)", new Object[]{gameID, stats.getPlayerID(), tech.getTechID()});
			}
		}
	}
	
	public void advanceLeagueWeek(BlitzballLeague league){
		if (jdbcTemplate==null){
			setDataSource(getDataSource());
		}
		for (BlitzballGame game : league.getSchedule().get(league.getWeeksComplete())){
			saveLeagueGameInfo(game, league.getGameID());
		}
		jdbcTemplate.update("UPDATE BB_LEAGUE SET WEEKS_COMPLETE=? WHERE LEAGUE_ID=?", new Object[]{league.getWeeksComplete(), league.getLeagueID()});
	}
	
	public List<BlitzballPlayer> advancePlayerContracts(BlitzballInfo info, String teamIDString){
		if (jdbcTemplate==null){
			setDataSource(getDataSource());
		}
		jdbcTemplate.update("UPDATE BB_PLAYERS SET CONTRACT_LENGTH=(CONTRACT_LENGTH-1) WHERE GAME_ID=? AND CURR_TEAM IN ("+teamIDString+")", new Object[]{info.getTeam().getTeamID()});
		List<BlitzballPlayer> expiredList = jdbcTemplate.query("SELECT * FROM BB_PLAYERS P WHERE P.GAME_ID=? AND P.CONTRACT_LENGTH<=0 AND P.CURR_TEAM IN ("+teamIDString+")", new Object[]{info.getTeam().getTeamID()}, new RowMapper<BlitzballPlayer>(){
			public BlitzballPlayer mapRow(ResultSet rs, int rowNum) throws SQLException {
				BlitzballPlayer player = new BlitzballPlayer();
				player.setPlayerID(rs.getInt("PLAYER_ID"));
				player.setTeamID(rs.getLong("CURR_TEAM"));
				player.setName(rs.getString("NAME"));
				player.setLevel(rs.getInt("LEVEL"));
				player.setExperience(rs.getInt("EXP"));
				player.setNextExp(BlitzballUtils.getExpForLevel(player.getLevel()+1));
				player.setSpeed(rs.getInt("SPD"));
				player.setEndurance(rs.getInt("ENDUR"));
				player.setHp(rs.getInt("HP"));
				player.setAttack(rs.getInt("ATK"));
				player.setPass(rs.getInt("PASS"));
				player.setShot(rs.getInt("SHOT"));
				player.setBlock(rs.getInt("BLK"));
				player.setCat(rs.getInt("CAT"));
				player.setContractLength(rs.getInt("CONTRACT_LENGTH"));
				player.setSalary(rs.getInt("SALARY"));
				player.setTech1(BlitzballUtils.getTechFromTechID(rs.getInt("TECH1")));
				player.setTech2(BlitzballUtils.getTechFromTechID(rs.getInt("TECH2")));
				player.setTech3(BlitzballUtils.getTechFromTechID(rs.getInt("TECH3")));
				player.setTech4(BlitzballUtils.getTechFromTechID(rs.getInt("TECH4")));
				player.setTech5(BlitzballUtils.getTechFromTechID(rs.getInt("TECH5")));
				player.setKeyTech1(BlitzballUtils.getTechFromTechID(rs.getInt("KEYTECH1")));
				player.setKeyTech2(BlitzballUtils.getTechFromTechID(rs.getInt("KEYTECH2")));
				player.setKeyTech3(BlitzballUtils.getTechFromTechID(rs.getInt("KEYTECH3")));
				player.setLearnableTechs(jdbcTemplate.queryForList("SELECT TECH_ID FROM BB_PLAYER_TECHS WHERE GAME_ID=? AND PLAYER_ID=? AND LEARNED=FALSE", new Object[]{info.getTeam().getTeamID(), player.getPlayerID()}, Integer.class));
				player.setLearnedTechs(jdbcTemplate.queryForList("SELECT TECH_ID FROM BB_PLAYER_TECHS WHERE GAME_ID=? AND PLAYER_ID=? AND LEARNED=TRUE", new Object[]{info.getTeam().getTeamID(), player.getPlayerID()}, Integer.class));
				player.setModel(rs.getString("MODEL"));
				player.setTeamName(rs.getString("TEAM_NAME"));
				return player;
			}
		});
		return expiredList;
	}
	
	public BlitzballPlayer selectReplacementPlayer(BlitzballPlayer player, Long gameID){
		if (jdbcTemplate==null){
			setDataSource(getDataSource());
		}

		SimpleJdbcCall createGameFunc = new SimpleJdbcCall(this.getDataSource()).withFunctionName("SIGN_FREE_AGENT");
		createGameFunc.declareParameters(new SqlParameter("p_game_id", Types.NUMERIC), 
				new SqlParameter("p_replacing_id", Types.NUMERIC));
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("p_game_id", gameID);
		params.put("p_replacing_id", player.getPlayerID());
		
		SqlParameterSource in = new MapSqlParameterSource().addValues(params);
		Integer newPlayerID=createGameFunc.executeFunction(Integer.class, in);
		
		BlitzballPlayer newPlayer = jdbcTemplate.queryForObject("SELECT * FROM BB_PLAYERS P INNER JOIN BB_PLAYER_LVL_STATS PLS ON P.LEVEL=PLS.LEVEL AND P.PLAYER_ID=PLS.PLAYER_ID WHERE P.PLAYER_ID=? AND P.GAME_ID=?", new Object[]{newPlayerID, gameID}, new RowMapper<BlitzballPlayer>(){
			public BlitzballPlayer mapRow(ResultSet rs, int rowNum) throws SQLException {
				BlitzballPlayer player = new BlitzballPlayer();
				player.setPlayerID(rs.getInt("PLAYER_ID"));
				player.setTeamID(rs.getLong("CURR_TEAM"));
				player.setName(rs.getString("NAME"));
				player.setLevel(rs.getInt("LEVEL"));
				player.setExperience(rs.getInt("EXP"));
				player.setNextExp(BlitzballUtils.getExpForLevel(player.getLevel()+1));
				player.setSpeed(rs.getInt("SPD"));
				player.setEndurance(rs.getInt("ENDUR"));
				player.setHp(rs.getInt("HP"));
				player.setAttack(rs.getInt("ATK"));
				player.setPass(rs.getInt("PASS"));
				player.setShot(rs.getInt("SHOT"));
				player.setBlock(rs.getInt("BLK"));
				player.setCat(rs.getInt("CAT"));
				player.setContractLength(rs.getInt("CONTRACT_LENGTH"));
				player.setSalary(rs.getInt("SALARY"));
				player.setTech1(BlitzballUtils.getTechFromTechID(rs.getInt("TECH1")));
				player.setTech2(BlitzballUtils.getTechFromTechID(rs.getInt("TECH2")));
				player.setTech3(BlitzballUtils.getTechFromTechID(rs.getInt("TECH3")));
				player.setTech4(BlitzballUtils.getTechFromTechID(rs.getInt("TECH4")));
				player.setTech5(BlitzballUtils.getTechFromTechID(rs.getInt("TECH5")));
				player.setKeyTech1(BlitzballUtils.getTechFromTechID(rs.getInt("KEYTECH1")));
				player.setKeyTech2(BlitzballUtils.getTechFromTechID(rs.getInt("KEYTECH2")));
				player.setKeyTech3(BlitzballUtils.getTechFromTechID(rs.getInt("KEYTECH3")));
				player.setLearnableTechs(jdbcTemplate.queryForList("SELECT TECH_ID FROM BB_PLAYER_TECHS WHERE GAME_ID=? AND PLAYER_ID=? AND LEARNED=FALSE", new Object[]{gameID, player.getPlayerID()}, Integer.class));
				player.setLearnedTechs(jdbcTemplate.queryForList("SELECT TECH_ID FROM BB_PLAYER_TECHS WHERE GAME_ID=? AND PLAYER_ID=? AND LEARNED=TRUE", new Object[]{gameID, player.getPlayerID()}, Integer.class));
				player.setModel(rs.getString("MODEL"));
				return player;
			}
		});
		
		return newPlayer;
	}
	
	public void signPlayer(Integer playerID, Long gameID, Long signingTeamID, Integer extension, String position){
		if (jdbcTemplate==null){
			setDataSource(getDataSource());
		}
		jdbcTemplate.update("UPDATE BB_PLAYERS SET CONTRACT_LENGTH=(CONTRACT_LENGTH+?), CURR_TEAM=? WHERE GAME_ID=? AND PLAYER_ID=?", new Object[]{extension, signingTeamID, gameID, playerID});
		jdbcTemplate.update("UPDATE BB_TEAM SET " + position + " = ? WHERE GAME_ID=? AND TEAM_ID=?", new Object[]{gameID, signingTeamID});
	}
	
	public String getCurrentPositionByPlayerID(Long gameID, Integer playerID){
		if (jdbcTemplate==null){
			setDataSource(getDataSource());
		}
		Integer count = jdbcTemplate.queryForObject("SELECT COUNT(*) FROM BB_TEAM WHERE GAME_ID=? AND LW=?", new Object[]{gameID, playerID}, Integer.class);
		if (count>0){
			return "LW";
		}
		count = jdbcTemplate.queryForObject("SELECT COUNT(*) FROM BB_TEAM WHERE GAME_ID=? AND RW=?", new Object[]{gameID, playerID}, Integer.class);
		if (count>0){
			return "RW";
		}
		count = jdbcTemplate.queryForObject("SELECT COUNT(*) FROM BB_TEAM WHERE GAME_ID=? AND MF=?", new Object[]{gameID, playerID}, Integer.class);
		if (count>0){
			return "MF";
		}
		count = jdbcTemplate.queryForObject("SELECT COUNT(*) FROM BB_TEAM WHERE GAME_ID=? AND LB=?", new Object[]{gameID, playerID}, Integer.class);
		if (count>0){
			return "LB";
		}
		count = jdbcTemplate.queryForObject("SELECT COUNT(*) FROM BB_TEAM WHERE GAME_ID=? AND RB=?", new Object[]{gameID, playerID}, Integer.class);
		if (count>0){
			return "RB";
		}
		count = jdbcTemplate.queryForObject("SELECT COUNT(*) FROM BB_TEAM WHERE GAME_ID=? AND GK=?", new Object[]{gameID, playerID}, Integer.class);
		if (count>0){
			return "GK";
		}
		count = jdbcTemplate.queryForObject("SELECT COUNT(*) FROM BB_TEAM WHERE GAME_ID=? AND BENCH1=?", new Object[]{gameID, playerID}, Integer.class);
		if (count>0){
			return "BENCH1";
		}
		count = jdbcTemplate.queryForObject("SELECT COUNT(*) FROM BB_TEAM WHERE GAME_ID=? AND BENCH2=?", new Object[]{gameID, playerID}, Integer.class);
		if (count>0){
			return "BENCH2";
		}
		return null;
	}
	
	public List<BlitzballPlayer> getAllGamePlayers(Long gameID){
		if (jdbcTemplate==null){
			setDataSource(getDataSource());
		}
		return jdbcTemplate.query("SELECT * FROM BB_PLAYERS P INNER JOIN BB_PLAYER_LVL_STATS PLS ON P.LEVEL=PLS.LEVEL AND P.PLAYER_ID=PLS.PLAYER_ID WHERE P.GAME_ID=?" , new Long[]{gameID}, playerMapper);
	}
	
}