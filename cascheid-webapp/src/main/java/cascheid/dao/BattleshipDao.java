package cascheid.dao;

import java.util.List;

import cascheid.battleship.BattleshipBoard;
import cascheid.battleship.BattleshipGame;
import cascheid.battleship.BattleshipMove;

public interface BattleshipDao {
	public List<BattleshipGame> getBattleshipGameList(Long identifier);
	public Long insertNewBattleshipGame(BattleshipGame game);
	public void insertBattleshipBoard(Long gameID, Long identifier, BattleshipBoard board);
	public void insertBattleshipMove(Long gameID, BattleshipMove mv);
	public void updateBattleshipGame(Long gameID, String status);
	public BattleshipGame getBattleshipGameByID(Long gameID);
	public BattleshipBoard getBattleshipBoard(Long gameID, Long identifier);
	public List<BattleshipMove> getBattleshipGameMoves(Long gameID, Long identifier);
}
