package project5.project;

import java.util.List;

import org.springframework.stereotype.Repository;

@Repository
public interface ProjectDao {
	public List<ProjectVO> list();
	public ProjectVO get(int projectkey);
	public List<ProjectVO> get2(List<Integer> list);
	public void insert(ProjectVO vo);
	public void update(ProjectVO vo);
	public void progressUpdate(ProjectVO vo);
	public void delete(int projectkey);
}
