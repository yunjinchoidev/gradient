package project5.myWork;



import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import project5.fileInfo.FileInfoVO;
import project5.fullCalendar.A10_FullCalService;
import project5.fullCalendar.Calendar;
import project5.gantt.GanttController;
import project5.gantt.GanttService;
import project5.gantt.GanttVO;
import project5.kanban.KanbanController;
import project5.kanban.KanbanService;
import project5.kanban.KanbanVO;

@Controller
public class MyWorkController {

	@Autowired
	A10_FullCalService service;
	
	@Autowired
	KanbanService service2;
	
	@Autowired
	GanttService service3;
	
	@Autowired
	MyWorkService service4;
	
	
	@RequestMapping("/myworkCalendar.do")
	public String myWork(Model d, int memberkey) {
		d.addAttribute("list", service.mywork(memberkey));
		d.addAttribute("menubarList", service4.menubarList());
		return "WEB-INF\\views\\mywork\\calendarList.jsp";
	}

	@RequestMapping("/myworkKanban.do")
	public String myworkKanaban(Model d, int memberkey) {
		d.addAttribute("list", service2.individualMemberList(memberkey));
		d.addAttribute("menubarList", service4.menubarList());
		return "WEB-INF\\views\\mywork\\kanbanList.jsp";
	}

	@RequestMapping("/myworkGantt.do")
	public String myworkGantt(Model d, int memberkey) {
		d.addAttribute("list", service3.currentGanttbymkey(memberkey));
		return "WEB-INF\\views\\mywork\\ganttList.jsp";
	}
	
	@RequestMapping("/myworkCalendar7days.do")
	public String myworkCalendar7days(Model d, int memberkey) {
		d.addAttribute("list", service3.individualMemberList(memberkey));
		return "WEB-INF\\views\\mywork\\calendar7days.jsp";
	}
	@RequestMapping("/myworkCalendar3days.do")
	public String myworkCalendar3days(Model d, int memberkey) {
		d.addAttribute("list", service3.individualMemberList(memberkey));
		return "WEB-INF\\views\\mywork\\calendar3days.jsp";
	}
	@RequestMapping("/myworkCalendar1days.do")
	public String myworkCalendar1days(Model d, int memberkey) {
		d.addAttribute("list", service3.individualMemberList(memberkey));
		return "WEB-INF\\views\\mywork\\calendar1days.jsp";
	}
	
	@RequestMapping("/myWorkCalendarGet.do")
	public String myWorkModal(Model d, Calendar vo) {
		d.addAttribute("get", service.get(vo.getId()));
		return "WEB-INF\\views\\mywork\\calendarGet.jsp";
	}
	@RequestMapping("/myWorkKanbanGet.do")
	public String myWorkKanbanGet(Model d, KanbanVO vo) {
		return "WEB-INF\\views\\mywork\\kanbanGet.jsp";
	}
	@RequestMapping("/myWorkganttGet.do")
	public String myWorkganttGet(Model d, GanttVO vo) {
		return "WEB-INF\\views\\mywork\\ganttGet.jsp";
	}

	
	
	//파일함
	@RequestMapping("/myWork9.do")
	public String myWorkFileBox(Model d, int memberkey) {
		d.addAttribute("menubarList", service4.menubarList());
		return "WEB-INF\\views\\mywork\\9fileBox.jsp";
	}
	
	
	@RequestMapping("/myFileListInOutput.do")
	public String myFileListInOutput(Model d, int memberkey) {
		d.addAttribute("myFileListInOutput", service4.myFileListInOutput(memberkey));
		return "pageJsonReport";
	}
	
	@RequestMapping("/myWork10.do")
	public String galley(Model d, int memberkey) {
		d.addAttribute("menubarList", service4.menubarList());
		return "WEB-INF\\views\\mywork\\10galley.jsp";
	}

	
	@RequestMapping("/leftSide.do")
	public String leftSide(Model d) {
		d.addAttribute("menubarList", service4.menubarList());
		return "WEB-INF\\views\\mywork\\leftSide.jsp";
	}
	
	
	
	
	
}
