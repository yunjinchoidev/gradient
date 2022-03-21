package project5.allProject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import project5.project.ProjectService;

@Controller
public class AllProjectController {
	
	@Autowired
	ProjectService service;
	
	@RequestMapping("/allProject.do")
	public String list(Model d) {
		d.addAttribute("list", service.list());
		return "WEB-INF\\views\\allProject\\main.jsp";
	}
	
}
