package site.dao;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Arrays;
import java.util.List;

import org.springframework.jdbc.core.PreparedStatementCreator;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;

import site.racinggame.Racecar;
import site.racinggame.RacingGame;
import site.racinggame.Upgrade;
import site.racinggame.UserRacecar;

public class RacingGameDaoImpl extends ParentDao implements RacingGameDao{

	public RacingGame getRacingGameByID(final Long identifier) {
		if (jdbcTemplate==null){
			setDataSource(getDataSource());
		}
		RacingGame racingGame = jdbcTemplate.queryForObject("SELECT * FROM RACING_GAME WHERE RACING_IDENTIFIER=?", new Object[]{identifier}, new RowMapper<RacingGame>(){
			@Override
			public RacingGame mapRow(ResultSet rs, int rowNum)
					throws SQLException {
				RacingGame racingGame=new RacingGame();
				racingGame.setRacingIdentifier(rs.getLong("RACING_IDENTIFIER"));
				racingGame.setAvailableCash(rs.getBigDecimal("AVAILABLE_CASH"));
				racingGame.setRacingClass(rs.getString("RACING_CLASS"));
				Integer carID=rs.getInt("CAR_ID");
				List<UserRacecar> carList = jdbcTemplate.query("SELECT * FROM RACECARS RC INNER JOIN USER_RACECARS UR ON RC.CAR_ID=UR.CAR_ID WHERE UR.RACING_IDENTIFIER=?", new Object[]{identifier}, new RowMapper<UserRacecar>(){
					public UserRacecar mapRow(ResultSet rs, int rowNum)	throws SQLException {
						UserRacecar car = new UserRacecar();
						car.setCarID(rs.getInt("CAR_ID"));
						car.setRacingClass(rs.getString("RACING_CLASS"));
						car.setTopSpeed(rs.getInt("TOP_SPEED"));
						car.setAcceleration(rs.getInt("ACCELERATION"));
						car.setReliability(rs.getBigDecimal("RELIABILITY"));
						car.setLapEfficiency(rs.getBigDecimal("LAP_EFFICIENCY"));
						car.setModel(rs.getString("MODEL"));
						car.setName(rs.getString("NAME"));
						car.setPrice(rs.getBigDecimal("PRICE"));
						car.setUserRacecarID(rs.getLong("USER_RACECAR_ID"));
						List<Upgrade> upgradeList = jdbcTemplate.query("SELECT * FROM UPGRADES U INNER JOIN USER_RACECAR_UPGRADES RCU ON U.UPGRADE_ID=RCU.UPGRADE_ID WHERE RCU.USER_RACECAR_ID=?", new Object[]{rs.getLong("USER_RACECAR_ID")}, new RowMapper<Upgrade>(){
							public Upgrade mapRow(ResultSet rs, int rowNum)	throws SQLException {
								Upgrade upgrade = new Upgrade();
								upgrade.setUpgradeID(rs.getInt("UPGRADE_ID"));
								upgrade.setRacingClass(rs.getString("RACING_CLASS"));
								upgrade.setTopSpeedMod(rs.getInt("TOP_SPEED_MOD"));
								upgrade.setAccelerationMod(rs.getInt("ACCELERATION_MOD"));
								if (rs.wasNull()){
									upgrade.setAccelerationMod(null);
								}
								upgrade.setReliabilityMod(rs.getBigDecimal("RELIABILITY_MOD"));
								if (rs.wasNull()){
									upgrade.setReliabilityMod(null);
								}
								upgrade.setEfficiencyMod(rs.getBigDecimal("LAP_EFFICIENCY_MOD"));
								if (rs.wasNull()){
									upgrade.setEfficiencyMod(null);
								}
								upgrade.setPrice(rs.getBigDecimal("PRICE"));
								return upgrade;
							}
						});
						car.setUpgradeList(upgradeList);
						return car;
					}
				});
				racingGame.setCarList(carList);
				for (UserRacecar car : carList){
					racingGame.setSelectedCar(car);
					if (car.getCarID()==carID){
						break;
					}
				}
				return racingGame;
			}
				
		});
		return racingGame;
	}

