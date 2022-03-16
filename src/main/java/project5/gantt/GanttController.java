package project5.gantt;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class GanttController {

	@Autowired
	GanttService service;
	
	@RequestMapping("/ganttMain.do")
	public String ganttMain(Model d) {
		return "gantt/main";
	}
	
	@RequestMapping("/ganttMain2.do")
	public String ganttMain2(Model d) {
		return "gantt/main2";
	}
	
}
