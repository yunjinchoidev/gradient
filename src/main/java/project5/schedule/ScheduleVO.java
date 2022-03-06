package project5.schedule;

public class ScheduleVO {
	private String name;
	private String title;
	private String contents;

	public ScheduleVO() {
		super();
		// TODO Auto-generated constructor stub
	}

	public ScheduleVO(String name, String title, String contents) {
		super();
		this.name = name;
		this.title = title;
		this.contents = contents;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContents() {
		return contents;
	}

	public void setContents(String contents) {
		this.contents = contents;
	}

}