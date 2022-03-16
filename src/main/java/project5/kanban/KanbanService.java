package project5.kanban;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class KanbanService {

	@Autowired
	private KanbanDao dao;

	public List<KanbanVO> list() {
		return dao.list();
	}

	public KanbanVO individualMemberList() {
		return dao.individualMemberList();
	}

	public KanbanVO individualProjectList() {
		return dao.individualProjectList();
	}
	
	public void insert(KanbanVO vo) {
		dao.insert(vo);
	}
	
	public void delete(int id) {
		dao.delete(id);
	};
	
	public void update(KanbanVO vo) {
		dao.update(vo);
	}
	public void update2(KanbanVO vo) {
		dao.update(vo);
	}
	
	

}
