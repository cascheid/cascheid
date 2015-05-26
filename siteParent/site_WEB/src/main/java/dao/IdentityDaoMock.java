package dao;

import site.identity.Identity;

public class IdentityDaoMock implements IdentityDao{
	
	public Identity getIdentityByIdentifier(Long identifier){
		Identity identity=new Identity(12345l, 54321l);
		return identity;
	}
}
