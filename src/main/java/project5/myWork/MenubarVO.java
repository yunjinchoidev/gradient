package project5.myWork;

public class MenubarVO {
	private int menubarkey;
	private String title;

	public MenubarVO() {
		super();
		// TODO Auto-generated constructor stub
	}

	public MenubarVO(int menubarkey, String title) {
		super();
		this.menubarkey = menubarkey;
		this.title = title;
	}

	public int getMenubarkey() {
		return menubarkey;
	}

	public void setMenubarkey(int menubarkey) {
		this.menubarkey = menubarkey;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

}
