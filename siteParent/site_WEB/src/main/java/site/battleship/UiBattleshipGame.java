package site.battleship;

public class UiBattleshipGame implements java.io.Serializable {
	
	private static final long serialVersionUID = -3477050083787057384L;
	
	private Long gameID;
	private String opponent;
	private String status;
	
	public UiBattleshipGame(){
	}

	public Long getGameID() {
		return gameID;
	}

	public void setGameID(Long gameID) {
		this.gameID = gameID;
	}

	public String getOpponent() {
		return opponent;
	}

	public void setOpponent(String opponent) {
		this.opponent = opponent;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
	
	
}