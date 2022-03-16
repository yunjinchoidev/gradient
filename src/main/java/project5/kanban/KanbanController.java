package project5.kanban;



import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import project5.member.MemberVO;

@Controller
public class KanbanController {

	@Autowired
	KanbanService service;
	
	@RequestMapping("/kanbanMain.do")
	public String kanbanMain(Model d) {
		return "/kanban/main";
	}
	@RequestMapping("/kanbanMain2.do")
	public String kanbanMain2(Model d) {
		return "/kanban/main2";
	}
	
	@RequestMapping("/kanbanList.do")
	public String kanbanList(Model d) {
		d.addAttribute("list", service.list());	
		return "pageJsonReport";
	}

	@RequestMapping("/individualMemberList.do")
	public String individualMemberList(Model d, MemberVO vo) {
		d.addAttribute("individualMemberList", service.individualMemberList());	
		return "pageJsonReport";
	}
	
	@RequestMapping("/individualProjectList.do")
	public String individualProjectList(Model d, MemberVO vo) {
		d.addAttribute("individualProjectList", service.individualProjectList());	
		return "pageJsonReport";
	}

	@RequestMapping("/kanbanDelete.do")
	public String kanbanDelete(Model d, KanbanVO vo) {
		service.delete(vo.getId());
		return "/project5/kanbanMain.do";
	}
	
	@RequestMapping("/kanbanInsert.do")
	public String kanbanInsert(Model d, KanbanVO vo) {
		service.insert(vo);
		return "forward:/kanbanMain.do";
	}
	
	
	
	
	
	
	
	
	
	
	
	
}
