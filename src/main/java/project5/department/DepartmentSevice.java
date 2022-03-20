package project5.department;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class DepartmentSevice {

	@Autowired
	DepartmentDao dao;
	
	public List<DepartmentVO> list(){
		return dao.list();
	}
}