	public Long insertNewRacingGame(RacingGame racingGame, Long identifier) {
		if (jdbcTemplate==null){
			setDataSource(getDataSource());
		}
		Long lReturn=null;
		KeyHolder keyHolder = new GeneratedKeyHolder();
		jdbcTemplate.update(
		    new PreparedStatementCreator() {
		        public PreparedStatement createPreparedStatement(Connection connection) throws SQLException {
		            PreparedStatement ps =
		                connection.prepareStatement("INSERT INTO RACING_GAME(RACING_IDENTIFIER, RACING_CLASS, AVAILABLE_CASH) VALUES (NULL, ?, ?)", Statement.RETURN_GENERATED_KEYS);
		            ps.setString(1, String.valueOf(racingGame.getRacingClass()));
		            ps.setBigDecimal(2, racingGame.getAvailableCash());
		            return ps;
		        }
		    },
		    keyHolder);
		lReturn=(Long) keyHolder.getKey();
		racingGame.setRacingIdentifier(lReturn);
		/*jdbcTemplate.update(
			    new PreparedStatementCreator() {
			        public PreparedStatement createPreparedStatement(Connection connection) throws SQLException {
			            PreparedStatement ps =
			                connection.prepareStatement("INSERT INTO USER_RACECARS(USER_RACECAR_ID, RACING_IDENTIFIER, CAR_ID) VALUES (NULL, ?, ?)", Statement.RETURN_GENERATED_KEYS);
			            ps.setLong(1, racingGame.getRacingIdentifier());
			            ps.setInt(2, 1);
			            return ps;
			        }
			    },
			    keyHolder);
		racingGame.getCarList().get(0).setUserRacecarID((Long) keyHolder.getKey());*/
		jdbcTemplate.update("UPDATE IDENTITY SET RACING_IDENTIFIER=? WHERE IDENTIFIER=?", new Object[]{racingGame.getRacingIdentifier(), identifier});
		return lReturn;
	}

	public Racecar getRacecarByID(Integer carID) {
		if (jdbcTemplate==null){
			setDataSource(getDataSource());
		}
		Racecar car = jdbcTemplate.queryForObject("SELECT * FROM RACECARS WHERE CAR_ID=?", new Object[]{carID}, new RowMapper<Racecar>(){
			public Racecar mapRow(ResultSet rs, int rowNum) throws SQLException {
				Racecar car = new Racecar();
				car.setCarID(rs.getInt("CAR_ID"));
				car.setRacingClass(rs.getString("RACING_CLASS"));
				car.setTopSpeed(rs.getInt("TOP_SPEED"));
				car.setAcceleration(rs.getInt("ACCELERATION"));
				car.setReliability(rs.getBigDecimal("RELIABILITY"));
				car.setLapEfficiency(rs.getBigDecimal("LAP_EFFICIENCY"));
				car.setModel(rs.getString("MODEL"));
				car.setName(rs.getString("NAME"));
				car.setPrice(rs.getBigDecimal("PRICE"));
				return car;
			}
		});
		return car;
	}

