package project5.fullCalendar;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import oracle.net.aso.d;
import project5.member.MemberVO;
import project5.project.ProjectService;


@Controller
public class A20_FullCalController {

	@Autowired
	private A10_FullCalService service;
	
	
	@Autowired
	ProjectService service2;
	
	
	
	// http://localhost:7080/springweb/calendar.do
	@GetMapping("calendar.do")
	public String calendar(Model d, int projectkey) {
		d.addAttribute("project", service2.get(projectkey));
		return "WEB-INF\\views\\schedule\\fullCalendar.jsp";
	}

	@GetMapping("calendar2.do")
	public String calendar2(Model d, int projectkey) {
		d.addAttribute("project", service2.get(projectkey));
		return "WEB-INF\\views\\schedule\\fullCalendar2.jsp";
	}
	
	
	
	// http://localhost:7080/springweb/calList.do
	@RequestMapping("getCalendarListWithProjectkey.do")
	public String calList(Model d, int projectkey) {
		d.addAttribute("calList", service.getCalendarList(projectkey));	
		return "pageJsonReport";
	}

	@RequestMapping("getCalendarIndividaulList.do")
	public String calList(Model d, MemberVO vo) {
		d.addAttribute("calList", service.getCalendarIndividaulList(vo.getMemberkey()));	
		return "pageJsonReport";
	}
	
	
	
	
	
	@RequestMapping("insertCalendar")
	public String insertCalendar(Calendar ins, Model d){
		service.insertCalendar(ins);
		d.addAttribute("project", service2.get(ins.getProjectkey()));
		d.addAttribute("msg", "insertCalendar");
		//return "redirect:/calendar.do";
		return "WEB-INF\\views\\schedule\\fullCalendar.jsp";
	}
	
	
	
	
	
	
	
	
	@RequestMapping("updateCalendar")
	public String updateCalendar(Calendar ins, Model d){
		System.out.println("수정 id:"+ins.getId());
		service.updateCalendar(ins);
		d.addAttribute("project", service2.get(ins.getProjectkey()));
		d.addAttribute("msg", "updateCalendar");
		//return "redirect:/calendar.do";
		return "WEB-INF\\views\\schedule\\fullCalendar.jsp";
		//return "redirect:/calendar.do";
	}
	
	
	
	
	
	
	
	@RequestMapping("deleteCalendar")
	public String deleteCalendar(@RequestParam("id") int id,Model d){
		System.out.println("삭제 id:"+id);
		d.addAttribute("project", service2.get(service.get(id).getProjectkey()));
		d.addAttribute("msg", "deleteCalendar");
		//return "redirect:/calendar.do";
		service.deleteCalendar(id);
		return "WEB-INF\\views\\schedule\\fullCalendar.jsp";
		//return "redirect:/calendar.do";
	}	
}
