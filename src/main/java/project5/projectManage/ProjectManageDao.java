package project5.projectManage;

import java.util.List;

import org.springframework.stereotype.Repository;

@Repository
public interface ProjectManageDao {
	public List<ProjectManageVO> list();
	public void progressUpdate(ProjectManageVO vo);
	public ProjectManageVO get(int projectkey);

}
