package site.blitzball;

import static org.junit.Assert.*;

import javax.naming.Context;
import javax.naming.InitialContext;

import org.junit.BeforeClass;
import org.junit.Rule;
import org.junit.Test;
import org.junit.rules.ExpectedException;
import org.springframework.dao.EmptyResultDataAccessException;

import com.mysql.jdbc.jdbc2.optional.MysqlDataSource;

import site.dao.BlitzballDao;
import site.dao.BlitzballDaoImpl;

public class BlitzballDaoTest {
	
	Long junitUserID = 23l;//username='JUNIT'
	
	@BeforeClass
    public static void setUpClass() throws Exception {
        // rcarver - setup the jndi context and the datasource
        try {
            // Create initial context
            System.setProperty(Context.INITIAL_CONTEXT_FACTORY,
                "org.apache.naming.java.javaURLContextFactory");
            System.setProperty(Context.URL_PKG_PREFIXES, 
                "org.apache.naming");            
            InitialContext ic = new InitialContext();

            ic.createSubcontext("java:");
            ic.createSubcontext("java:comp");
            ic.createSubcontext("java:comp/env");
            ic.createSubcontext("java:comp/env/jdbc");
            //ic.createSubcontext("java:comp/env/jdbc/mysite");
           
            // Construct DataSource
            MysqlDataSource ds = new MysqlDataSource();
            ds.setURL("jdbc:mysql://localhost:3306/mysite");
            ds.setUser("webapp");
            ds.setPassword("w3b@pp!");
            
            ic.bind("java:comp/env/jdbc/mysite", ds);
        } catch (Exception e){
        	e.printStackTrace();
        	throw e;
        }
        
    }
	
	@Rule
	public final ExpectedException exception = ExpectedException.none();

	@Test
	public void testDeleteGameInfo(){
		BlitzballDao dao = new BlitzballDaoImpl();
		Long id=null;
		try{
			BlitzballInfo info = dao.getBlitzballByIdentifier(junitUserID);
			id = info.getTeam().getTeamID();
		} catch (EmptyResultDataAccessException e){
			System.out.println("No JUNIT data found in testDeleteGameInfo");
			id = dao.insertNewBlitzballGame(junitUserID, "JUnit Testers");
		}
		dao.resetBlitzballGameInfo(id);
		exception.expect(EmptyResultDataAccessException.class);
		BlitzballInfo newInfo = dao.getBlitzballByIdentifier(junitUserID);
		//assertNull(newInfo);
	}
	
	@Test
	public void testCreateGameInfo(){
		BlitzballDao dao = new BlitzballDaoImpl();
		try{
			BlitzballInfo info = dao.getBlitzballByIdentifier(junitUserID);
			dao.resetBlitzballGameInfo(info.getTeam().getTeamID());
		} catch (EmptyResultDataAccessException e){
			System.out.println("No JUNIT data found in testCreateGameInfo");
		}
		dao.insertNewBlitzballGame(junitUserID, "JUnit Testers");
		BlitzballInfo newInfo = dao.getBlitzballByIdentifier(junitUserID);
		assertNotNull(newInfo);
	}
	
	@Test
	public void simulateLeague(){
		BlitzballDao dao = new BlitzballDaoImpl();
		BlitzballInfo info;
		try{
			info = dao.getBlitzballByIdentifier(junitUserID);
		} catch (EmptyResultDataAccessException e){
			System.out.println("No JUNIT data found in simulateLeague");
			dao.insertNewBlitzballGame(junitUserID, "JUnit Testers");
			info = dao.getBlitzballByIdentifier(junitUserID);
		}
		assertNotNull(info);
		info = BlitzballUtils.getActiveLeague(info);
		assertNotNull(info.getLeague());
		Long origLeagueID=info.getLeague().getLeagueID();
		for (int i=0; i<10; i++){
			BlitzballWeekResults results = BlitzballUtils.simulateWeeksGames(info, null);
			//info = dao.getBlitzballByIdentifier(junitUserID);
			//info = BlitzballUtils.getActiveLeague(info);
			System.out.println("Week " + results.getWeekNo() + " Results:");
			for (BlitzballGame game : results.getGameResults()){
				System.out.println("Team " + game.getTeam1().getTeamID() + ": " + game.getTeam1Score() + " - Team " + game.getTeam2().getTeamID() + ": " + game.getTeam2Score());
				
				BlitzballTeam team1 = null;
				BlitzballTeam team2 = null;
				if (game.getTeam1().getTeamID().equals(info.getTeam().getTeamID())){
					team1=info.getTeam();
				} else if (game.getTeam2().getTeamID().equals(info.getTeam().getTeamID())){
					team2=info.getTeam();
				}
				for (BlitzballTeam team : info.getOpponents()){
					if (game.getTeam1().getTeamID().equals(team.getTeamID())){
						team1=team;
					} else if (game.getTeam2().getTeamID().equals(team.getTeamID())){
						team2=team;
					}
				}
				System.out.println("Team " + game.getTeam1().getTeamID() + " levels:");
				System.out.println("LW:"+ team1.getLeftWing().getLevel() + " RW:"+ team1.getRightWing().getLevel()+ 
						" MF:"+ team1.getMidfielder().getLevel()+ " LB:"+ team1.getLeftBack().getLevel() + " RB:"+ team1.getRightBack().getLevel() + " GK:"+ team1.getKeeper().getLevel());
				
				System.out.println("Team " + game.getTeam2().getTeamID() + " levels:");
				System.out.println("LW:"+ team2.getLeftWing().getLevel() + " RW:"+ team2.getRightWing().getLevel()+ 
						" MF:"+ team2.getMidfielder().getLevel()+ " LB:"+ team2.getLeftBack().getLevel() + " RB:"+ team2.getRightBack().getLevel() + " GK:"+ team2.getKeeper().getLevel());
			}
		}
		info = dao.getBlitzballByIdentifier(junitUserID);
		info = BlitzballUtils.getActiveLeague(info);
		Long newLeagueID=info.getLeague().getLeagueID();
		assertNotEquals(origLeagueID, newLeagueID);
	}
}
