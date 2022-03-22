package project5.dashBoard;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import project5.member.MemberVO;
import project5.memo.MemoService;
import project5.project.ProjectService;

@Controller
public class DashBoardController {
	
	
	
	@Autowired
	ProjectService service;
	
	@Autowired
	MemoService service2;
	
	@Autowired
	DashBoardService service3;
	
	
	@RequestMapping("/dashBoard.do")
	public String dashBoard(Model d, int projectkey,MemberVO vo) {
		d.addAttribute("pjList", service.list());
		d.addAttribute("project", service.get(projectkey));
		d.addAttribute("memoList",service2.list());
		d.addAttribute("riskDashBoardList", service3.riskDashBoard());
		return "WEB-INF\\views\\dashBoard\\main.jsp";
	}
	
	
}
