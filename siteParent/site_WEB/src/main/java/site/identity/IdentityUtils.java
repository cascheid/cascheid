package site.identity;

import dao.IdentityDao;
import dao.IdentityDaoImpl;
import dao.IdentityDaoMock;

public class IdentityUtils {
	public static Long getRandomIdentifier(){
		return 12345l;
	}
	
	public static Identity getIdentityByIdentifier(Long identifier){
		Identity identity=null;
		if (identifier!=null){
			//IdentityDao dao = new IdentityDaoImpl();
			IdentityDao dao = new IdentityDaoMock();
			identity=dao.getIdentityByIdentifier(identifier);
		} else {
			identity=new Identity(identifier);
		}
		return identity;
	}
}
