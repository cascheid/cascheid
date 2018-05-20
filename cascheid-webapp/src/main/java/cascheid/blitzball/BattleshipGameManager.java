package cascheid.blitzball;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Component;

import cascheid.battleship.BattleshipGame;
import cascheid.battleship.BattleshipMove;
import cascheid.dao.BattleshipDao;

@Component
public class BattleshipGameManager {
	
	@Autowired
	BattleshipDao dao;

	@Cacheable(value="battleshipGameCache", key="#gameID")
	public BattleshipGame getActiveGame(Long gameID){
		return dao.getBattleshipGameByID(gameID);
	}
	
	@CacheEvict(value="battleshipGameCache", key="#gameID")
	public void insertBattleshipMove(Long gameID, BattleshipMove move){
		dao.insertBattleshipMove(gameID, move);
	}
}
