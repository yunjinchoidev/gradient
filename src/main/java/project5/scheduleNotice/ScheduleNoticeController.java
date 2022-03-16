package project5.scheduleNotice;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class ScheduleNoticeController {
	
	@Autowired
	ScheduleNoticeService service;
	
	@RequestMapping("/scheduleNotice.do")
	public String scheduleNotice(Model d) {
		return "/scheduleNotice/list";
	}


	
	
	
	
	
	
	
}
