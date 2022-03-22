package project5.gantt;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class GanttService {
	
	@Autowired
	private GanttDao dao;

	public List<GanttVO> list() {
		return dao.list();
	}
	public List<GanttVO> currentGantt(){
		return dao.currentGantt();
	}
	
	
	public List<GanttVO> currentGanttbymkey(int memberkey){
		return dao.currentGanttbymkey(memberkey);
	}
	
	public List<GanttVO> individualMemberList(int memberkey ) {
		return dao.individualMemberList(memberkey);
	}

	public List<GanttVO> individualProjectList() {
		return dao.individualProjectList();
	}
	
	public void insert(GanttVO vo) {
		dao.insert(vo);
	}
	
	public void delete(int id) {
		dao.delete(id);
	};
	
	public void update(GanttVO vo) {
		dao.update(vo);
	}
	public void update2(GanttVO vo) {
		dao.update(vo);
	}
	
}
