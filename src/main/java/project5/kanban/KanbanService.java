package project5.kanban;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class KanbanService {

	@Autowired
	private KanbanDao dao;

	public List<KanbanVO> list(int projectkey) {
		return dao.list(projectkey);
	}

	public List<KanbanVO> listWork(){
		return dao.listWork();
	}
	
	public List<KanbanVO> individualMemberList(int memberkey) {
		return dao.individualMemberList(memberkey);
	}

	public List<KanbanVO> individualProjectList() {
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
