package project5.project;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ProjectService {

	@Autowired
	ProjectDao dao;

	public List<ProjectVO> getList() {
		return dao.getList();
	}

	public void insert(ProjectVO vo) {
		 dao.insert(vo);
	}

}
