package project5.workSort;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class WorkSortService {

	@Autowired
	WorkSortDao dao;
	
	public List<WorkSortVO> list(){
		return dao.list();
	}
	
}
