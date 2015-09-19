package site.blitzball;

import java.io.Serializable;

public class TeamName implements Serializable{
	private static final long serialVersionUID = -2442345086111021596L;
	
	private String town;
	private String mascot;
	
	public TeamName(){}
	public String getTown() {
		return town;
	}
	public void setTown(String town) {
		this.town = town;
	}
	public String getMascot() {
		return mascot;
	}
	public void setMascot(String mascot) {
		this.mascot = mascot;
	}
	public String getFullTeamName(){
		return town+" "+mascot;
	}
	public String checkValid(){
		if (town==null||town.equals("")){
			return "Hometown cannot be empty.";
		} else if (town.length()>20){
			return "Hometown must be less than 20 characters.";
		} else if (mascot==null||mascot.equals("")){
			return "Team name/logo is required.";
		} else return null;
	}
}
