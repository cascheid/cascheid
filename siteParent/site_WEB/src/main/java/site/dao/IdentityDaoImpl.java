package site.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import org.springframework.jdbc.core.PreparedStatementCreator;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;

import site.identity.Identity;

public class IdentityDaoImpl extends ParentDao implements IdentityDao{
	
	public Identity getIdentityByIdentifier(Long identifier){
		if (jdbcTemplate==null){
			setDataSource(getDataSource());
		}
		Identity identity = jdbcTemplate.queryForObject("SELECT * FROM IDENTITY WHERE IDENTIFIER=?", new Object[]{identifier}, new RowMapper<Identity>(){
			@Override
			public Identity mapRow(ResultSet rs, int rowNum)
					throws SQLException {
				Identity identity=new Identity();
				identity.setIdentifier(rs.getLong("IDENTIFIER"));
				identity.setRacingGameIdentifier(rs.getLong("RACING_IDENTIFIER"));
				identity.setSnakeScore(rs.getInt("SNAKE_SCORE"));
				return identity;
			}
				
		});
		return identity;
	}
	
	public Long insertNewIdentity(Identity identity){
		if (jdbcTemplate==null){
			setDataSource(getDataSource());
		}
		Long lReturn=null;
		KeyHolder keyHolder = new GeneratedKeyHolder();
		jdbcTemplate.update(
		    new PreparedStatementCreator() {
		        public PreparedStatement createPreparedStatement(Connection connection) throws SQLException {
		            PreparedStatement ps =
		                connection.prepareStatement("INSERT INTO IDENTITY(IDENTIFIER) VALUES (NULL)", Statement.RETURN_GENERATED_KEYS);
		            return ps;
		        }
		    },
		    keyHolder);
		lReturn=(Long) keyHolder.getKey();
		return lReturn;
	}
	
	public void deleteRacingGame(Long identifier){
		if (jdbcTemplate==null){
			setDataSource(getDataSource());
		}
		Long racingIdentifier = jdbcTemplate.queryForObject("SELECT RACING_IDENTIFIER FROM IDENTITY WHERE IDENTIFIER=?", new Object[]{identifier}, Long.class);
		if (racingIdentifier!=null&&racingIdentifier>0){
			jdbcTemplate.query("SELECT * FROM USER_RACECARS WHERE RACING_IDENTIFIER=?", new Object[]{racingIdentifier}, new RowMapper<String>(){
				public String mapRow(ResultSet rs, int rowNum) throws SQLException {
					jdbcTemplate.update("DELETE FROM USER_RACECAR_UPGRADES WHERE USER_RACECAR_ID=?", new Object[]{rs.getLong("USER_RACECAR_ID")});
					return null;
				}
			});
			jdbcTemplate.update("DELETE FROM USER_RACECARS WHERE RACING_IDENTIFIER=?", new Object[]{racingIdentifier});
			jdbcTemplate.update("UPDATE IDENTITY SET RACING_IDENTIFIER=NULL WHERE IDENTIFIER=?", new Object[]{identifier});
		}
	}
	public void updateSnakeScore(Long identifier, Integer snakeScore){
		if (jdbcTemplate==null){
			setDataSource(getDataSource());
		}
		jdbcTemplate.update("UPDATE IDENTITY SET SNAKE_SCORE=? WHERE IDENTIFIER=?", new Object[]{snakeScore, identifier});
	}
}
