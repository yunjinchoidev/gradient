package project5.dashboard;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import project5.department.DepartmentSevice;
import project5.project.ProjectService;
import project5.project.ProjectVO;

@Controller
public class DashBoardController {
	
	@Autowired
	ProjectService service;
	
	
	
	@RequestMapping("/dashBoard.do")
	public String dashBoard(Model d, int projectkey) {
		d.addAttribute("pjList", service.list());
		d.addAttribute("project", service.get(projectkey));
		return "dashBoard/main";
	}

	@RequestMapping("/dashBoard2.do")
	public String dashBoard2(Model d, int projectkey) {
		d.addAttribute("pjList", service.list());
		d.addAttribute("project", service.get(projectkey));
		return "dashBoard/main2";
	}

	
	
	
	
}
