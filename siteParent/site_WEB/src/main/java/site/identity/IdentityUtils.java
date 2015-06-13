package site.identity;

import site.dao.IdentityDao;
import site.dao.IdentityDaoImpl;

public class IdentityUtils {
	
	public static Identity getIdentityByIdentifier(Long identifier){
		Identity identity=null;
		if (identifier!=null){
			IdentityDao dao = new IdentityDaoImpl();
			//IdentityDao dao = new IdentityDaoMock();
			identity=dao.getIdentityByIdentifier(identifier);
		} else {
			identity=new Identity(identifier);
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
}
