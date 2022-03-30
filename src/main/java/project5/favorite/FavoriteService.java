package project5.favorite;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class FavoriteService {

	@Autowired
	FavoriteDao dao;

	public List<FavoriteVO> list(){
		return dao.list();
	}
	
	public void insert(String menubar) {
		dao.insert(menubar);
	}
	
	public void delete(String menubar) {
		dao.delete(menubar);
	}
	
	
	
}
