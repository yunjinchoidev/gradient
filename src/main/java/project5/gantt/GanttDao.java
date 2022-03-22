package project5.gantt;

import java.util.List;
import org.springframework.stereotype.Repository;

@Repository
public interface GanttDao {
	public List<GanttVO> list();
	public List<GanttVO> currentGantt();
	public List<GanttVO> currentGanttbymkey(int memberkey);
	public List<GanttVO> individualMemberList(int memberkey);
	public List<GanttVO> individualProjectList();
	public void insert(GanttVO vo);
	public void delete(int id);
	public void update(GanttVO vo);
	public void update2(GanttVO vo);

}
