package site.battleship;

public class BattleshipGame implements java.io.Serializable {
	
	private static final long serialVersionUID = 7039405534593210434L;
	
	private Long gameID;
	private Long user1;
	private Long user2;
	private String status;
	
	public BattleshipGame(){
	}

	public Long getGameID() {
		return gameID;
	}

	public void setGameID(Long gameID) {
		this.gameID = gameID;
	}

	public Long getUser1() {
		return user1;
	}

	public void setUser1(Long user1) {
		this.user1 = user1;
	}

	public Long getUser2() {
		return user2;
	}

	public void setUser2(Long user2) {
		this.user2 = user2;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
	
	
}