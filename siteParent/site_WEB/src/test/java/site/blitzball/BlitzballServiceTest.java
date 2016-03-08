package site.blitzball;

import static org.junit.Assert.*;

import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;

import org.junit.BeforeClass;
import org.junit.Test;
import org.springframework.web.servlet.ModelAndView;

import com.mysql.jdbc.jdbc2.optional.MysqlDataSource;

import site.controller.BlitzballController;

public class BlitzballServiceTest {
	
	private static BlitzballController controller;
	
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
	
	@Test
	public void getBlitzballMenu(){
		if (controller==null){
			controller= new BlitzballController();
		}
		ModelAndView mv = controller.getBlizballMenuBackground(junitUserID);
		assertNotNull(mv);
	}

	@Test
	public void testGetLeagueStandings(){
		if (controller==null){
			controller= new BlitzballController();
			controller.getBlizballMenuBackground(junitUserID);
		}
		ModelAndView mv = controller.getLeagueStandings();
		assertNotNull(mv);
		assertNotNull(mv.getModel().get("standings"));
		BlitzballLeagueStandings standings = (BlitzballLeagueStandings) mv.getModel().get("standings");
		assertNotNull(standings.getDivision1Standings());
		assertNotNull(standings.getDivision2Standings());
		assertNotNull(mv.getModel().get("oppName"));
	}
	
	@Test
	public void testGetLeagueSchedule(){
		if (controller==null){
			controller= new BlitzballController();
			controller.getBlizballMenuBackground(junitUserID);
		}
		ModelAndView mv = controller.getLeagueSchedule();
		assertNotNull(mv);
		assertNotNull(mv.getModel().get("week"));
		assertNotNull(mv.getModel().get("schedule"));
		assertNotNull(mv.getModel().get("oppName"));
	}
	
	@Test
	public void testGetLeagueStats(){
		if (controller==null){
			controller= new BlitzballController();
			controller.getBlizballMenuBackground(junitUserID);
		}
		ModelAndView mv = controller.getLeagueStatistics();
		assertNotNull(mv);
		assertNotNull(mv.getModel().get("techList"));
		assertNotNull(mv.getModel().get("oppName"));
		assertNotNull(mv.getModel().get("statistics"));
		//List<BlitzballPlayerStatistics> statistics = (List<BlitzballPlayerStatistics>) mv.getModel().get("statistics");
	}
	
	@Test
	public void testGetStatDisplay(){
		if (controller==null){
			controller= new BlitzballController();
			controller.getBlizballMenuBackground(junitUserID);
		}
		ModelAndView mv = controller.getPlayerStatisticsDisplay(1);
		assertNotNull(mv);
		assertNotNull(mv.getModel().get("player"));
	}
}
