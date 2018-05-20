package cascheid.view;

import org.springframework.context.annotation.Scope;
import org.springframework.context.annotation.ScopedProxyMode;
import org.springframework.stereotype.Component;

import cascheid.battleship.BattleshipGame;
import cascheid.identity.Identity;

@Component
@Scope(value="session", proxyMode= ScopedProxyMode.TARGET_CLASS)
public class ActiveBattleshipInfo {

	private Identity activeOpponent;
	private BattleshipGame activeGame;
	
	public Identity getActiveOpponent() {
		return activeOpponent;
	}
	public void setActiveOpponent(Identity activeOpponent) {
		this.activeOpponent = activeOpponent;
	}
	public BattleshipGame getActiveGame() {
		return activeGame;
	}
	public void setActiveGame(BattleshipGame activeGame) {
		this.activeGame = activeGame;
	}
}
