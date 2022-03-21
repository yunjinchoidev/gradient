package project5.fullCalendar;

import java.util.List;

import org.springframework.stereotype.Repository;


@Repository
public interface A10_FullCalDao {
	public List<Calendar> getCalendarList();
	public List<Calendar> getCalendarIndividaulList(int memberkey);
	public List<Calendar> mywork(int memberkey);
	public Calendar get(int id);
	
	
	
	public void insertCalendar(Calendar ins);
	public void updateCalendar(Calendar upt);
	public void deleteCalendar(int id);	
}
