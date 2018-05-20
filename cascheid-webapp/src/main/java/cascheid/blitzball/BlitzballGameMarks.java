package cascheid.blitzball;

public class BlitzballGameMarks implements java.io.Serializable {

	private static final long serialVersionUID = 8392305813020246664L;

	private Integer leftWingTarget;
	private Integer rightWingTarget;
	private Integer midfielderTarget;
	private Integer leftBackTarget;
	private Integer rightBackTarget;
	private Integer keeperTarget;
	
	public BlitzballGameMarks(){
		leftWingTarget=0;
		rightWingTarget=0;
		midfielderTarget=0;
		leftBackTarget=0;
		rightBackTarget=0;
		keeperTarget=0;
	}

	public Integer getLeftWingTarget() {
		return leftWingTarget;
	}
	public void setLeftWingTarget(Integer leftWingTarget) {
		this.leftWingTarget = leftWingTarget;
	}
	public Integer getRightWingTarget() {
		return rightWingTarget;
	}
	public void setRightWingTarget(Integer rightWingTarget) {
		this.rightWingTarget = rightWingTarget;
	}
	public Integer getMidfielderTarget() {
		return midfielderTarget;
	}
	public void setMidfielderTarget(Integer midfielderTarget) {
		this.midfielderTarget = midfielderTarget;
	}
	public Integer getLeftBackTarget() {
		return leftBackTarget;
	}
	public void setLeftBackTarget(Integer leftBackTarget) {
		this.leftBackTarget = leftBackTarget;
	}
	public Integer getRightBackTarget() {
		return rightBackTarget;
	}
	public void setRightBackTarget(Integer rightBackTarget) {
		this.rightBackTarget = rightBackTarget;
	}
	public Integer getKeeperTarget() {
		return keeperTarget;
	}
	public void setKeeperTarget(Integer keeperTarget) {
		this.keeperTarget = keeperTarget;
	}
}
