package site.battleship;

public class BattleshipGame implements java.io.Serializable {
	
	private static final long serialVersionUID = 7039405534593210434L;
	
	private Long gameID;
	private String user1;
	private String user2;
	private String status;
	
	public BattleshipGame(){
	}

	public Long getGameID() {
		return gameID;
	}

	public void setGameID(Long gameID) {
		this.gameID = gameID;
	}

	public String getUser1() {
		return user1;
	}

	public void setUser1(String user1) {
		this.user1 = user1;
	}

	public String getUser2() {
		return user2;
	}

	public void setUser2(String user2) {
		this.user2 = user2;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
	
	
}