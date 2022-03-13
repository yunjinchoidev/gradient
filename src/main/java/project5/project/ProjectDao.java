package project5.project;

import java.util.List;

import org.springframework.stereotype.Repository;

@Repository
public interface ProjectDao {
	public List<ProjectVO> list();
	
}
