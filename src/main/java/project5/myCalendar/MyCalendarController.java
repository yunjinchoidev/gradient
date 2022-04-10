package project5.myCalendar;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import project5.fullCalendar.A10_FullCalService;
import project5.fullCalendar.Calendar;

@Controller
public class MyCalendarController {

	@Autowired
	A10_FullCalService service;
	
	
	@RequestMapping("/myCalendar.do")
	public String myCalendar(Model d, int memberkey) {
		d.addAttribute("list", service.getCalendarIndividaulList(memberkey));
		return "WEB-INF\\views\\myCalendar\\main.jsp";
	}
	
	@RequestMapping("/myCalendarInsert.do")
	public String myCalendarInsert(Model d, Calendar vo) {
		service.insertCalendar(vo);
		return "WEB-INF\\views\\myCalendar\\main.jsp";
	}
	
	
	@RequestMapping("/myCalendarUpdate.do")
	public String myCalendarUpdate(Calendar ins, Model d){
		System.out.println("수정 id:"+ins.getId());
		service.updateCalendar(ins);
		d.addAttribute("msg", "updateCalendar");
		//return "redirect:/calendar.do";
		return "WEB-INF\\views\\myCalendar\\main.jsp";
		//return "redirect:/calendar.do";
	}
	
	
	
	@RequestMapping("/myCalendarDelete.do")
	public String deleteCalendar(@RequestParam("id") int id,Model d){
		System.out.println("삭제 id:"+id);
		d.addAttribute("msg", "deleteCalendar");
		//return "redirect:/calendar.do";
		service.deleteCalendar(id);
		return "WEB-INF\\views\\myCalendar\\main.jsp";
		//return "redirect:/calendar.do";
	}	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
