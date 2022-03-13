package project5.fullCalendar;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


@Service
public class A10_FullCalService {
	@Autowired
	private A10_FullCalDao dao;
	
	public List<Calendar> getCalendarList(){
		return dao.getCalendarList();
	}
	public void insertCalendar(Calendar ins) {
		dao.insertCalendar(ins);
	}
	public void updateCalendar(Calendar upt) {
		dao.updateCalendar(upt);
	}
	public void deleteCalendar(int id) {
		dao.deleteCalendar(id);
	}
	
}
