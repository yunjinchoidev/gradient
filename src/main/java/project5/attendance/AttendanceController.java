package project5.attendance;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import project5.member.MemberService;

@Controller
public class AttendanceController {

	@Autowired
	AttendanceService service;
	
	@Autowired
	MemberService service2;
	
	@RequestMapping("/attendanceMain.do")
	public String attendance(Model d) {
		d.addAttribute("list", service2.list());
		return "WEB-INF\\views\\attendance\\main.jsp";
	}
	
	
	
	
	
	
}
