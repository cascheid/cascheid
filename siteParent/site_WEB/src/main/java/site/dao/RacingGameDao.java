package site.dao;

import java.util.List;

import site.racinggame.Racecar;
import site.racinggame.RacingGame;
import site.racinggame.Upgrade;

public interface RacingGameDao {
	public RacingGame getRacingGameByID(Long identifier);
	public Long insertNewRacingGame(RacingGame racingGame, Long identifier);
	public Racecar getRacecarByID(Integer carID);
	public Upgrade getUpgradeByID(Integer upgradeID);
	public List<Upgrade> getUpgradesByClass(char racingClass);
	public List<Racecar> getRandomOpponentsByClass(char racingClass);
	public Long addNewUserRacecar(Long racingIdentifier, Integer carID);
	public void addNewUpgrade(Long userRacecarID, Integer upgradeID);
	public void updateRacingGame(Long racingIdentifier, Double availableCash, char racingClass);
}
