package project5.dept;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class DeptService {

	@Autowired
	DeptDao dao;
	
	public List<DeptVO> getList() {
		return dao.getList();
	}

}
