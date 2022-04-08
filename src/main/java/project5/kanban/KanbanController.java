package project5.kanban;



import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import project5.member.MemberVO;
import project5.project.ProjectService;
import project5.project.ProjectVO;

@Controller
public class KanbanController {

	@Autowired
	KanbanService service;
	
	@Autowired
	ProjectService service2;
	
	@RequestMapping("/kanbanMain.do")
	public String kanbanMain(Model d) {
		d.addAttribute("pjList", service2.list());
		return "WEB-INF\\views\\kanban\\main.jsp";
	}
	
	@RequestMapping("/kanbanMain2.do")
	public String kanbanMain2(Model d) {
		return "WEB-INF\\views\\kanban\\main2.jsp";
	}
	
	
	
	@RequestMapping("/kanbanList.do")
	public String kanbanList(Model d, int projectkey) {
		d.addAttribute("list", service.list(projectkey));	
		return "pageJsonReport";
	}

	
	
	@RequestMapping("/individualMemberList.do")
	public String individualMemberList(Model d, MemberVO vo) {
		d.addAttribute("individualMemberList", service.individualMemberList(vo.getMemberkey()));	
		return "pageJsonReport";
	}
	
	@RequestMapping("/individualProjectList.do")
	public String individualProjectList(Model d, MemberVO vo) {
		d.addAttribute("individualProjectList", service.individualProjectList());	
		return "pageJsonReport";
	}

	
	
	
	
	@RequestMapping("/kanbanDelete.do")
	public String kanbanDelete(Model d, KanbanVO vo) {
		System.out.println("칸반 삭제 진입");
		service.delete(vo);
		d.addAttribute("psc", "delete");
		return "forward:/kanbanMain.do";
	}	
	
	
	
	
	
	
	@RequestMapping("/kanbanInsert.do")
	public String kanbanInsert(Model d, KanbanVO vo) {
		service.insert(vo);
		d.addAttribute("psc", "add");
		return "forward:/kanbanMain.do";
	}

	
	
	
	
	
	
	@RequestMapping("/kanbanUpdate.do")
	public String kanbanUpdate(Model d, KanbanVO vo) {
		service.update(vo);
		d.addAttribute("psc", "update");
		return "forward:/kanbanMain.do";
	}
	@RequestMapping("/kanbanUpdate2.do")
	public String kanbanUpdate2(Model d, KanbanVO vo) {
		System.out.println(vo.getContent());
		System.out.println(vo.getText());
		service.update2(vo);
		d.addAttribute("psc", "move");
		//return "pageJsonReport";
		return "forward:/kanbanMain.do";
	}
	
	
	
	
	
	
	
	
	
	
	
	
}
