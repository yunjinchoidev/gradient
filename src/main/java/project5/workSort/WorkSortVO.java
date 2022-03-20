package project5.workSort;

public class WorkSortVO {
	private int workSortKey;
	private String title;

	public WorkSortVO() {
		super();
		// TODO Auto-generated constructor stub
	}

	public WorkSortVO(int workSortKey, String title) {
		super();
		this.workSortKey = workSortKey;
		this.title = title;
	}

	public int getWorkSortKey() {
		return workSortKey;
	}

	public void setWorkSortKey(int workSortKey) {
		this.workSortKey = workSortKey;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

}
