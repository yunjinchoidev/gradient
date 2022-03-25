package project5.attendance;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class AttendanceService {

	@Autowired
	AttendanceDao dao;
	
	
}
