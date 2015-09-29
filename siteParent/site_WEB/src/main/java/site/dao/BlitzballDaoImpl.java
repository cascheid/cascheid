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
				Integer teamID=rs.getInt("GAME_ID");
				List<Long> oppIDs = new ArrayList<Long>();
				oppIDs.add(rs.getLong("OPPONENT_1"));
				oppIDs.add(rs.getLong("OPPONENT_2"));
				oppIDs.add(rs.getLong("OPPONENT_3"));
				oppIDs.add(rs.getLong("OPPONENT_4"));
				oppIDs.add(rs.getLong("OPPONENT_5"));
				oppIDs.add(rs.getLong("OPPONENT_6"));
				oppIDs.add(rs.getLong("OPPONENT_7"));
				info.setOpponentIDs(oppIDs);
				BlitzballTeam myTeam = jdbcTemplate.queryForObject("SELECT * FROM BB_TEAM WHERE TEAM_ID=?", new Object[]{teamID}, new RowMapper<BlitzballTeam>(){
					public BlitzballTeam mapRow(ResultSet rs, int rowNum) throws SQLException {
						BlitzballTeam myTeam=new BlitzballTeam();
						myTeam.setTeamID(rs.getLong("TEAM_ID"));
						myTeam.setTeamName(rs.getString("TEAM_NAME"));
						myTeam.setAvailableCash(rs.getInt("AVAILABLE_CASH"));
						

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
								return player;
							}
						};
						myTeam.setRightWing(jdbcTemplate.queryForObject("SELECT * FROM BB_PLAYERS WHERE PLAYER_ID=?" , new Object[]{rs.getLong("RWING")}, playerMapper));
						myTeam.setLeftWing(jdbcTemplate.queryForObject("SELECT * FROM BB_PLAYERS WHERE PLAYER_ID=?" , new Object[]{rs.getLong("LWING")}, playerMapper));
						myTeam.setMidfielder(jdbcTemplate.queryForObject("SELECT * FROM BB_PLAYERS WHERE PLAYER_ID=?" , new Object[]{rs.getLong("MID")}, playerMapper));
						myTeam.setRightBack(jdbcTemplate.queryForObject("SELECT * FROM BB_PLAYERS WHERE PLAYER_ID=?" , new Object[]{rs.getLong("RBACK")}, playerMapper));
						myTeam.setLeftBack(jdbcTemplate.queryForObject("SELECT * FROM BB_PLAYERS WHERE PLAYER_ID=?" , new Object[]{rs.getLong("LBACK")}, playerMapper));
						myTeam.setKeeper(jdbcTemplate.queryForObject("SELECT * FROM BB_PLAYERS WHERE PLAYER_ID=?" , new Object[]{rs.getLong("KEEPER")}, playerMapper));
						
						Long tempID=rs.getLong("BENCH1");
						if (tempID!=null&&tempID>0){
							myTeam.setBench1(jdbcTemplate.queryForObject("SELECT * FROM BB_PLAYERS WHERE PLAYER_ID=?" , new Object[]{rs.getLong("BENCH1")}, playerMapper));
							tempID=rs.getLong("BENCH2");
							if (tempID!=null&&tempID>0){
								myTeam.setBench1(jdbcTemplate.queryForObject("SELECT * FROM BB_PLAYERS WHERE PLAYER_ID=?" , new Object[]{rs.getLong("BENCH2")}, playerMapper));
							}
						}
						return myTeam;
					}
					
				});
				info.setTeam(myTeam);
				return info;
			}
		});
		return info;
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
	public BlitzballLeague getActiveLeagueByTeamID(Long gameID) {
		if (jdbcTemplate==null){
			setDataSource(getDataSource());
		}
		BlitzballLeague league = jdbcTemplate.queryForObject("SELECT * FROM BB_LEAGUE WHERE GAME_ID=? AND WEEKS_COMPLETE<10", new Object[]{gameID}, new RowMapper<BlitzballLeague>(){
			public BlitzballLeague mapRow(ResultSet rs, int rowNum) throws SQLException {
				BlitzballLeague league = new BlitzballLeague();
				league.setLeagueID(rs.getLong("LEAGUE_ID"));
				league.setGameID(rs.getLong("GAME_ID"));
				league.setWeeksComplete(rs.getInt("WEEKS_COMPLETE"));
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
				jdbcTemplate.update("INSERT INTO BB_LEAGUE_GAMES(LEAGUE_ID, WEEK, TEAM_1, TEAM_2) VALUES(?,?,?,?)", new Object[]{lReturn, week, game.getTeam1().getTeamID(), game.getTeam2().getTeamID()});	
			}
		}
		
		return lReturn;
	}
	
	@Override
	public List<BlitzballTeam> getDivisionsOpponents(Long leagueID){
		if (jdbcTemplate==null){
			setDataSource(getDataSource());
		}
		List<BlitzballTeam> divisionInfo = jdbcTemplate.query("SELECT T.TEAM_ID, T.TEAM_NAME FROM BB_TEAM T INNER JOIN BB_LEAGUE L WHERE L.LEAGUE_ID=? AND (T.TEAM_ID=L.DIV_OPP1 OR T.TEAM_ID=L.DIV_OPP2 OR T.TEAM_ID=L.DIV_OPP3)", new Object[]{leagueID}, new RowMapper<BlitzballTeam>(){
			public BlitzballTeam mapRow(ResultSet rs, int rowNum) throws SQLException {
				BlitzballTeam team = new BlitzballTeam(rs.getLong("TEAM_ID"));
				team.setTeamName(rs.getString("TEAM_NAME"));
				return team;
			}
		});
		return divisionInfo;
	}

	@Override
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
						return player;
					}
				};
				team.setRightWing(jdbcTemplate.queryForObject("SELECT * FROM BB_PLAYERS WHERE PLAYER_ID=?" , new Object[]{rs.getLong("RWING")}, playerMapper));
				team.setLeftWing(jdbcTemplate.queryForObject("SELECT * FROM BB_PLAYERS WHERE PLAYER_ID=?" , new Object[]{rs.getLong("LWING")}, playerMapper));
				team.setMidfielder(jdbcTemplate.queryForObject("SELECT * FROM BB_PLAYERS WHERE PLAYER_ID=?" , new Object[]{rs.getLong("MID")}, playerMapper));
				team.setRightBack(jdbcTemplate.queryForObject("SELECT * FROM BB_PLAYERS WHERE PLAYER_ID=?" , new Object[]{rs.getLong("RBACK")}, playerMapper));
				team.setLeftBack(jdbcTemplate.queryForObject("SELECT * FROM BB_PLAYERS WHERE PLAYER_ID=?" , new Object[]{rs.getLong("LBACK")}, playerMapper));
				team.setKeeper(jdbcTemplate.queryForObject("SELECT * FROM BB_PLAYERS WHERE PLAYER_ID=?" , new Object[]{rs.getLong("KEEPER")}, playerMapper));
				Long tempID=rs.getLong("BENCH1");
				if (tempID!=null&&tempID>0){
					team.setBench1(jdbcTemplate.queryForObject("SELECT * FROM BB_PLAYERS WHERE PLAYER_ID=?" , new Object[]{rs.getLong("BENCH1")}, playerMapper));
					tempID=rs.getLong("BENCH2");
					if (tempID!=null&&tempID>0){
						team.setBench1(jdbcTemplate.queryForObject("SELECT * FROM BB_PLAYERS WHERE PLAYER_ID=?" , new Object[]{rs.getLong("BENCH2")}, playerMapper));
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
					// TODO game.setTeam1(rs.getLong("TEAM_1"));
					//game.setTeam2(rs.getLong("TEAM_1"));
					game.setTeam1Score(rs.getInt("SCORE_1"));
					game.setTeam2Score(rs.getInt("SCORE_2"));
					game.setWeekNumber(rs.getInt("WEEK"));
					return game;
				}
			});
			schedule.put(i, weeksGames);
		}
		return schedule;
	}

	@Override
	public List<BlitzballPlayerStatistics> getLeaguePlayerStatistics(Long leagueID) {
		if (jdbcTemplate==null){
			setDataSource(getDataSource());
		}
		HashMap<Long, BlitzballPlayerStatistics> map = new HashMap<Long, BlitzballPlayerStatistics>();
		jdbcTemplate.query("SELECT DISTINCT T.PLAYER_ID, (SELECT SUM(GOALS) FROM BB_LEAGUE_GAME_STATS WHERE PLAYER_ID=T.PLAYER_ID) AS GOALS FROM BB_LEAGUE_GAME_STATS T WHERE LEAGUE_GAME_ID IN (SELECT LEAGUE_GAME_ID FROM BB_LEAGUE_GAMES WHERE LEAGUE_ID=?)", new Object[]{leagueID}, new RowMapper<BlitzballPlayerStatistics>(){
			public BlitzballPlayerStatistics mapRow(ResultSet rs, int rowNum) throws SQLException {
				Long playerID=rs.getLong("PLAYER_ID");
				BlitzballPlayerStatistics stats = map.get(playerID);
				if (stats==null){
					stats = new BlitzballPlayerStatistics(playerID);
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
		Iterator<Entry<Long, BlitzballPlayerStatistics>> it = map.entrySet().iterator();
		while (it.hasNext()){
			Entry<Long, BlitzballPlayerStatistics> e = it.next();
			list.add(e.getValue());
		}
		return list;
	}
	
}