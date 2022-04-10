package project5.attendance;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import project5.member.MemberSch;
import project5.member.MemberService;
import project5.member.MemberVO;
import project5.project.ProjectService;

@Controller
public class AttendanceController {

	@Autowired
	AttendanceService service;
	
	@Autowired
	MemberService service2;
	
	@Autowired
	ProjectService service3;
	
	@RequestMapping("/forPM.do")
	public String forPM(Model d, MemberSch sch) {
		d.addAttribute("list3", service.listWithPagingComplete(sch));
		//return "pageJsonReport";
		return "WEB-INF\\views\\attendance\\forPM.jsp";
	}
	@RequestMapping("/attendanceMainComplete.do")
	public String attendance(Model d, MemberSch sch) {
		d.addAttribute("list", service.listWithPagingComplete(sch));
		//return "pageJsonReport";
		return "WEB-INF\\views\\attendance\\finish.jsp";
	}

	@RequestMapping("/attendanceMainNotComplete.do")
	public String attendanceMain2(Model d, MemberSch sch) {
		d.addAttribute("list", service2.listWithPaging(sch));
		//return "pageJsonReport";
		return "WEB-INF\\views\\attendance\\notComplete.jsp";
	}

	
	
	
	
	
	@RequestMapping("/attendanceWriteForm.do")
	public String attendanceWriteForm(Model d, int memberkey) {
		d.addAttribute("get", service2.get(memberkey));
		return "WEB-INF\\views\\attendance\\writeForm.jsp";
	}
	
	@RequestMapping("/attendanceWrite.do")
	public String attendanceWrite(Model d, MemberVO vo) {
		service.attendanceWrite(vo);
		d.addAttribute("msg", "attendanceWrite");
		return "WEB-INF\\views\\attendance\\complete.jsp";
	}

	@RequestMapping("/warningLetter.do")
	public String WarningLetter(Model d, int memberkey) {
		d.addAttribute("get", service2.get(memberkey));
		return "WEB-INF\\views\\mail\\warningLetter.jsp";
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
