package project5.favorite;

import java.util.List;

import org.springframework.stereotype.Repository;

@Repository
public interface FavoriteDao {

	public List<FavoriteVO> list();
	public void insert(FavoriteVO vo);
	public void delete(int favorkey);
	public void update(FavoriteVO vo);
	
}
