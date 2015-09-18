package site.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import org.springframework.jdbc.core.JdbcTemplate;

import site.identity.Identity;

public class ParentDao{
	private DataSource dataSource;
	protected JdbcTemplate jdbcTemplate;
	
	protected Connection getConnection() throws SQLException{
		Connection conn;
		try {
			Class.forName("com.mysql.jdbc.Driver");
			
			String url = "jdbc:mysql://localhost:3306/mysite";
			String username="webapp";
			String password="w3b@pp!";
			conn=DriverManager.getConnection(url, username, password);
		}catch (ClassNotFoundException e){
			e.printStackTrace();
			throw new IllegalStateException("Failed to load jdbc driver");
		}
		return conn;
	}
	
	protected DataSource getDataSource(){
		if (dataSource==null){
			try {
				Class.forName("com.mysql.jdbc.Driver");
				dataSource = (DataSource) new InitialContext().lookup("java:comp/env/jdbc/mysite");
			} catch (NamingException e) {
				e.printStackTrace();
				throw new IllegalStateException("Could not get datasource.", e);
			} catch (ClassNotFoundException e) {
				e.printStackTrace();
				throw new IllegalStateException("Failed to load jdbc driver.", e);
			}
		}
		return dataSource;
	}
	
	protected void setDataSource(DataSource dataSource){
		this.jdbcTemplate=new JdbcTemplate(dataSource);
	}
}
