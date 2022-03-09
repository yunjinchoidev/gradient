package project5.allProject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class AllProjectController {
	
	@RequestMapping("/allProject.do")
	public String list(Model d) {
		return "/allProject/main";
	}
	
}
