package site.blitzball;

import java.util.ArrayList;
import java.util.Arrays;

public class BlitzballMockData {

	public static BlitzballTeam getTeam1(){
		BlitzballTeam team = new BlitzballTeam();
		team.setTeamID(1l);
		team.setLeftWing(getLeftWing(1l));
		team.setRightWing(getRightWing(1l));
		team.setMidfielder(getMidfielder(1l));
		team.setLeftBack(getLeftBack(1l));
		team.setRightBack(getRightBack(1l));
		team.setKeeper(getKeeper(1l));
		return team;
	}

	public static BlitzballTeam getTeam2(){
		BlitzballTeam team = new BlitzballTeam();
		team.setTeamID(1l);
		team.setLeftWing(getLeftWing(2l));
		team.setRightWing(getRightWing(2l));
		team.setMidfielder(getMidfielder(2l));
		team.setLeftBack(getLeftBack(2l));
		team.setRightBack(getRightBack(2l));
		team.setKeeper(getKeeper(2l));
		return team;
	}
	
	public static BlitzballPlayer getLeftWing(Long teamID){
		BlitzballPlayer player = new BlitzballPlayer();
		player.setPlayerID(teamID==1l?101:1);
		player.setLevel(3);
		player.setTeamID(teamID);
		player.setName("Left Wing");
		player.setNextExp(5);
		player.setSpeed(62);
		player.setEndurance(11);
		player.setHp(220);
		player.setAttack(5);
		player.setPass(6);
		player.setShot(11);
		player.setBlock(3);
		player.setCat(1);
		player.setContractLength(10);
		player.setModel("leftwing.dae");
		player.setLearnedTechs(Arrays.asList(1));
		player.setLearnableTechs(Arrays.asList(2, 4));
		player.setTech1(getShotTech());
		return player;
	}
	
	public static BlitzballPlayer getRightWing(Long teamID){
		BlitzballPlayer player = new BlitzballPlayer();
		player.setPlayerID(teamID==1l?102:2);
		player.setLevel(4);
		player.setTeamID(teamID);
		player.setName("Right Wing");
		player.setNextExp(5);
		player.setSpeed(70);
		player.setEndurance(10);
		player.setHp(220);
		player.setAttack(5);
		player.setPass(9);
		player.setShot(12);
		player.setBlock(3);
		player.setCat(1);
		player.setContractLength(10);
		player.setModel("rightwing.dae");
		player.setLearnedTechs(Arrays.asList(1));
		player.setLearnableTechs(Arrays.asList(2, 3));
		player.setTech1(getShotTech());
		return player;
	}
	
	public static BlitzballPlayer getMidfielder(Long teamID){
		BlitzballPlayer player = new BlitzballPlayer();
		player.setPlayerID(teamID==1l?103:3);
		player.setLevel(4);
		player.setTeamID(teamID);
		player.setName("Midfielder");
		player.setNextExp(5);
		player.setSpeed(75);
		player.setEndurance(8);
		player.setHp(220);
		player.setAttack(8);
		player.setPass(15);
		player.setShot(7);
		player.setBlock(3);
		player.setCat(1);
		player.setContractLength(10);
		player.setModel("midfielder.dae");
		player.setLearnedTechs(Arrays.asList(2));
		player.setLearnableTechs(Arrays.asList(1));
		player.setTech1(getPassTech());
		return player;
	}
	
	public static BlitzballPlayer getLeftBack(Long teamID){
		BlitzballPlayer player = new BlitzballPlayer();
		player.setPlayerID(teamID==1l?104:4);
		player.setLevel(3);
		player.setTeamID(teamID);
		player.setName("Left Back");
		player.setNextExp(5);
		player.setSpeed(62);
		player.setEndurance(4);
		player.setHp(220);
		player.setAttack(10);
		player.setPass(9);
		player.setShot(3);
		player.setBlock(6);
		player.setCat(2);
		player.setContractLength(10);
		player.setModel("leftback.dae");
		player.setLearnedTechs(Arrays.asList(3));
		player.setLearnableTechs(Arrays.asList(1));
		player.setTech1(getAttackTech());
		return player;
	}
	
	public static BlitzballPlayer getRightBack(Long teamID){
		BlitzballPlayer player = new BlitzballPlayer();
		player.setPlayerID(teamID==1l?105:5);
		player.setLevel(4);
		player.setTeamID(teamID);
		player.setName("Right Back");
		player.setNextExp(5);
		player.setSpeed(62);
		player.setEndurance(5);
		player.setHp(220);
		player.setAttack(10);
		player.setPass(6);
		player.setShot(3);
		player.setBlock(7);
		player.setCat(2);
		player.setContractLength(10);
		player.setModel("rightback.dae");
		player.setLearnedTechs(Arrays.asList(3));
		player.setLearnableTechs(Arrays.asList(2));
		player.setTech1(getAttackTech());
		return player;
	}
	
	public static BlitzballPlayer getKeeper(Long teamID){
		BlitzballPlayer player = new BlitzballPlayer();
		player.setPlayerID(teamID==1l?106:6);
		player.setLevel(5);
		player.setTeamID(teamID);
		player.setName("Keeper");
		player.setNextExp(5);
		player.setSpeed(61);
		player.setEndurance(3);
		player.setHp(220);
		player.setAttack(6);
		player.setPass(4);
		player.setShot(3);
		player.setBlock(6);
		player.setCat(9);
		player.setContractLength(10);
		player.setModel("keeper.dae");
		player.setLearnedTechs(Arrays.asList(4));
		player.setLearnableTechs(Arrays.asList(2));
		player.setTech1(getGoalieTech());
		return player;
	}
	
	public static BlitzballTech getShotTech(){
		BlitzballTech tech = new BlitzballTech();
		tech.setTechID(1);
		tech.setTechName("Venom Shot");
		tech.setTechDescription("Venom Shot Desc");
		tech.setTechType("SHOT");
		tech.setHpCost(80);
		tech.setStatMod(3);
		return tech;
	}
	
	public static BlitzballTech getPassTech(){
		BlitzballTech tech = new BlitzballTech();
		tech.setTechID(2);
		tech.setTechName("Nap Pass");
		tech.setTechDescription("Nap Pass Desc");
		tech.setTechType("PASS");
		tech.setHpCost(80);
		tech.setStatMod(3);
		return tech;
	}
	
	public static BlitzballTech getAttackTech(){
		BlitzballTech tech = new BlitzballTech();
		tech.setTechID(3);
		tech.setTechName("Wither Tackle");
		tech.setTechDescription("Wither Tackle Desc");
		tech.setTechType("ATTACK");
		tech.setHpCost(60);
		tech.setStatMod(3);
		return tech;
	}
	
	public static BlitzballTech getGoalieTech(){
		BlitzballTech tech = new BlitzballTech();
		tech.setTechID(4);
		tech.setTechName("Super Goalie");
		tech.setTechDescription("Super Goalie Desc");
		tech.setTechType("SPECIAL");
		tech.setHpCost(60);
		tech.setStatMod(3);
		return tech;
	}
}
