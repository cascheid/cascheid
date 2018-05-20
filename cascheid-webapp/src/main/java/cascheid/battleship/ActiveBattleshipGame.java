package cascheid.battleship;

import org.springframework.context.annotation.Scope;
import org.springframework.context.annotation.ScopedProxyMode;
import org.springframework.stereotype.Component;

import cascheid.identity.Identity;

@Component
@Scope(value="session", proxyMode= ScopedProxyMode.TARGET_CLASS)
public class ActiveBattleshipGame {

	private Identity activeOpponent;
	private Long gameID;
	private String status;
	private BattleshipBoard myBoard;
	private BattleshipBoard oppBoard;
	
	public Identity getActiveOpponent() {
		return activeOpponent;
	}
	public void setActiveOpponent(Identity activeOpponent) {
		this.activeOpponent = activeOpponent;
	}
	public Long getGameID() {
		return gameID;
	}
	public void setGameID(Long gameID) {
		this.gameID = gameID;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public BattleshipBoard getMyBoard() {
		return myBoard;
	}
	public void setMyBoard(BattleshipBoard myBoard) {
		this.myBoard = myBoard;
	}
	public BattleshipBoard getOppBoard() {
		return oppBoard;
	}
	public void setOppBoard(BattleshipBoard oppBoard) {
		this.oppBoard = oppBoard;
	}
}
