package project5.gantt;

import java.util.List;
import org.springframework.stereotype.Repository;

@Repository
public interface GanttDao {
	public List<GanttVO> list();
	public GanttVO individualMemberList();
	public GanttVO individualProjectList();
	public void insert(GanttVO vo);
	public void delete(int id);
	public void update(GanttVO vo);
	public void update2(GanttVO vo);

}
