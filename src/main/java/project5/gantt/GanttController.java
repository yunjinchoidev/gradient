package project5.gantt;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import project5.gantt.GanttVO;
import project5.member.MemberVO;

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

	@RequestMapping("/ganttMain3.do")
	public String ganttMain3(Model d) {
		return "gantt/main3";
	}
	
	@RequestMapping("/ganttMain4.do")
	public String ganttMain4(Model d) {
		return "gantt/main4";
	}
	
	@RequestMapping("/ganttMain5.do")
	public String ganttMain5(Model d) {
		return "gantt/main5";
	}

	
	
	
	
	@RequestMapping("/ganttList.do")
	public String ganttList(Model d) {
		d.addAttribute("list", service.list());
		return "pageJsonReport";
	}

	
	
	
	
	
	@RequestMapping("/individualMemberGanttList.do")
	public String individualMemberList(Model d, MemberVO vo) {
		d.addAttribute("individualMemberList", service.individualMemberList());
		return "pageJsonReport";
	}

	@RequestMapping("/individualProjectGanttList.do")
	public String individualProjectList(Model d, MemberVO vo) {
		d.addAttribute("individualProjectList", service.individualProjectList());
		return "pageJsonReport";
	}

	@RequestMapping("/ganttDelete.do")
	public String ganttDelete(Model d, GanttVO vo) {
		service.delete(vo.getId());
		d.addAttribute("psc", "delete");
		return "forward:/ganttMain.do";
	}

	@RequestMapping("/ganttInsert.do")
	public String ganttInsert(Model d, GanttVO vo) {
		service.insert(vo);
		d.addAttribute("psc", "add");
		return "forward:/ganttMain.do";
	}

	@RequestMapping("/ganttUpdate.do")
	public String ganttUpdate(Model d, GanttVO vo) {
		service.update(vo);
		d.addAttribute("psc", "update");
		return "forward:/ganttMain.do";
	}

	@RequestMapping("/ganttUpdate2.do")
	public String ganttUpdate2(Model d, GanttVO vo) {
		service.update2(vo);
		d.addAttribute("psc", "move");
		return "forward:/ganttMain.do";
	}

}
