package site.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.List;

import org.springframework.jdbc.core.PreparedStatementCreator;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.stereotype.Repository;

import site.battleship.BattleshipBoard;
import site.battleship.BattleshipGame;
import site.battleship.BattleshipMove;

@Repository
public class BattleshipDaoImpl extends ParentDao implements BattleshipDao{

	@Override
	public List<BattleshipGame> getBattleshipGameList(Long identifier) {
		if (jdbcTemplate==null){
			setDataSource(getDataSource());
		}
		List<BattleshipGame> gameList = jdbcTemplate.query("SELECT * FROM BATTLESHIP_GAME WHERE USER1=? OR USER2=?", new Object[]{identifier, identifier}, new RowMapper<BattleshipGame>(){
			public BattleshipGame mapRow(ResultSet rs, int rowNum)	throws SQLException {
				BattleshipGame game = new BattleshipGame();
				game.setGameID(rs.getLong("GAME_ID"));
				game.setStatus(rs.getString("STATUS"));
				game.setUser1(rs.getLong("USER1"));
				game.setUser2(rs.getLong("USER2"));
				return game;
			}
		});
		return gameList;
	}
	
	public Long insertNewBattleshipGame(BattleshipGame game) {
		if (jdbcTemplate==null){
			setDataSource(getDataSource());
		}
		Long lReturn=null;
		KeyHolder keyHolder = new GeneratedKeyHolder();
		jdbcTemplate.update(
		    new PreparedStatementCreator() {
		        public PreparedStatement createPreparedStatement(Connection connection) throws SQLException {
		            PreparedStatement ps =
		                connection.prepareStatement("INSERT INTO BATTLESHIP_GAME(GAME_ID, USER1, USER2) VALUES (NULL, ?, ?)", Statement.RETURN_GENERATED_KEYS);
		            ps.setLong(1, game.getUser1());
		            ps.setLong(2, game.getUser2());
		            return ps;
		        }
		    },
		    keyHolder);
		lReturn=(Long) keyHolder.getKey();
		game.setGameID(lReturn);
		return lReturn;
	}
	
	public void insertBattleshipBoard(Long gameID, Long identifier, BattleshipBoard board){
		if (jdbcTemplate==null){
			setDataSource(getDataSource());
		}
		jdbcTemplate.update("INSERT INTO BATTLESHIP_BOARD(GAME_ID, IDENTIFIER, CARRIER_LOC, CARRIER_VERT, BATTLESHIP_LOC, BATTLESHIP_VERT, DESTROYER_LOC, DESTROYER_VERT, SUBMARINE_LOC, SUBMARINE_VERT, PATROL_LOC, PATROL_VERT) VALUES(?,?,?,?,?,?,?,?,?,?,?,?)", new Object[]{gameID, identifier, board.getCarrierLoc(), board.getCarrierVertical(), board.getBattleshipLoc(), board.getBattleshipVertical(), board.getDestroyerLoc(), board.getDestroyerVertical(), board.getSubmarineLoc(), board.getSubmarineVertical(), board.getPatrolLoc(), board.getPatrolVertical()});
	}
	
	public void insertBattleshipMove(Long gameID, BattleshipMove mv){
		if (jdbcTemplate==null){
			setDataSource(getDataSource());
		}
		jdbcTemplate.update("INSERT INTO BATTLESHIP_MOVES(GAME_ID, IDENTIFIER, LOC, STATUS) VALUES(?,?,?,?)", new Object[]{gameID, mv.getUserID(), mv.getLoc(), mv.getStatus()});
	}
	
	public void updateBattleshipGame(Long gameID, String status){
		if (jdbcTemplate==null){
			setDataSource(getDataSource());
		}
		jdbcTemplate.update("UPDATE BATTLESHIP_GAME SET STATUS=? WHERE GAME_ID=?", new Object[]{status, gameID});
	}

	@Override
	public BattleshipGame getBattleshipGameByID(Long gameID) {
		if (jdbcTemplate==null){
			setDataSource(getDataSource());
		}
		BattleshipGame game= jdbcTemplate.queryForObject("SELECT * FROM BATTLESHIP_GAME WHERE GAME_ID=?", new Object[]{gameID}, new RowMapper<BattleshipGame>(){
			public BattleshipGame mapRow(ResultSet rs, int rowNum)	throws SQLException {
				BattleshipGame game = new BattleshipGame();
				game.setGameID(rs.getLong("GAME_ID"));
				game.setStatus(rs.getString("STATUS"));
				game.setUser1(rs.getLong("USER1"));
				game.setUser2(rs.getLong("USER2"));
				return game;
			}
		});
		return game;
	}

	@Override
	public BattleshipBoard getBattleshipBoard(Long gameID, Long identifier) {
		if (jdbcTemplate==null){
			setDataSource(getDataSource());
		}
		BattleshipBoard board= jdbcTemplate.queryForObject("SELECT * FROM BATTLESHIP_BOARD WHERE GAME_ID=? AND IDENTIFIER=?", new Object[]{gameID, identifier}, new RowMapper<BattleshipBoard>(){
			public BattleshipBoard mapRow(ResultSet rs, int rowNum)	throws SQLException {
				BattleshipBoard board = new BattleshipBoard();
				board.setCarrierLoc(rs.getString("CARRIER_LOC"));
				board.setCarrierVertical(rs.getBoolean("CARRIER_VERT"));
				board.setBattleshipLoc(rs.getString("BATTLESHIP_LOC"));
				board.setBattleshipVertical(rs.getBoolean("BATTLESHIP_VERT"));
				board.setDestroyerLoc(rs.getString("DESTROYER_LOC"));
				board.setDestroyerVertical(rs.getBoolean("DESTROYER_VERT"));
				board.setSubmarineLoc(rs.getString("SUBMARINE_LOC"));
				board.setSubmarineVertical(rs.getBoolean("SUBMARINE_VERT"));
				board.setPatrolLoc(rs.getString("PATROL_LOC"));
				board.setPatrolVertical(rs.getBoolean("PATROL_VERT"));
				return board;
			}
		});
		return board;
	}

	@Override
	public List<BattleshipMove> getBattleshipGameMoves(Long gameID, Long identifier) {
		if (jdbcTemplate==null){
			setDataSource(getDataSource());
		}
		List<BattleshipMove> moveList = jdbcTemplate.query("SELECT * FROM BATTLESHIP_MOVES WHERE GAME_ID=? AND IDENTIFIER=?", new Object[]{gameID, identifier}, new RowMapper<BattleshipMove>(){
			public BattleshipMove mapRow(ResultSet rs, int rowNum)	throws SQLException {
				BattleshipMove mv = new BattleshipMove();
				mv.setLoc(rs.getString("LOC"));
				mv.setStatus(rs.getString("STATUS"));
				mv.setUserID(identifier);
				return mv;
			}
		});
		return moveList;
	}

}
