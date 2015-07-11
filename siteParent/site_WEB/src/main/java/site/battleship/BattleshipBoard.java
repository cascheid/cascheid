package site.battleship;

public class BattleshipBoard implements java.io.Serializable {

	private static final long serialVersionUID = 2883160695590353870L;

	private String carrierLoc;
	private boolean carrierVertical;
	private String battleshipLoc;
	private boolean battleshipVertical;
	private String submarineLoc;
	private boolean submarineVertical;
	private String destroyerLoc;
	private boolean destroyerVertical;
	private String patrolLoc;
	private boolean patrolVertical;
	
	public BattleshipBoard(){
	}
	
	public String getCarrierLoc() {
		return carrierLoc;
	}
	public void setCarrierLoc(String carrierLoc) {
		this.carrierLoc = carrierLoc;
	}
	public boolean isCarrierVertical() {
		return carrierVertical;
	}
	public void setCarrierVertical(boolean carrierVertical) {
		this.carrierVertical = carrierVertical;
	}
	public String getBattleshipLoc() {
		return battleshipLoc;
	}
	public void setBattleshipLoc(String battleshipLoc) {
		this.battleshipLoc = battleshipLoc;
	}
	public boolean isBattleshipVertical() {
		return battleshipVertical;
	}
	public void setBattleshipVertical(boolean battleshipVertical) {
		this.battleshipVertical = battleshipVertical;
	}
	public String getSubmarineLoc() {
		return submarineLoc;
	}
	public void setSubmarineLoc(String submarineLoc) {
		this.submarineLoc = submarineLoc;
	}
	public boolean isSubmarineVertical() {
		return submarineVertical;
	}
	public void setSubmarineVertical(boolean submarineVertical) {
		this.submarineVertical = submarineVertical;
	}
	public String getDestroyerLoc() {
		return destroyerLoc;
	}
	public void setDestroyerLoc(String destroyerLoc) {
		this.destroyerLoc = destroyerLoc;
	}
	public boolean isDestroyerVertical() {
		return destroyerVertical;
	}
	public void setDestroyerVertical(boolean destroyerVertical) {
		this.destroyerVertical = destroyerVertical;
	}
	public String getPatrolLoc() {
		return patrolLoc;
	}
	public void setPatrolLoc(String patrolLoc) {
		this.patrolLoc = patrolLoc;
	}
	public boolean isPatrolVertical() {
		return patrolVertical;
	}
	public void setPatrolVertical(boolean patrolVertical) {
		this.patrolVertical = patrolVertical;
	}
}
