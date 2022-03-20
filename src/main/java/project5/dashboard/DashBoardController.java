package project5.dashboard;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import project5.project.ProjectService;
import project5.project.ProjectVO;

@Controller
public class DashBoardController {
	
	@Autowired
	ProjectService service;
	
	@RequestMapping("/dashBoard.do")
	public String dashBoard(Model d) {
		d.addAttribute("pjList", service.list());
		return "dashBoard/main";
	}

	
	
	
	
}
