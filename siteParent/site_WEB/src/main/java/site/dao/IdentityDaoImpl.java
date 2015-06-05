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
				Identity identity=new Identity(rs.getLong("IDENTIFIER"), rs.getLong("RACING_IDENTIFIER"));
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
}
