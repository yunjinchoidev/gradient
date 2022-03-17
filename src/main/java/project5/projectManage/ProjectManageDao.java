package project5.projectManage;

import java.util.List;

import org.springframework.stereotype.Repository;

@Repository
public interface ProjectManageDao {
	public List<ProjectManageVO> list();
	
}
