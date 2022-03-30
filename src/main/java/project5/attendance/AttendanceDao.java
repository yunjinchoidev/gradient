package project5.attendance;

import java.util.List;

import org.springframework.stereotype.Repository;

@Repository
public interface AttendanceDao {
	
	public void attendanceWrite(AttendanceVO vo);
	
	public List<AttendanceVO2> memberPlusAttendacne();

}
