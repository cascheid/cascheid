package cascheid.blitzball;

public class BlitzballGameRoster implements java.io.Serializable {

	private static final long serialVersionUID = 2769942722422480345L;

	private Integer rightWing;
	private Integer leftWing;
	private Integer midfielder;
	private Integer rightBack;
	private Integer leftBack;
	private Integer keeper;
	
	public BlitzballGameRoster(){}
	
	public Integer getRightWing() {
		return rightWing;
	}
	public void setRightWing(Integer rightWing) {
		this.rightWing = rightWing;
	}
	public Integer getLeftWing() {
		return leftWing;
	}
	public void setLeftWing(Integer leftWing) {
		this.leftWing = leftWing;
	}
	public Integer getMidfielder() {
		return midfielder;
	}
	public void setMidfielder(Integer midfielder) {
		this.midfielder = midfielder;
	}
	public Integer getRightBack() {
		return rightBack;
	}
	public void setRightBack(Integer rightBack) {
		this.rightBack = rightBack;
	}
	public Integer getLeftBack() {
		return leftBack;
	}
	public void setLeftBack(Integer leftBack) {
		this.leftBack = leftBack;
	}
	public Integer getKeeper() {
		return keeper;
	}
	public void setKeeper(Integer keeper) {
		this.keeper = keeper;
	}
}
