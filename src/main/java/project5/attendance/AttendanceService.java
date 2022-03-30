package project5.attendance;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class AttendanceService {

	@Autowired
	AttendanceDao dao;
	
	
	public void attendanceWrite(AttendanceVO vo) {
		dao.attendanceWrite(vo);
	}
	public List<AttendanceVO2> memberPlusAttendacne(){
		return dao.memberPlusAttendacne();
	}
	
}
