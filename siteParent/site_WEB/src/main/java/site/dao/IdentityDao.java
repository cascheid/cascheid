package site.dao;

import site.identity.Identity;

public interface IdentityDao {
	/**
	 * Gets Identity object from IDENTITY table
	 * @param identifier
	 * @return
	 */
	public Identity getIdentityByIdentifier(Long identifier);
	public Identity getIdentityByUsername(String username);
	public Long insertNewIdentity(Identity identity);
	public void deleteRacingGame(Long identifier);
	public void updateSnakeScore(Long identifier, Integer snakeScore);
	public boolean checkExistingUsername(String username);
	public void updateUsername(Long identifier, String username);
}
