package project5.projectHome;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ProjectHomeService {
	@Autowired
	ProjectHomeDao dao;

	public List<ProjectHomeVO> getList() {
		return dao.getList();
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
}
