package cascheid.dao;

import java.math.BigDecimal;
import java.util.List;

import cascheid.racinggame.Racecar;
import cascheid.racinggame.RacingGame;
import cascheid.racinggame.Upgrade;

public interface RacingGameDao {
	public RacingGame getRacingGameByID(Long identifier);
	public Long insertNewRacingGame(RacingGame racingGame, Long identifier);
	public Racecar getRacecarByID(Integer carID);
	public Upgrade getUpgradeByID(Integer upgradeID);
	public List<Upgrade> getUpgradesByClass(String racingClass);
	public List<Racecar> getRandomOpponentsByClass(String racingClass, Integer numberOfRacers);
	public List<Racecar> getAvailableCarsToPurchase(String racingClass, Long racingIdentifier);
	public Long addNewUserRacecar(Long racingIdentifier, Integer carID);
	public void addNewUpgrade(Long userRacecarID, Integer upgradeID);
	public void updateRacingGame(RacingGame racingGame);
}
