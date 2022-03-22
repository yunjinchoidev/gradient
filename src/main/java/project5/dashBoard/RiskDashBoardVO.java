package project5.dashBoard;

public class RiskDashBoardVO {
	private String importance;
	private int count;
	public RiskDashBoardVO() {
		super();
		// TODO Auto-generated constructor stub
	}
	public RiskDashBoardVO(String importance, int count) {
		super();
		this.importance = importance;
		this.count = count;
	}
	public String getImportance() {
		return importance;
	}
	public void setImportance(String importance) {
		this.importance = importance;
	}
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
	
}
