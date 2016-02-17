package site.blitzball;

import static org.junit.Assert.*;

import org.junit.Test;

import site.dao.BlitzballDao;
import site.dao.BlitzballDaoImpl;

public class BlitzballDaoTest {
	
	Long junitUserID = 23l;

	@Test
	public void testDeleteGameInfo(){
		BlitzballDao dao = new BlitzballDaoImpl();
		BlitzballInfo info = dao.getBlitzballByIdentifier(junitUserID);
		Long id;
		if (info!=null){
			id=info.getTeam().getTeamID();
			assertNotNull(id);
		} else {
			id = dao.insertNewBlitzballGame(junitUserID, "JUnit Testers");
		}
		dao.deleteBlitzballGameInfo(id);
		BlitzballInfo newInfo = dao.getBlitzballByIdentifier(junitUserID);
		assertNull(newInfo);
	}
	
	@Test
	public void testCreateGameInfo(){
		BlitzballDao dao = new BlitzballDaoImpl();
		BlitzballInfo info = dao.getBlitzballByIdentifier(junitUserID);
		if (info!=null){
			dao.deleteBlitzballGameInfo(info.getTeam().getTeamID());
		}
		dao.insertNewBlitzballGame(junitUserID, "JUnit Testers");
		BlitzballInfo newInfo = dao.getBlitzballByIdentifier(junitUserID);
		assertNotNull(newInfo);
	}
}
