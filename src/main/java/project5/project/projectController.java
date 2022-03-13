package project5.project;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class projectController {

	@Autowired
	ProjectService service;
	
	
	@RequestMapping("/projectList.do")
	public String projectHome(Model d) {
		d.addAttribute("list", service.list());
		return "/unify/list";
	}

	
	@RequestMapping("/projectTotalManage.do")
	public String projectManage(Model d) {
		return "/unify/manage";
	}

	
	
	
	
}
