package cascheid.battleship;

public class BattleshipBoard implements java.io.Serializable {

	private static final long serialVersionUID = 2883160695590353870L;

	private String carrierLoc;
	private Boolean carrierVertical;
	private String battleshipLoc;
	private Boolean battleshipVertical;
	private String submarineLoc;
	private Boolean submarineVertical;
	private String destroyerLoc;
	private Boolean destroyerVertical;
	private String patrolLoc;
	private Boolean patrolVertical;
	
	public BattleshipBoard(){
	}
	
	public String getCarrierLoc() {
		return carrierLoc;
	}

	public void setCarrierLoc(String carrierLoc) {
		this.carrierLoc = carrierLoc;
	}

	public Boolean getCarrierVertical() {
		return carrierVertical;
	}

	public void setCarrierVertical(Boolean carrierVertical) {
		this.carrierVertical = carrierVertical;
	}

	public String getBattleshipLoc() {
		return battleshipLoc;
	}

	public void setBattleshipLoc(String battleshipLoc) {
		this.battleshipLoc = battleshipLoc;
	}

	public Boolean getBattleshipVertical() {
		return battleshipVertical;
	}

	public void setBattleshipVertical(Boolean battleshipVertical) {
		this.battleshipVertical = battleshipVertical;
	}

	public String getSubmarineLoc() {
		return submarineLoc;
	}

	public void setSubmarineLoc(String submarineLoc) {
		this.submarineLoc = submarineLoc;
	}

	public Boolean getSubmarineVertical() {
		return submarineVertical;
	}

	public void setSubmarineVertical(Boolean submarineVertical) {
		this.submarineVertical = submarineVertical;
	}

	public String getDestroyerLoc() {
		return destroyerLoc;
	}

	public void setDestroyerLoc(String destroyerLoc) {
		this.destroyerLoc = destroyerLoc;
	}

	public Boolean getDestroyerVertical() {
		return destroyerVertical;
	}

	public void setDestroyerVertical(Boolean destroyerVertical) {
		this.destroyerVertical = destroyerVertical;
	}

	public String getPatrolLoc() {
		return patrolLoc;
	}

	public void setPatrolLoc(String patrolLoc) {
		this.patrolLoc = patrolLoc;
	}

	public Boolean getPatrolVertical() {
		return patrolVertical;
	}

	public void setPatrolVertical(Boolean patrolVertical) {
		this.patrolVertical = patrolVertical;
	}

	public String checkHit(String loc){
		char row = loc.charAt(0);
		int col = Integer.parseInt(loc.substring(1));
		char compRow = carrierLoc.charAt(0);
		int compCol = Integer.parseInt(carrierLoc.substring(1));
		boolean compVert = carrierVertical;
		if (compVert){
			if (col==compCol){
				if (row>=compRow&&row<(compRow+5)){
					return "carrier";
				}
			}
		} else {
			if (row==compRow){
				if (col>=compCol&&col<(compCol+5)){
					return "carrier";
				}
			}
		}
		
		compRow = battleshipLoc.charAt(0);
		compCol = Integer.parseInt(battleshipLoc.substring(1));
		compVert = battleshipVertical;
		if (compVert){
			if (col==compCol){
				if (row>=compRow&&row<(compRow+4)){
					return "battleship";
				}
			}
		} else {
			if (row==compRow){
				if (col>=compCol&&col<(compCol+4)){
					return "battleship";
				}
			}
		}
		
		compRow = destroyerLoc.charAt(0);
		compCol = Integer.parseInt(destroyerLoc.substring(1));
		compVert = destroyerVertical;
		if (compVert){
			if (col==compCol){
				if (row>=compRow&&row<(compRow+3)){
					return "destroyer";
				}
			}
		} else {
			if (row==compRow){
				if (col>=compCol&&col<(compCol+3)){
					return "destroyer";
				}
			}
		}
		
		compRow = submarineLoc.charAt(0);
		compCol = Integer.parseInt(submarineLoc.substring(1));
		compVert = submarineVertical;
		if (compVert){
			if (col==compCol){
				if (row>=compRow&&row<(compRow+3)){
					return "submarine";
				}
			}
		} else {
			if (row==compRow){
				if (col>=compCol&&col<(compCol+3)){
					return "submarine";
				}
			}
		}
		
		compRow = patrolLoc.charAt(0);
		compCol = Integer.parseInt(patrolLoc.substring(1));
		compVert = patrolVertical;
		if (compVert){
			if (col==compCol){
				if (row>=compRow&&row<(compRow+2)){
					return "patrol";
				}
			}
		} else {
			if (row==compRow){
				if (col>=compCol&&col<(compCol+2)){
					return "patrol";
				}
			}
		}
		
		return "";
	}
}
