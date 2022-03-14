package project5.scheduleNotice;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class ScheduleNoticeController {
	@Autowired
	ScheduleNoticeService service;

	@RequestMapping("/scheduleList.do")
	public String schduleList(Model d) {
		d.addAttribute("list", service.getList());
		return "/schedule/list";
	}
	
	@RequestMapping("/scheduleInsertForm.do")
	public String schduleInsertForm() {
		return "/schedule/InsertForm";
	}
	
	@RequestMapping("/gantt.do")
	public String gantt(Model d) {
		return "/schedule/Gantt";
	}
	
}