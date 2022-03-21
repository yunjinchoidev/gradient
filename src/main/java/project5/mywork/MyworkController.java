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
		return "/mywork/main";
	}

	@RequestMapping("/send.do")
	public String send(Model d) {
		return "/mywork/send";
	}


	@RequestMapping("/myworkKanban.do")
	public String myworkKanaban(Model d, int memberkey) {
		d.addAttribute("list", service2.individualMemberList(memberkey));
		return "/mywork/myworkKanban";
	}
	@RequestMapping("/myworkGantt.do")
	public String myworkGantt(Model d, int memberkey) {
		d.addAttribute("list", service3.individualMemberList(memberkey));
		return "/mywork/myworkGantt";
	}
	
	 	@RequestMapping("/kanbanListWork.do")
	public String kanbanListWork(Model d) {
		d.addAttribute("list", service2.listWork());	
		return "mywork/kanbanListWork";
	}

	@RequestMapping("/mywork7Days.do")
	public String mywork7Days(Model d) {
		d.addAttribute("list", service3.currentGantt());	
		return "mywork/myworkCurrentGantt";
	}
	@RequestMapping("/mywork3Days.do")
	public String mywork3Days(Model d) {
		d.addAttribute("list", service3.currentGantt());	
		return "mywork/myworkCurrentGantt";
	}
	@RequestMapping("/mywork1Days.do")
	public String mywork1Days(Model d) {
		d.addAttribute("list", service3.currentGantt());	
		return "mywork/myworkCurrentGantt";
	}

	
	
	
	
	
	
	
	
	
	
	
}
