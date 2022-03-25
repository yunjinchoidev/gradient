package project5.attendance;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class AttendanceController {

	@Autowired
	AttendanceService service;
	
	@RequestMapping("/attendanceMain.do")
	public String attendance(Model d) {
		return "WEB-INF\\views\\attendance\\main.jsp";
	}
	
	
	
	
	
	
}
