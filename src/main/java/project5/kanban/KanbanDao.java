package project5.kanban;

import java.util.List;

import project5.gantt.GanttSch;
import project5.gantt.GanttVO;

public interface KanbanDao {
	public List<KanbanVO> list(int projectkey);
	public List<KanbanVO> listWork();
	public List<KanbanVO> individualMemberList(int memberkey);
	public List<KanbanVO> individualProjectList();
	
	
	public void insert(KanbanVO vo);
	public void delete(KanbanVO vo);
	public void update(KanbanVO vo);
	public void update2(KanbanVO vo);

	
	public List<KanbanVO> listWithPaging(KanbanSch sch);
	public int totCnt(KanbanSch sch);
	
	public KanbanVO get(int id);
	
	
	
	
}
