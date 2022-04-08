package project5.myCalendar;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import project5.fullCalendar.A10_FullCalService;

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
	public String myCalendarInsert(Model d, int memberkey) {
		d.addAttribute("list", service.getCalendarIndividaulList(memberkey));
		return "WEB-INF\\views\\myCalendar\\main.jsp";
	}
	
	
}
