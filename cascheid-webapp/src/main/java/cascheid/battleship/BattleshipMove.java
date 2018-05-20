package cascheid.battleship;

public class BattleshipMove implements java.io.Serializable {

	private static final long serialVersionUID = 1917476196024942196L;
	
	//private Long gameID;
	//private Long userID;
	private String loc;
	private String status;
	private Long userID;
	
	public BattleshipMove(){
	}

	public String getLoc() {
		return loc;
	}

	public void setLoc(String firedLoc) {
		this.loc = firedLoc;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String shotStatus) {
		this.status = shotStatus;
	}

	public Long getUserID() {
		return userID;
	}

	public void setUserID(Long userID) {
		this.userID = userID;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result
				+ ((loc == null) ? 0 : loc.hashCode());
		result = prime * result
				+ ((status == null) ? 0 : status.hashCode());
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		BattleshipMove other = (BattleshipMove) obj;
		if (loc == null) {
			if (other.loc != null)
				return false;
		} else if (!loc.equals(other.loc))
			return false;
		if (userID == null) {
			if (other.userID != null)
				return false;
		} else if (!userID.equals(other.userID))
			return false;
		return true;
	}
}