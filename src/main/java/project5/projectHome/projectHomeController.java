package project5.projectHome;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class projectHomeController {

	@Autowired
	ProjectHomeService service;
	
	
	@RequestMapping("/projectHome.do")
	public String projectHome(Model d) {
		return "/projectHome/home";
	}
	
}
