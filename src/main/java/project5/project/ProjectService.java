package project5.project;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ProjectService {

	@Autowired
	ProjectDao dao;

	public List<ProjectVO> list() {
		return dao.list();
	}
	
	public ProjectVO get(int projectkey) {
		return dao.get(projectkey);
	}
	
	public List<ProjectVO> get2(List<Integer> list){
		return dao.get2(list);
	}


}
