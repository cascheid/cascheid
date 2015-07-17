package site.battleship;

public class BattleshipMove implements java.io.Serializable {

	private static final long serialVersionUID = 1917476196024942196L;
	
	//private Long gameID;
	//private Long userID;
	private String loc;
	private String status;
	
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
		if (status == null) {
			if (other.status != null)
				return false;
		} else if (!status.equals(other.status))
			return false;
		return true;
	}
}