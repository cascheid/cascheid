package site.identity;

import org.springframework.beans.BeanUtils;
import org.springframework.context.annotation.Scope;
import org.springframework.context.annotation.ScopedProxyMode;
import org.springframework.stereotype.Component;

import site.racinggame.RacingGame;

@Component
@Scope(value="session", proxyMode= ScopedProxyMode.TARGET_CLASS)
public class Identity implements java.io.Serializable{

	private static final long serialVersionUID = 8230463793128406968L;
	
	private Long identifier;
	private Long racingGameIdentifier;
	private Integer snakeScore;
	private String username;
	private RacingGame racingGame;
	
	public Identity(){
	}
	
	public Long getIdentifier(){
		return identifier;
	}
	
	public void setIdentifier(Long identifier){
		this.identifier=identifier;
	}

	public Long getRacingGameIdentifier() {
		return racingGameIdentifier;
	}

	public void setRacingGameIdentifier(Long racingGameIdentifier) {
		this.racingGameIdentifier = racingGameIdentifier;
	}

	public Integer getSnakeScore() {
		return snakeScore;
	}

	public void setSnakeScore(Integer snakeScore) {
		this.snakeScore = snakeScore;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}
	
	public RacingGame getRacingGame() {
		return racingGame;
	}

	public void setRacingGame(RacingGame racingGame) {
		this.racingGame = racingGame;
	}

	public void updateIdentity(Identity newIdentity){
		BeanUtils.copyProperties(newIdentity, this, Identity.class);
	}
	
	public IdentityView getIdentityView(){
		IdentityView view = new IdentityView();
		view.setSnakeScore(this.snakeScore);
		view.setUsername(this.username);
		return view;
	}
}
