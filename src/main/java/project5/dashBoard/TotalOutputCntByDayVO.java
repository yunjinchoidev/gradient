package project5.dashBoard;

public class TotalOutputCntByDayVO {

	private String writedate;
	private int count;

	public TotalOutputCntByDayVO() {
		super();
		// TODO Auto-generated constructor stub
	}

	public TotalOutputCntByDayVO(String writedate, int count) {
		super();
		this.writedate = writedate;
		this.count = count;
	}

	public String getWritedate() {
		return writedate;
	}

	public void setWritedate(String writedate) {
		this.writedate = writedate;
	}

	public int getCount() {
		return count;
	}

	public void setCount(int count) {
		this.count = count;
	}

}
