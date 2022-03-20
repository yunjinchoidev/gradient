package project5.department;

import java.util.List;

import org.springframework.stereotype.Repository;

@Repository
public interface DepartmentDao {

	public List<DepartmentVO> list();
	
}
