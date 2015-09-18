package site.dao;

import java.util.List;

import site.battleship.BattleshipBoard;
import site.battleship.BattleshipGame;
import site.battleship.BattleshipMove;

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
