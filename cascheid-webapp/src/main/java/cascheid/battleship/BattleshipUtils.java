package cascheid.battleship;

import java.util.ArrayList;
import java.util.List;

import cascheid.dao.BattleshipDao;
import cascheid.dao.BattleshipDaoImpl;

public class BattleshipUtils {
	
	public static BattleshipGame getBattleshipGameByID(Long gameID){
		BattleshipDao dao = new BattleshipDaoImpl();
		BattleshipGame game = dao.getBattleshipGameByID(gameID);
		return game;
	}
	
	public static Long insertBattleshipGame(BattleshipGame game){
		BattleshipDao dao = new BattleshipDaoImpl();
		Long gameID = dao.insertNewBattleshipGame(game);
		return gameID;
	}
	
	public static void insertBattleshipBoard(Long gameID, Long identifier, BattleshipBoard board){
		BattleshipDao dao = new BattleshipDaoImpl();
		dao.insertBattleshipBoard(gameID, identifier, board);
	}
	
	public static void insertBattleshipMove(Long gameID, BattleshipMove move){
		BattleshipDao dao = new BattleshipDaoImpl();
		dao.insertBattleshipMove(gameID, move);
	}
	
	public static void updateBattleshipGameStatus(Long gameID, String status){
		BattleshipDao dao = new BattleshipDaoImpl();
		dao.updateBattleshipGame(gameID, status);
	}

	public static List<BattleshipGame> getBattleshipGamesByIdentifier(Long identifier){
		BattleshipDao dao = new BattleshipDaoImpl();
		List<BattleshipGame> games = dao.getBattleshipGameList(identifier);
		return games;
	}
	
	public static BattleshipBoard getBattleshipBoard(Long gameID, Long identifier){
		BattleshipDao dao = new BattleshipDaoImpl();
		BattleshipBoard board = null;
		try{
			board=dao.getBattleshipBoard(gameID, identifier);
		} catch(Exception e){
			//no boards, must be starting game. That's fine.
		}
		return board;
	}
	
	public static List<String> getSunkenShips(List<BattleshipMove> moves){
		List<String> list = new ArrayList<String>();
		int carrierHealth=5;
		int battleshipHealth=4;
		int destroyerHealth=3;
		int submarineHealth=3;
		int patrolHealth=2;
		for (BattleshipMove mv : moves){
			if (mv.getStatus().equals("hitcarrier")){
				carrierHealth--;
				if (carrierHealth==0){
					list.add("carrier");
				}
			}
			if (mv.getStatus().equals("hitbattleship")){
				battleshipHealth--;
				if (battleshipHealth==0){
					list.add("battleship");
				}
			}
			if (mv.getStatus().equals("hitdestroyer")){
				destroyerHealth--;
				if (destroyerHealth==0){
					list.add("destroyer");
				}
			}
			if (mv.getStatus().equals("hitsubmarine")){
				submarineHealth--;
				if (submarineHealth==0){
					list.add("submarine");
				}
			}
			if (mv.getStatus().equals("hitpatrol")){
				patrolHealth--;
				if (patrolHealth==0){
					list.add("patrol");
				}
			}
		}
		return list;
	}

	public static List<BattleshipMove> getBattleshipMoves(Long gameID, Long identifier){
		BattleshipDao dao = new BattleshipDaoImpl();
		List<BattleshipMove> moves = dao.getBattleshipGameMoves(gameID, identifier);
		return moves;
	}
}
