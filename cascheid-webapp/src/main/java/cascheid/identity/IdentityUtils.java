package cascheid.identity;

import org.springframework.dao.EmptyResultDataAccessException;

import cascheid.dao.IdentityDao;
import cascheid.dao.IdentityDaoImpl;

public class IdentityUtils {
	
	public static String getDisplayedUser(Identity identity){
		if (identity!=null&&identity.getUsername()!=null){
			return identity.getUsername();
		}
		return "Anonymous";
	}
	
	public static Identity getIdentityByIdentifier(Long identifier){
		Identity identity=null;
		if (identifier!=null&&identifier>0){
			IdentityDao dao = new IdentityDaoImpl();
			//IdentityDao dao = new IdentityDaoMock();
			identity=dao.getIdentityByIdentifier(identifier);
		} else {
			identity=new Identity();
		}
		return identity;
	}
	
	public static Identity getIdentityByUsername(String username){
		Identity identity=null;
		try{
		if (username!=null&&!username.equals("")){
			IdentityDao dao = new IdentityDaoImpl();
			identity=dao.getIdentityByUsername(username);
		}
		}catch(EmptyResultDataAccessException e){
			e.printStackTrace();//just means invalid username
		}
		return identity;
	}
	
	public static Long insertIdentity(Identity identity){
		Long lReturn = null;
		IdentityDao dao = new IdentityDaoImpl();
		lReturn = dao.insertNewIdentity(identity);
		return lReturn;
	}
	
	public static void deleteRacingGame(Long identifier){
		IdentityDao dao = new IdentityDaoImpl();
		dao.deleteRacingGame(identifier);
	}
	
	public static void updateSnakeScore(Long identifier, Integer snakeScore){
		IdentityDao dao = new IdentityDaoImpl();
		dao.updateSnakeScore(identifier, snakeScore);
	}
	
	public static void updateUsername(Long identifier, String username){
		IdentityDao dao = new IdentityDaoImpl();
		dao.updateUsername(identifier, username);
	}
	
	public static boolean checkExistingUsername(String username){
		IdentityDao dao = new IdentityDaoImpl();
		boolean bExists=dao.checkExistingUsername(username);
		return bExists;
	}
}
