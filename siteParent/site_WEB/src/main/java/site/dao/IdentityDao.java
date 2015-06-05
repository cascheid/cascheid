package site.dao;

import site.identity.Identity;

public interface IdentityDao {
	/**
	 * Gets Identity object from IDENTITY table
	 * @param identifier
	 * @return
	 */
	public Identity getIdentityByIdentifier(Long identifier);
	public Long insertNewIdentity(Identity identity);
}
