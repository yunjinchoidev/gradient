package project5.fullCalendar;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class A20_FullCalController {

	@Autowired
	private A10_FullCalService service;

	@GetMapping("/calendar.do")
	public String calendar() {
		return "schedule/fullCalendar";
	}

	@RequestMapping("calList.do")
	public String calList(Model d) {
		d.addAttribute("calList", service.getCalendarList());
		return "pageJsonReport";
	}

}
