package project5.project;

import java.util.List;

import org.springframework.stereotype.Repository;

import project5.output.OutputSch;
import project5.output.OutputVO;

@Repository
public interface ProjectDao {
	public List<ProjectVO> list();
	public List<ProjectVO> listWithPaging(ProjectSch sch);
	public int totCnt(ProjectSch sch);
	
	
	
	
	public ProjectVO get(int projectkey);
	public List<ProjectVO> get2(List<Integer> list);
	public void insert(ProjectVO vo);
	public void update(ProjectVO vo);
	public void progressUpdate(ProjectVO vo);
	public void delete(int projectkey);
	
	public List<ProjectVO> progressCnt();
	public List<ProjectVO> projectTeamCnt();
	
}
