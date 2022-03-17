package project5.kanban;

import java.util.List;

public interface KanbanDao {
	public List<KanbanVO> list();
	public List<KanbanVO> listWork();
	public KanbanVO individualMemberList(int memberkey);
	public KanbanVO individualProjectList();
	public void insert(KanbanVO vo);
	public void delete(int id);
	public void update(KanbanVO vo);
	public void update2(KanbanVO vo);
	
}
