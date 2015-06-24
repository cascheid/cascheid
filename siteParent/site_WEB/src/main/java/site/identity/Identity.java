package site.identity;

import site.racinggame.RacingGame;
import site.racinggame.RacingGameUtils;

public class Identity implements java.io.Serializable{

	private static final long serialVersionUID = 8230463793128406968L;
	
	private Long identifier;
	private Long racingGameIdentifier;
	private Integer snakeScore;
	//private RacingGame racingGame;	
	//private SnakeGame snakeGame;
	
	public Identity(){
	}
	
	public Identity(Long identifier){
		this.identifier=identifier;
	}
	
	public Identity(Long identifier, Long racingGameIdentifier){
		this.identifier=identifier;
		this.racingGameIdentifier=racingGameIdentifier;
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
}
