package project5.workSort;

public class WorkSortVO {
	private int worksortkey;
	private String title;

	public WorkSortVO() {
		super();
		// TODO Auto-generated constructor stub
	}

	public WorkSortVO(int worksortkey, String title) {
		super();
		this.worksortkey = worksortkey;
		this.title = title;
	}

	public int getWorksortkey() {
		return worksortkey;
	}

	public void setWorksortkey(int worksortkey) {
		this.worksortkey = worksortkey;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

}
