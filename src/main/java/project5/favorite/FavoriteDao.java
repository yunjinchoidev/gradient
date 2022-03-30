package project5.favorite;

import java.util.List;

import org.springframework.stereotype.Repository;

@Repository
public interface FavoriteDao {

	public List<FavoriteVO> list();
	public void insert(String menubar);
	public void delete(String menubar);
	
}
