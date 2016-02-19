package site.dao;

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

import site.blitzball.BlitzballGame;
import site.blitzball.BlitzballInfo;
import site.blitzball.BlitzballLeague;
import site.blitzball.BlitzballPlayer;
import site.blitzball.BlitzballPlayerStatistics;
import site.blitzball.BlitzballTeam;
import site.blitzball.BlitzballTech;
import site.blitzball.BlitzballUtils;

public class BlitzballDaoImpl extends ParentDao implements BlitzballDao{

	@Override
	public BlitzballInfo getBlitzballByIdentifier(Long identifier) {
		if (jdbcTemplate==null){
			setDataSource(getDataSource());
		}
		BlitzballInfo info = jdbcTemplate.queryForObject("SELECT * FROM BB_INFO WHERE USER_ID=?", new Object[]{identifier}, new RowMapper<BlitzballInfo>(){
			public BlitzballInfo mapRow(ResultSet rs, int rowNum) throws SQLException {
				BlitzballInfo info = new BlitzballInfo();
				info.setUserID(identifier);
				info.setTotalWins(rs.getInt("WINS"));
				info.setTotalLosses(rs.getInt("LOSSES"));
				info.setTotalGoals(rs.getInt("GOALS"));
				info.setTotalGoalsAgainst(rs.getInt("GOALS_AGAINST"));
				final Integer teamID=rs.getInt("GAME_ID");
				
				RowMapper<BlitzballTeam> teamMapper = new RowMapper<BlitzballTeam>(){
					public BlitzballTeam mapRow(ResultSet rs, int rowNum) throws SQLException {
						BlitzballTeam myTeam=new BlitzballTeam();
						myTeam.setTeamID(rs.getLong("TEAM_ID"));
						myTeam.setTeamName(rs.getString("TEAM_NAME"));
						myTeam.setAvailableCash(rs.getInt("AVAILABLE_CASH"));
						final Long gameID=myTeam.getTeamID();

						RowMapper<BlitzballPlayer> playerMapper = new RowMapper<BlitzballPlayer>(){
							public BlitzballPlayer mapRow(ResultSet rs, int rowNum) throws SQLException {
								BlitzballPlayer player = new BlitzballPlayer();
								player.setPlayerID(rs.getInt("PLAYER_ID"));
								player.setTeamID(rs.getLong("CURR_TEAM"));
								player.setName(rs.getString("NAME"));
								player.setLevel(rs.getInt("LEVEL"));
								player.setNextExp(rs.getInt("NEXT_EXP"));
								player.setSpeed(rs.getInt("SPD"));
								player.setEndurance(rs.getInt("ENDUR"));
								player.setHp(rs.getInt("HP"));
								player.setAttack(rs.getInt("ATK"));
								player.setPass(rs.getInt("PASS"));
								player.setShot(rs.getInt("SHOT"));
								player.setBlock(rs.getInt("BLK"));
								player.setCat(rs.getInt("CAT"));
								player.setSalary(rs.getInt("SALARY"));
								player.setContractLength(rs.getInt("CONTRACT_LENGTH"));
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
						};
						myTeam.setRightWing(jdbcTemplate.queryForObject("SELECT * FROM BB_PLAYERS WHERE PLAYER_ID=? AND GAME_ID=?" , new Object[]{rs.getLong("RWING"), teamID}, playerMapper));
						myTeam.setLeftWing(jdbcTemplate.queryForObject("SELECT * FROM BB_PLAYERS WHERE PLAYER_ID=? AND GAME_ID=?" , new Object[]{rs.getLong("LWING"), teamID}, playerMapper));
						myTeam.setMidfielder(jdbcTemplate.queryForObject("SELECT * FROM BB_PLAYERS WHERE PLAYER_ID=? AND GAME_ID=?" , new Object[]{rs.getLong("MID"), teamID}, playerMapper));
						myTeam.setRightBack(jdbcTemplate.queryForObject("SELECT * FROM BB_PLAYERS WHERE PLAYER_ID=? AND GAME_ID=?" , new Object[]{rs.getLong("RBACK"), teamID}, playerMapper));
						myTeam.setLeftBack(jdbcTemplate.queryForObject("SELECT * FROM BB_PLAYERS WHERE PLAYER_ID=? AND GAME_ID=?" , new Object[]{rs.getLong("LBACK"), teamID}, playerMapper));
						myTeam.setKeeper(jdbcTemplate.queryForObject("SELECT * FROM BB_PLAYERS WHERE PLAYER_ID=? AND GAME_ID=?" , new Object[]{rs.getLong("KEEPER"), teamID}, playerMapper));
						
						Long tempID=rs.getLong("BENCH1");
						if (tempID!=null&&tempID>0){
							myTeam.setBench1(jdbcTemplate.queryForObject("SELECT * FROM BB_PLAYERS WHERE PLAYER_ID=? AND GAME_ID=?" , new Object[]{rs.getLong("BENCH1"), teamID}, playerMapper));
							tempID=rs.getLong("BENCH2");
							if (tempID!=null&&tempID>0){
								myTeam.setBench1(jdbcTemplate.queryForObject("SELECT * FROM BB_PLAYERS WHERE PLAYER_ID=? AND GAME_ID=?" , new Object[]{rs.getLong("BENCH2"), teamID}, playerMapper));
							}
						}
						return myTeam;
					}
					
				};
				BlitzballTeam myTeam = jdbcTemplate.queryForObject("SELECT * FROM BB_TEAM WHERE TEAM_ID=?", new Object[]{teamID}, teamMapper);
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
	
	public void deleteBlitzballGameInfo(Long gameID){
		if (jdbcTemplate==null){
			setDataSource(getDataSource());
		}
		
		jdbcTemplate.update("DELETE FROM BB_LEAGUE_GAME_STATS WHERE LEAGUE_GAME_ID IN (SELECT LEAGUE_GAME_ID FROM BB_LEAGUE_GAMES WHERE LEAGUE_ID IN (SELECT LEAGUE_ID FROM BB_LEAGUE WHERE GAME_ID=?))", new Object[]{gameID});
		jdbcTemplate.update("DELETE FROM BB_LEAGUE_GAMES WHERE LEAGUE_ID IN (SELECT LEAGUE_ID FROM BB_LEAGUE WHERE GAME_ID=?)", new Object[]{gameID});
		jdbcTemplate.update("DELETE FROM BB_LEAGUE WHERE GAME_ID=?", new Object[]{gameID});
		jdbcTemplate.update("DELETE FROM BB_PLAYER_TECHS WHERE GAME_ID=?", new Object[]{gameID});
		jdbcTemplate.update("DELETE FROM BB_PLAYERS WHERE GAME_ID=?", new Object[]{gameID});
		jdbcTemplate.update("DELETE FROM BB_TEAM WHERE GAME_ID=?", new Object[]{gameID});
		jdbcTemplate.update("DELETE FROM BB_INFO WHERE GAME_ID=?", new Object[]{gameID});
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
		KeyHolder keyHolder = new GeneratedKeyHolder();
		jdbcTemplate.update(
		    new PreparedStatementCreator() {
		        public PreparedStatement createPreparedStatement(Connection connection) throws SQLException {
		            PreparedStatement ps =
		                connection.prepareStatement("INSERT INTO BB_LEAGUE(LEAGUE_ID, GAME_ID, WEEKS_COMPLETE, DIV_OPP1, DIV_OPP2, DIV_OPP3) VALUES (NULL, ?, 0, ?, ?, ?)", Statement.RETURN_GENERATED_KEYS);
		            ps.setLong(1, teamID);
		            ps.setLong(2, divisionOpponents.get(0));
		            ps.setLong(3, divisionOpponents.get(1));
		            ps.setLong(4, divisionOpponents.get(2));
		            return ps;
		        }
		    },
		    keyHolder);
		lReturn=(Long) keyHolder.getKey();
		
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
				team.setTeamName(rs.getString("TEAM_NAME"));
				RowMapper<BlitzballPlayer> playerMapper = new RowMapper<BlitzballPlayer>(){
					public BlitzballPlayer mapRow(ResultSet rs, int rowNum) throws SQLException {
						BlitzballPlayer player = new BlitzballPlayer();
						player.setPlayerID(rs.getInt("PLAYER_ID"));
						player.setTeamID(rs.getLong("CURR_TEAM"));
						player.setName(rs.getString("NAME"));
						player.setLevel(rs.getInt("LEVEL"));
						player.setNextExp(rs.getInt("NEXT_EXP"));
						player.setSpeed(rs.getInt("SPD"));
						player.setEndurance(rs.getInt("ENDUR"));
						player.setHp(rs.getInt("HP"));
						player.setAttack(rs.getInt("ATK"));
						player.setPass(rs.getInt("PASS"));
						player.setShot(rs.getInt("SHOT"));
						player.setBlock(rs.getInt("BLK"));
						player.setCat(rs.getInt("CAT"));
						player.setSalary(rs.getInt("SALARY"));
						player.setContractLength(rs.getInt("CONTRACT_LENGTH"));
						player.setTech1(BlitzballUtils.getTechFromTechID(rs.getInt("TECH1")));
						player.setTech2(BlitzballUtils.getTechFromTechID(rs.getInt("TECH2")));
						player.setTech3(BlitzballUtils.getTechFromTechID(rs.getInt("TECH3")));
						player.setTech4(BlitzballUtils.getTechFromTechID(rs.getInt("TECH4")));
						player.setTech5(BlitzballUtils.getTechFromTechID(rs.getInt("TECH5")));
						player.setKeyTech1(BlitzballUtils.getTechFromTechID(rs.getInt("KEYTECH1")));
						player.setKeyTech2(BlitzballUtils.getTechFromTechID(rs.getInt("KEYTECH2")));
						player.setKeyTech3(BlitzballUtils.getTechFromTechID(rs.getInt("KEYTECH3")));
						player.setLearnableTechs(jdbcTemplate.queryForList("SELECT TECH_ID FROM BB_PLAYER_TECHS WHERE GAME_ID=? AND PLAYER_ID=? AND LEARNED=FALSE", new Object[]{league.getGameID(), player.getPlayerID()}, Integer.class));
						player.setLearnedTechs(jdbcTemplate.queryForList("SELECT TECH_ID FROM BB_PLAYER_TECHS WHERE GAME_ID=? AND PLAYER_ID=? AND LEARNED=TRUE", new Object[]{league.getGameID(), player.getPlayerID()}, Integer.class));
						player.setModel(rs.getString("MODEL"));
						return player;
					}
				};
				team.setRightWing(jdbcTemplate.queryForObject("SELECT * FROM BB_PLAYERS WHERE PLAYER_ID=? AND GAME_ID=?" , new Object[]{rs.getLong("RWING"), league.getGameID()}, playerMapper));
				team.setLeftWing(jdbcTemplate.queryForObject("SELECT * FROM BB_PLAYERS WHERE PLAYER_ID=? AND GAME_ID=?" , new Object[]{rs.getLong("LWING"), league.getGameID()}, playerMapper));
				team.setMidfielder(jdbcTemplate.queryForObject("SELECT * FROM BB_PLAYERS WHERE PLAYER_ID=? AND GAME_ID=?" , new Object[]{rs.getLong("MID"), league.getGameID()}, playerMapper));
				team.setRightBack(jdbcTemplate.queryForObject("SELECT * FROM BB_PLAYERS WHERE PLAYER_ID=? AND GAME_ID=?" , new Object[]{rs.getLong("RBACK"), league.getGameID()}, playerMapper));
				team.setLeftBack(jdbcTemplate.queryForObject("SELECT * FROM BB_PLAYERS WHERE PLAYER_ID=? AND GAME_ID=?" , new Object[]{rs.getLong("LBACK"), league.getGameID()}, playerMapper));
				team.setKeeper(jdbcTemplate.queryForObject("SELECT * FROM BB_PLAYERS WHERE PLAYER_ID=? AND GAME_ID=?" , new Object[]{rs.getLong("KEEPER"), league.getGameID()}, playerMapper));
				Long tempID=rs.getLong("BENCH1");
				if (tempID!=null&&tempID>0){
					team.setBench1(jdbcTemplate.queryForObject("SELECT * FROM BB_PLAYERS WHERE PLAYER_ID=? AND GAME_ID=?" , new Object[]{rs.getLong("BENCH1"), league.getGameID()}, playerMapper));
					tempID=rs.getLong("BENCH2");
					if (tempID!=null&&tempID>0){
						team.setBench1(jdbcTemplate.queryForObject("SELECT * FROM BB_PLAYERS WHERE PLAYER_ID=? AND GAME_ID=?" , new Object[]{rs.getLong("BENCH2"), league.getGameID()}, playerMapper));
					}
				}
				
				return team;
			}
		});
		return opponent;
	}

	@Override
	public HashMap<Integer, List<BlitzballGame>> getLeagueSchedule(Long leagueID) {
		if (jdbcTemplate==null){
			setDataSource(getDataSource());
		}
		HashMap<Integer, List<BlitzballGame>> schedule = new HashMap<Integer, List<BlitzballGame>>();
		for (Integer i=1; i<=10; i++){
			List<BlitzballGame> weeksGames = jdbcTemplate.query("SELECT * FROM BB_LEAGUE_GAMES WHERE LEAGUE_ID=? AND WEEK=?", new Object[]{leagueID, i}, new RowMapper<BlitzballGame>(){
				public BlitzballGame mapRow(ResultSet rs, int rowNum) throws SQLException {
					BlitzballGame game = new BlitzballGame();
					game.setLeagueGameID(rs.getLong("LEAGUE_GAME_ID"));
					BlitzballTeam team1= new BlitzballTeam(rs.getLong("TEAM_1"));
					team1.setTeamName(jdbcTemplate.queryForObject("SELECT TEAM_NAME FROM BB_TEAM WHERE TEAM_ID=?", new Object[]{team1.getTeamID()}, String.class));
					BlitzballTeam team2= new BlitzballTeam(rs.getLong("TEAM_2"));
					team2.setTeamName(jdbcTemplate.queryForObject("SELECT TEAM_NAME FROM BB_TEAM WHERE TEAM_ID=?", new Object[]{team2.getTeamID()}, String.class));
					game.setTeam1(team1);
					game.setTeam2(team2);
					game.setTeam1Score(rs.getInt("SCORE_1"));
					game.setTeam2Score(rs.getInt("SCORE_2"));
					game.setWeekNumber(rs.getInt("WEEK"));
					game.setHalvesComplete(rs.getInt("HALVES_COMPLETE"));
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
				Integer playerID=rs.getInt("PLAYER_ID");
				BlitzballPlayerStatistics stats = map.get(playerID);
				if (stats==null){
					String playerName = jdbcTemplate.queryForObject("SELECT NAME FROM BB_PLAYERS WHERE PLAYER_ID=? AND GAME_ID=?", new Object[]{playerID, gameID}, String.class);
					stats = new BlitzballPlayerStatistics(playerID, playerName);
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
				tech.setAnimation(rs.getString("ANIMATION"));
				return tech;
			}
			
		});
		return list;
	}
	
	public void saveLeagueGameInfo(BlitzballGame game){
		if (jdbcTemplate==null){
			setDataSource(getDataSource());
		}
		jdbcTemplate.update("UPDATE BB_LEAGUE_GAMES SET SCORE_1=?, SCORE_2=?, HALVES_COMPLETE=? WHERE LEAGUE_GAME_ID=?", new Object[]{game.getTeam1Score(), game.getTeam2Score(), game.getHalvesComplete(), game.getLeagueGameID()});
	}
	
	public void advanceLeagueWeek(BlitzballLeague league){
		if (jdbcTemplate==null){
			setDataSource(getDataSource());
		}
		for (BlitzballGame game : league.getSchedule().get(league.getWeeksComplete())){
			jdbcTemplate.update("UPDATE BB_LEAGUE_GAMES SET SCORE_1=?, SCORE_2=?, HALVES_COMPLETE=? WHERE LEAGUE_GAME_ID=?", new Object[]{game.getTeam1Score(), game.getTeam2Score(), game.getHalvesComplete(), game.getLeagueGameID()});
			for (BlitzballPlayerStatistics stats : game.getPlayerStatistics()){
				Integer count = jdbcTemplate.queryForObject("SELECT COUNT(*) FROM BB_LEAGUE_GAME_STATS WHERE LEAGUE_GAME_ID=? AND PLAYER_ID=?", new Object[]{game.getLeagueGameID(), stats.getPlayerID()}, Integer.class);
				if (count>0){
					jdbcTemplate.update("UPDATE BB_LEAGUE_GAME_STATS SET GOALS=?, SHOTS=?, ASSISTS=?, GOALS_AGAINST=?, SHOTS_AGAINST=?, TACKLES=?, BLOCKS=?, BREAKS=?, TURNOVERS=? WHERE LEAGUE_GAME_ID=? AND PLAYER_ID=?", new Object[]{stats.getGoals(), stats.getShots(), stats.getAssists(), stats.getGoalsAgainst(), stats.getShotsAgainst(), stats.getTackles(), stats.getBlocks(), stats.getBreaks(), stats.getTurnovers(), game.getLeagueGameID(), stats.getPlayerID()});
				} else {
					jdbcTemplate.update("INSERT INTO BB_LEAGUE_GAME_STATS (LEAGUE_GAME_ID, PLAYER_ID, GOALS, SHOTS, ASSISTS, GOALS_AGAINST, SHOTS_AGAINST, TACKLES, BLOCKS, BREAKS, TURNOVERS) VALUES(?,?,?,?,?,?,?,?,?,?,?)", new Object[]{game.getLeagueGameID(), stats.getPlayerID(), stats.getGoals(), stats.getShots(), stats.getAssists(), stats.getGoalsAgainst(), stats.getShotsAgainst(), stats.getTackles(), stats.getBlocks(), stats.getBreaks(), stats.getTurnovers()});
				}
				for (Integer i : stats.getTechsLearned()){
					jdbcTemplate.update("DELETE FROM BB_PLAYER_TECHS WHERE GAME_ID=? AND PLAYER_ID=? AND TECH_ID=?", new Object[]{league.getGameID(), stats.getPlayerID(), i});
					jdbcTemplate.update("INSERT INTO BB_PLAYER_TECHS (GAME_ID, PLAYER_ID, TECH_ID, LEARNED) VALUES (?, ?, ?, TRUE)", new Object[]{league.getGameID(), stats.getPlayerID(), i});
				}
			}
		}
		jdbcTemplate.update("UPDATE BB_LEAGUE SET WEEKS_COMPLETE=? WHERE LEAGUE_ID=?", new Object[]{league.getWeeksComplete(), league.getLeagueID()});
	}
	
	public List<BlitzballPlayer> advancePlayerContracts(BlitzballInfo info, String teamIDString){
		if (jdbcTemplate==null){
			setDataSource(getDataSource());
		}
		jdbcTemplate.update("UPDATE BB_PLAYERS SET CONTRACT_LENGTH=(CONTRACT_LENGTH-1) WHERE GAME_ID=? AND CURR_TEAM IN ("+teamIDString+")", new Object[]{info.getTeam().getTeamID()});
		List<BlitzballPlayer> expiredList = jdbcTemplate.query("SELECT * FROM BB_PLAYERS WHERE GAME_ID=? AND CONTRACT_LENGTH<=0 AND CURR_TEAM IN (?)", new Object[]{info.getTeam().getTeamID(), teamIDString}, new RowMapper<BlitzballPlayer>(){
			public BlitzballPlayer mapRow(ResultSet rs, int rowNum) throws SQLException {
				BlitzballPlayer player = new BlitzballPlayer();
				player.setPlayerID(rs.getInt("PLAYER_ID"));
				player.setTeamID(rs.getLong("CURR_TEAM"));
				player.setName(rs.getString("NAME"));
				player.setLevel(rs.getInt("LEVEL"));
				player.setNextExp(rs.getInt("NEXT_EXP"));
				player.setSpeed(rs.getInt("SPD"));
				player.setEndurance(rs.getInt("ENDUR"));
				player.setHp(rs.getInt("HP"));
				player.setAttack(rs.getInt("ATK"));
				player.setPass(rs.getInt("PASS"));
				player.setShot(rs.getInt("SHOT"));
				player.setBlock(rs.getInt("BLK"));
				player.setCat(rs.getInt("CAT"));
				player.setSalary(rs.getInt("SALARY"));
				player.setContractLength(rs.getInt("CONTRACT_LENGTH"));
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
				return player;
			}
		});
		return expiredList;
	}
	
}