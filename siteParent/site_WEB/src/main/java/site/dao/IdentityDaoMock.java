package site.dao;

import site.identity.Identity;

public class IdentityDaoMock implements IdentityDao{
	
	public Identity getIdentityByIdentifier(Long identifier){
		Identity identity=new Identity(12345l, 54321l);
		return identity;
	}

	@Override
	public Long insertNewIdentity(Identity identity) {
		// TODO Auto-generated method stub
		return null;
	}
}
