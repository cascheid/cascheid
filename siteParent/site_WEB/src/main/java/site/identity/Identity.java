package site.identity;

import site.racinggame.RacingGame;
import site.racinggame.RacingGameUtils;

public class Identity implements java.io.Serializable{

	private static final long serialVersionUID = 8230463793128406968L;
	
	private Long identifier;
	private Long racingGameIdentifier;
	//private RacingGame racingGame;	
	//private SnakeGame snakeGame;
	
	public Identity(){
		this.identifier=IdentityUtils.getRandomIdentifier();
	}
	
	public Identity(Long identifier){
		this.identifier=identifier;
	}
	
	public Identity(Long identifier, Long racingGameIdentifier){
		this.identifier=identifier;
	}
	
	public Long getIdentifier(){
		return identifier;
	}
	
	public RacingGame getRacingGameObject(){
		return RacingGameUtils.getRacingGameObject(racingGameIdentifier);
	}

	public Long getRacingGameIdentifier() {
		return racingGameIdentifier;
	}

	public void setRacingGameIdentifier(Long racingGameIdentifier) {
		this.racingGameIdentifier = racingGameIdentifier;
	}
}
