package project5.kanban;

import java.util.List;

public interface KanbanDao {
	public List<KanbanVO> list();
	public List<KanbanVO> listWork();
	public List<KanbanVO> individualMemberList(int memberkey);
	public List<KanbanVO> individualProjectList();
	public void insert(KanbanVO vo);
	public void delete(int id);
	public void update(KanbanVO vo);
	public void update2(KanbanVO vo);
	
}
