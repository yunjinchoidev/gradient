package project5.favorite;

public class FavoriteVO {
	private int favoritekey;
	private String menubar;
	private int status;

	public FavoriteVO() {
		super();
		// TODO Auto-generated constructor stub
	}

	public FavoriteVO(int favoritekey, String menubar, int status) {
		super();
		this.favoritekey = favoritekey;
		this.menubar = menubar;
		this.status = status;
	}

	public int getFavoritekey() {
		return favoritekey;
	}

	public void setFavoritekey(int favoritekey) {
		this.favoritekey = favoritekey;
	}

	public String getMenubar() {
		return menubar;
	}

	public void setMenubar(String menubar) {
		this.menubar = menubar;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

}
