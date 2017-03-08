package site.blitzball;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Component;

import site.battleship.BattleshipGame;
import site.battleship.BattleshipMove;
import site.dao.BattleshipDao;

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
