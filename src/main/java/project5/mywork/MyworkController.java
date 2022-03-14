package project5.mywork;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import project5.schedule.ScheduleService;

@Controller
public class MyworkController {

	@Autowired
	ScheduleService service;
	
	
	@RequestMapping("/mywork.do")
	public String myWork(Model d) {
		d.addAttribute("list", service.getList());
		return "/mywork/main";
	}
	
	
	
	
	
	
	
	
	
	
}
