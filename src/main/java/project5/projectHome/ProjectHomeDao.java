package project5.projectHome;

import java.util.List;

import org.springframework.stereotype.Repository;

import project5.workSort.WorkSortVO;


@Repository
public interface ProjectHomeDao {
	public List<ProjectHomeVO> getList(int projectkey);
	public void insert(ProjectHomeVO vo);
	public ProjectHomeVO get(int projectHomekey);
	public void delete(int projectHomekey);
	public void update(ProjectHomeVO vo);
	public List<WorkSortVO> getWorkSortList();
}
