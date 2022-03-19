package project5.projectHome;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import project5.workSort.WorkSortVO;

@Service
public class ProjectHomeService {
	@Autowired
	ProjectHomeDao dao;

	public List<ProjectHomeVO> getList(int projectkey) {
		return dao.getList(projectkey);
	}

	public void insert(ProjectHomeVO vo) {
		dao.insert(vo);
	}

	public ProjectHomeVO get(int projectHomekey) {
		return dao.get(projectHomekey);
	}

	public void delete(int projectHomekey) {
		dao.delete(projectHomekey);
	}

	public void update(ProjectHomeVO vo) {
		dao.update(vo);
	}
	
	public List<WorkSortVO> getWorkSortList(){
		return dao.getWorkSortList();
	}
}
