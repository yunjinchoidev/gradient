package project5.gantt;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import project5.fullCalendar.Calendar;
import project5.fullCalendar.CalendarSch;

@Service
public class GanttService {
	
	@Autowired
	private GanttDao dao;

	public List<GanttVO> list(int projectkey) {
		return dao.list(projectkey);
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
	
	
	
	
	
	public List<GanttVO> ganttlistWithPaging(GanttSch sch) {

		// 1. 전체 라인 수
		sch.setCount(dao.totCnt(sch));

		// 2. 페이지 사이즈(페이퍼 크기)
		if (sch.getPageSize() == 0) {
			sch.setPageSize(5);
		}

		// 3. 총 페이지 수
		double totPage1 = sch.getCount() / (double) sch.getPageSize();
		totPage1 = Math.ceil(totPage1); // 올림 처리..
		int totPage = (int) (totPage1);
		sch.setPageCount(totPage);

		// 4. 현재 페이지
		if (sch.getCurPage() == 0) {
			sch.setCurPage(1);
		}

		// 5. 한 페이지의 맨 위에 있는 라인 키
		sch.setStart((sch.getCurPage() - 1) * sch.getPageSize() + 1);

		// 6. 한 페이지 마지막 줄에 있는 라인 키
		sch.setEnd(sch.getCurPage() * sch.getPageSize());

		// 7. 블락 키
		sch.setBlockSize(5);

		int curBlockGrpNo = (int) Math.ceil(sch.getCurPage() / (double) sch.getBlockSize());

		// 8. 시작 블럭
		sch.setStartBlock((curBlockGrpNo - 1) * sch.getBlockSize() + 1);
		int endBlockGrpNo = curBlockGrpNo * sch.getBlockSize();

		// 9. 마지막 블럭
		sch.setEndBlock(endBlockGrpNo > sch.getPageCount() ? sch.getPageCount() : endBlockGrpNo);

		return dao.listWithPaging(sch);

	}

	public int totCnt(GanttSch sch) {

		return dao.totCnt(sch);
	}

	public GanttVO get(int id) {
		return dao.get(id);
	}
	
}
