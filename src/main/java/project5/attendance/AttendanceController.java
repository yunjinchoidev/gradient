package project5.attendance;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import project5.member.MemberService;
import project5.project.ProjectService;

@Controller
public class AttendanceController {

	@Autowired
	AttendanceService service;
	
	@Autowired
	MemberService service2;
	
	@Autowired
	ProjectService service3;
	
	@RequestMapping("/attendanceMain.do")
	public String attendance(Model d, int projectkey) {
		d.addAttribute("project", service3.get(projectkey));
		d.addAttribute("list", service.memberPlusAttendacne());
		return "WEB-INF\\views\\attendance\\main.jsp";
	}

	@RequestMapping("/attendanceMain2.do")
	public String attendanceMain2(Model d) {
		d.addAttribute("list", service2.list());
		return "WEB-INF\\views\\attendance\\main2.jsp";
	}

	@RequestMapping("/attendanceWriteForm.do")
	public String attendanceWriteForm(Model d, int memberkey) {
		d.addAttribute("get", service2.get(memberkey));
		return "WEB-INF\\views\\attendance\\writeForm.jsp";
	}
	
	@RequestMapping("/attendanceWrite.do")
	public String attendanceWrite(Model d, AttendanceVO vo) {
		service.attendanceWrite(vo);
		return "forward:/attendanceMain.do";
	}

	@RequestMapping("/warningLetter.do")
	public String WarningLetter(Model d, int memberkey) {
		d.addAttribute("member", service2.get(memberkey));
		return "WEB-INF\\views\\mail\\warningLetter.jsp";
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
