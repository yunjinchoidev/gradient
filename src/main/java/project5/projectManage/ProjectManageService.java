package project5.projectManage;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ProjectManageService {

	@Autowired
	ProjectManageDao dao;

	public List<ProjectManageVO> list() {
		return dao.list();
	}
	public void progressUpdate(ProjectManageVO vo) {
		dao.progressUpdate(vo);
	}
	
	public ProjectManageVO get(int projectkey) {
		return dao.get(projectkey);
	}
}