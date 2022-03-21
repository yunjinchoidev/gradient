package project5.dashboard;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import project5.department.DepartmentSevice;
import project5.member.MemberVO;
import project5.memo.MemoService;
import project5.project.ProjectService;
import project5.project.ProjectVO;

@Controller
public class DashBoardController {
	
	@Autowired
	ProjectService service;
	
	@Autowired
	MemoService service2;
	
	@RequestMapping("/dashBoard.do")
	public String dashBoard(Model d, int projectkey,MemberVO vo) {
		d.addAttribute("pjList", service.list());
		d.addAttribute("project", service.get(projectkey));
		d.addAttribute("memoList",service2.list());
		return "dashBoard/main";
	}
	
	@RequestMapping("/memoList.do")
	public String memoList(Model d) {
		d.addAttribute("pjList", service.list());
		d.addAttribute("project", service.get(1));
		d.addAttribute("memoList",service2.list());
		return "dashBoard/main2";
	}


	
	
	
	
}
