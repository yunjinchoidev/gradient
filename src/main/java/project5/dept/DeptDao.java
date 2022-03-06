package project5.dept;

import java.util.List;

import org.springframework.stereotype.Repository;

@Repository
public interface DeptDao {
	public List<DeptVO> getList();
}
