package project5.output;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import project5.project.ProjectService;

@Controller
public class OutputController {
	
	@Autowired
	ProjectService service2;
	
	
	@RequestMapping("/output.do")
	public String output(Model d) {
		d.addAttribute("pjList", service2.list());
		return "output/list";
	}
	
	
	
	
	
	
	
}
