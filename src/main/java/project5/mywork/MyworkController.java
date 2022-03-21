package project5.mywork;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import project5.fullCalendar.A10_FullCalService;
import project5.gantt.GanttController;
import project5.gantt.GanttService;
import project5.kanban.KanbanController;
import project5.kanban.KanbanService;

@Controller
public class MyworkController {

	@Autowired
	A10_FullCalService service;
	
	@Autowired
	KanbanService service2;
	
	@Autowired
	GanttService service3;
	
	
	@RequestMapping("/mywork.do")
	public String myWork(Model d, int memberkey) {
		d.addAttribute("list", service.mywork(memberkey));
		return "WEB-INF\\views\\mywork\\main.jsp";
	}

	@RequestMapping("/send.do")
	public String send(Model d) {
		return "WEB-INF\\views\\mywork\\send.jsp";
		
	}


	@RequestMapping("/myworkKanban.do")
	public String myworkKanaban(Model d, int memberkey) {
		d.addAttribute("list", service2.individualMemberList(memberkey));
		return "WEB-INF\\views\\mywork\\myworkKanban.jsp";
	}
	@RequestMapping("/myworkGantt.do")
	public String myworkGantt(Model d, int memberkey) {
		d.addAttribute("list", service3.individualMemberList(memberkey));
		return "WEB-INF\\views\\mywork\\myworkGantt.jsp";
	}
	
	 	@RequestMapping("/kanbanListWork.do")
	public String kanbanListWork(Model d) {
		d.addAttribute("list", service2.listWork());	
		return "WEB-INF\\views\\mywork\\kanbanListWork.jsp";
	}

	@RequestMapping("/mywork7Days.do")
	public String mywork7Days(Model d) {
		d.addAttribute("list", service3.currentGantt());	
		return "WEB-INF\\views\\mywork\\myworkCurrentGantt.jsp";
	}
	@RequestMapping("/mywork3Days.do")
	public String mywork3Days(Model d) {
		d.addAttribute("list", service3.currentGantt());	
		return "WEB-INF\\views\\mywork\\myworkCurrentGantt.jsp";
	}
	@RequestMapping("/mywork1Days.do")
	public String mywork1Days(Model d) {
		d.addAttribute("list", service3.currentGantt());	
		return "WEB-INF\\views\\mywork\\myworkCurrentGantt.jsp";
	}

	
	
	
	
	
	
	
	
	
	
	
}