	public Upgrade getUpgradeByID(Integer upgradeID) {
		if (jdbcTemplate==null){
			setDataSource(getDataSource());
		}
		Upgrade upgrade = jdbcTemplate.queryForObject("SELECT * FROM UPGRADES WHERE UPGRADE_ID=?", new Object[]{upgradeID}, new RowMapper<Upgrade>(){
			public Upgrade mapRow(ResultSet rs, int rowNum)	throws SQLException {
				Upgrade upgrade = new Upgrade();
				upgrade.setUpgradeID(rs.getInt("UPGRADE_ID"));
				upgrade.setRacingClass(rs.getString("RACING_CLASS"));
				upgrade.setTopSpeedMod(rs.getInt("TOP_SPEED_MOD"));
				upgrade.setAccelerationMod(rs.getInt("ACCELERATION_MOD"));
				if (rs.wasNull()){
					upgrade.setAccelerationMod(null);
				}
				upgrade.setReliabilityMod(rs.getBigDecimal("RELIABILITY_MOD"));
				if (rs.wasNull()){
					upgrade.setReliabilityMod(null);
				}
				upgrade.setEfficiencyMod(rs.getBigDecimal("LAP_EFFICIENCY_MOD"));
				if (rs.wasNull()){
					upgrade.setEfficiencyMod(null);
				}
				upgrade.setPrice(rs.getBigDecimal("PRICE"));
				return upgrade;
			}
		});
		return upgrade;
	}
	
	public List<Upgrade> getUpgradesByClass(String racingClass){
		if (jdbcTemplate==null){
			setDataSource(getDataSource());
		}
		List<Upgrade> upgrades = jdbcTemplate.query("SELECT * FROM UPGRADES WHERE RACING_CLASS=?", new String[]{String.valueOf(racingClass)}, new RowMapper<Upgrade>(){
			public Upgrade mapRow(ResultSet rs, int rowNum)	throws SQLException {
				Upgrade upgrade = new Upgrade();
				upgrade.setUpgradeID(rs.getInt("UPGRADE_ID"));
				upgrade.setRacingClass(rs.getString("RACING_CLASS"));
				upgrade.setTopSpeedMod(rs.getInt("TOP_SPEED_MOD"));
				upgrade.setAccelerationMod(rs.getInt("ACCELERATION_MOD"));
				if (rs.wasNull()){
					upgrade.setAccelerationMod(null);
				}
				upgrade.setReliabilityMod(rs.getBigDecimal("RELIABILITY_MOD"));
				if (rs.wasNull()){
					upgrade.setReliabilityMod(null);
				}
				upgrade.setEfficiencyMod(rs.getBigDecimal("LAP_EFFICIENCY_MOD"));
				if (rs.wasNull()){
					upgrade.setEfficiencyMod(null);
				}
				upgrade.setPrice(rs.getBigDecimal("PRICE"));
				return upgrade;
			}
		});
		return upgrades;
	}

	public List<Racecar> getRandomOpponentsByClass(String racingClass, Integer numberOfRacers) {
		if (jdbcTemplate==null){
			setDataSource(getDataSource());
		}
		List<Racecar> carList = jdbcTemplate.query("SELECT * FROM RACECARS WHERE RACING_CLASS =? ORDER BY RAND() LIMIT ?", new Object[]{racingClass, numberOfRacers}, new RowMapper<Racecar>(){
			public Racecar mapRow(ResultSet rs, int rowNum) throws SQLException {
				Racecar car = new Racecar();
				car.setCarID(rs.getInt("CAR_ID"));
				car.setRacingClass(rs.getString("RACING_CLASS"));
				car.setTopSpeed(rs.getInt("TOP_SPEED"));
				car.setAcceleration(rs.getInt("ACCELERATION"));
				car.setReliability(rs.getBigDecimal("RELIABILITY"));
				car.setLapEfficiency(rs.getBigDecimal("LAP_EFFICIENCY"));
				car.setModel(rs.getString("MODEL"));
				car.setPrice(rs.getBigDecimal("PRICE"));
				car.setName(rs.getString("NAME"));
				return car;
			}
		});
		return carList;
	}

