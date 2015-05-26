package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import site.identity.Identity;

public class IdentityDaoImpl implements IdentityDao{
	
	public Identity getIdentityByIdentifier(Long identifier){
		Identity identity=null;
	
		try {
			Context initCtx = new InitialContext();
	
			Context envCtx = (Context) initCtx.lookup("java:comp/env");

			DataSource ds = (DataSource) envCtx.lookup("jdbc/mysite");
			Connection conn = ds.getConnection();
			PreparedStatement pst = conn.prepareStatement("SELECT * FROM IDENTITY WHERE IDENTIFIER=?");
			pst.setLong(1, identifier);
			ResultSet rs=pst.executeQuery();
			while (rs.next()){
				Long racingGameIdentifier=rs.getLong("RACINGIDENTIFIER");
				identity = new Identity(identifier, racingGameIdentifier);
			}
		} catch (NamingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return identity;
	}
}
