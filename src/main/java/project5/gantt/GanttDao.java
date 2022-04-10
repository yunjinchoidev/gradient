package project5.gantt;

import java.util.List;
import org.springframework.stereotype.Repository;

import project5.fullCalendar.Calendar;
import project5.fullCalendar.CalendarSch;

@Repository
public interface GanttDao {
	public List<GanttVO> list(int projectkey);
	public List<GanttVO> currentGantt();
	public List<GanttVO> currentGanttbymkey(int memberkey);
	public List<GanttVO> individualMemberList(int memberkey);
	public List<GanttVO> individualProjectList();
	public void insert(GanttVO vo);
	public void delete(int id);
	public void update(GanttVO vo);
	public void update2(GanttVO vo);
	
	public List<GanttVO> listWithPaging(GanttSch sch);
	public int totCnt(GanttSch sch);
	
	

}
