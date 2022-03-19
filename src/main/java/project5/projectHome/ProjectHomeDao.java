package project5.projectHome;

import java.util.List;

import org.springframework.stereotype.Repository;

import project5.notice.NoticeSch;
import project5.notice.NoticeVO;
import project5.notice.NoticeVO2;
import project5.projectManage.ProjectManageVO;


@Repository
public interface ProjectHomeDao {
	public List<ProjectHomeVO> getList();
	public void insert(ProjectHomeVO vo);
	public ProjectHomeVO get(int projectHomekey);
	public void delete(int projectHomekey);
	public void update(ProjectHomeVO vo);
}