	public List<Racecar> getAvailableCarsToPurchase(String racingClass, Long racingIdentifier) {
		if (jdbcTemplate==null){
			setDataSource(getDataSource());
		}
		String availableList = "('E'";
		if (Arrays.asList("D", "C", "B", "A", "S", "SS").contains(racingClass)){
			availableList+=", 'D'";
		}
		if (Arrays.asList("C", "B", "A", "S", "SS").contains(racingClass)){
			availableList+=", 'C'";
		}
		if (Arrays.asList("B", "A", "S", "SS").contains(racingClass)){
			availableList+=", 'B'";
		}
		if (Arrays.asList("A", "S", "SS").contains(racingClass)){
			availableList+=", 'A'";
		}
		if (Arrays.asList("S", "SS").contains(racingClass)){
			availableList+=", 'S'";
		}
		if ("SS".equals(racingClass)){
			availableList+=", 'SS'";
		}
		availableList+=")";
		String orderBy=" ORDER BY CASE WHEN RACING_CLASS='SS' THEN '1' WHEN RACING_CLASS='S' THEN '2' WHEN RACING_CLASS='A' THEN '3' WHEN RACING_CLASS='B' THEN '4' WHEN RACING_CLASS='C' THEN '5' WHEN RACING_CLASS='D' THEN '6' ELSE '7' END;";
		List<Racecar> carList = jdbcTemplate.query("SELECT * FROM RACECARS WHERE RACING_CLASS IN "+availableList+" AND CAR_ID NOT IN (SELECT CAR_ID FROM USER_RACECARS WHERE RACING_IDENTIFIER=?)"+orderBy, new Object[]{racingIdentifier}, new RowMapper<Racecar>(){
			public Racecar mapRow(ResultSet rs, int rowNum) throws SQLException {
				Racecar car = new Racecar();
				car.setCarID(rs.getInt("CAR_ID"));
				car.setRacingClass(rs.getString("RACING_CLASS"));
				car.setTopSpeed(rs.getInt("TOP_SPEED"));
				car.setAcceleration(rs.getInt("ACCELERATION"));
				car.setReliability(rs.getBigDecimal("RELIABILITY"));
				car.setLapEfficiency(rs.getBigDecimal("LAP_EFFICIENCY"));
				car.setModel(rs.getString("MODEL"));
				car.setPrice(rs.getBigDecimal("PRICE"));
				car.setName(rs.getString("NAME"));
				return car;
			}
		});
		return carList;
	}

	public Long addNewUserRacecar(Long racingIdentifier, Integer carID) {
		if (jdbcTemplate==null){
			setDataSource(getDataSource());
		}
		Long lReturn=null;
		KeyHolder keyHolder = new GeneratedKeyHolder();
		jdbcTemplate.update(
			    new PreparedStatementCreator() {
			        public PreparedStatement createPreparedStatement(Connection connection) throws SQLException {
			            PreparedStatement ps =
			                connection.prepareStatement("INSERT INTO USER_RACECARS(USER_RACECAR_ID, RACING_IDENTIFIER, CAR_ID) VALUES (NULL, ?, ?)", Statement.RETURN_GENERATED_KEYS);
			            ps.setLong(1, racingIdentifier);
			            ps.setInt(2, carID);
			            return ps;
			        }
			    },
			    keyHolder);
		lReturn=(Long) keyHolder.getKey();
		return lReturn;
	}

	public void addNewUpgrade(Long userRacecarID, Integer upgradeID) {
		if (jdbcTemplate==null){
			setDataSource(getDataSource());
		}
		jdbcTemplate.update("INSERT INTO USER_RACECAR_UPGRADES (USER_RACECAR_ID, UPGRADE_ID) VALUES (?,?)", new Object[]{userRacecarID, upgradeID});
	}

	public void updateRacingGame(Long racingIdentifier, BigDecimal availableCash,
			String racingClass, Integer carID) {
		if (jdbcTemplate==null){
			setDataSource(getDataSource());
		}
		jdbcTemplate.update("UPDATE RACING_GAME SET AVAILABLE_CASH=?, RACING_CLASS=?, CAR_ID=? WHERE RACING_IDENTIFIER=?", new Object[]{availableCash, String.valueOf(racingClass), carID, racingIdentifier});
	}
	
}
