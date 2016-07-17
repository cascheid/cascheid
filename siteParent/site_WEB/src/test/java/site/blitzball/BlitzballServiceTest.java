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
			controller.getLeagueStandings();
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
			controller.getLeagueStandings();
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
			controller.getLeagueStandings();
		}
		ModelAndView mv = controller.getPlayerStatisticsDisplay(1);
		assertNotNull(mv);
		assertNotNull(mv.getModel().get("player"));
	}
	
	@Test
	public void testLoadBlitzballGame(){
		if (controller==null){
			controller= new BlitzballController();
			controller.getBlizballMenuBackground(junitUserID);
			controller.getLeagueStandings();
		}
		ModelAndView mv = controller.loadBlitzballGame();
		assertNotNull(mv);
		assertNotNull(mv.getModel().get("myTeam"));
		assertNotNull(mv.getModel().get("oppTeam"));
		assertNotNull(mv.getModel().get("blitzballGameRoster"));
	}
	
	@Test
	public void testLoadGameTechScreen(){
		if (controller==null){
			controller= new BlitzballController();
			controller.getBlizballMenuBackground(junitUserID);
			controller.getLeagueStandings();
		}
		BlitzballGameRoster roster = new BlitzballGameRoster();
		roster.setLeftWing(BlitzballMockData.getLeftWing(1l).getPlayerID());
		roster.setRightWing(BlitzballMockData.getRightWing(1l).getPlayerID());
		roster.setMidfielder(BlitzballMockData.getMidfielder(1l).getPlayerID());
		roster.setLeftBack(BlitzballMockData.getLeftBack(1l).getPlayerID());
		roster.setRightBack(BlitzballMockData.getRightBack(1l).getPlayerID());
		roster.setKeeper(BlitzballMockData.getKeeper(1l).getPlayerID());
		ModelAndView mv = controller.loadGameTechScreen(roster);
		assertNotNull(mv);
		assertNotNull(mv.getModel().get("myTeam"));
		assertNotNull(mv.getModel().get("techList"));
		assertNotNull(mv.getModel().get("blitzballGameTechs"));
	}
	
	@Test
	public void testLoadGameMarkScreen(){
		if (controller==null){
			controller= new BlitzballController();
			controller.getBlizballMenuBackground(junitUserID);
			controller.getLeagueStandings();
		}
		BlitzballGameTechs techs = new BlitzballGameTechs();
		techs.setLeftWingTech1(BlitzballMockData.getLeftWing(1l).getTech1().getTechID());
		techs.setRightWingTech1(BlitzballMockData.getRightWing(1l).getTech1().getTechID());
		techs.setMidfielderTech1(BlitzballMockData.getMidfielder(1l).getTech1().getTechID());
		techs.setLeftWingTech1(BlitzballMockData.getLeftBack(1l).getTech1().getTechID());
		techs.setRightWingTech1(BlitzballMockData.getRightBack(1l).getTech1().getTechID());
		techs.setKeeperTech1(BlitzballMockData.getKeeper(1l).getTech1().getTechID());
		ModelAndView mv = controller.loadGameMarkScreen(techs);
		assertNotNull(mv);
		assertNotNull(mv.getModel().get("myTeam"));
		assertNotNull(mv.getModel().get("oppTeam"));
		assertNotNull(mv.getModel().get("techList"));
		assertNotNull(mv.getModel().get("blitzballGameMarks"));
	}
	
	@Test
	public void testLoadGameReady(){
		if (controller==null){
			controller= new BlitzballController();
			controller.getBlizballMenuBackground(junitUserID);
			controller.getLeagueStandings();
		}
		BlitzballGameMarks marks = new BlitzballGameMarks();
		marks.setLeftWingTarget(BlitzballMockData.getLeftWing(2l).getPlayerID());
		marks.setRightWingTarget(BlitzballMockData.getRightWing(2l).getPlayerID());
		marks.setMidfielderTarget(BlitzballMockData.getMidfielder(2l).getPlayerID());
		marks.setLeftBackTarget(BlitzballMockData.getLeftBack(2l).getPlayerID());
		marks.setRightBackTarget(BlitzballMockData.getRightBack(2l).getPlayerID());
		marks.setKeeperTarget(BlitzballMockData.getKeeper(2l).getPlayerID());
		ModelAndView mv = controller.loadGameReady(marks);
		assertNotNull(mv);
		assertNotNull(mv.getModel().get("myTeam"));
		assertNotNull(mv.getModel().get("oppTeam"));
		assertNotNull(mv.getModel().get("blitzballGameMarks"));
		assertNotNull(mv.getModel().get("blitzballGameInfo"));
	}
	
	@Test
	public void testPlayBlitzballGame(){
		if (controller==null){
			controller= new BlitzballController();
			controller.getBlizballMenuBackground(junitUserID);
			controller.getLeagueStandings();
		}
		ModelAndView mv = controller.playBlitzballGame();
		assertNotNull(mv);
		assertNotNull(mv.getModel().get("myTeam"));
		assertNotNull(mv.getModel().get("oppTeam"));
		assertNotNull(mv.getModel().get("blitzballGameInfo"));
	}
	
	@Test
	public void testSubmitHalfResults(){
		if (controller==null){
			controller= new BlitzballController();
			controller.getBlizballMenuBackground(junitUserID);
			controller.getLeagueStandings();
		}
		BlitzballGame game = BlitzballMockData.getHalftimeGame(BlitzballMockData.getTeam1(), BlitzballMockData.getTeam2(), true, 1l);
		ModelAndView mv = controller.submitHalfResults(junitUserID, game);
		assertNotNull(mv);
		assertNotNull(mv.getModel().get("myTeam"));
		assertNotNull(mv.getModel().get("oppTeam"));
		assertNotNull(mv.getModel().get("blitzballGameMarks"));
		assertNotNull(mv.getModel().get("blitzballGameInfo"));
		BlitzballGame game2 = BlitzballMockData.getCompletedBlitzballGame(BlitzballMockData.getTeam1(), BlitzballMockData.getTeam2(), true, 1l);
		mv = controller.submitHalfResults(junitUserID, game2);
		assertNotNull(mv);
	}
}
