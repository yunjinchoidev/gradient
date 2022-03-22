package project5.dashBoard;

public class OutputDashBoardVO {
	private int worksortkey;
	private int count;

	public OutputDashBoardVO() {
		super();
		// TODO Auto-generated constructor stub
	}

	public OutputDashBoardVO(int worksortkey, int count) {
		super();
		this.worksortkey = worksortkey;
		this.count = count;
	}

	public int getWorksortkey() {
		return worksortkey;
	}

	public void setWorksortkey(int worksortkey) {
		this.worksortkey = worksortkey;
	}

	public int getCount() {
		return count;
	}

	public void setCount(int count) {
		this.count = count;
	}

}
