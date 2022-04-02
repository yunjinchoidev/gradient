package project5.fullCalendar;

import java.util.List;

import org.springframework.stereotype.Repository;

import project5.member.MemberSch;
import project5.member.MemberVO;


@Repository
public interface A10_FullCalDao {
	public List<Calendar> getCalendarList();
	public List<Calendar> getCalendarIndividaulList(int memberkey);
	public List<Calendar> mywork(int memberkey);
	public Calendar get(int id);
	
	
	
	public void insertCalendar(Calendar ins);
	public void updateCalendar(Calendar upt);
	public void deleteCalendar(int id);	
	
	public List<Calendar> listWithPaging(CalendarSch sch);
	public int totCnt(CalendarSch sch);
	
	
	
}
