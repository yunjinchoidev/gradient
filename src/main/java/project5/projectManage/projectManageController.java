package project5.projectManage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class projectManageController {

	@Autowired
	ProjectManageService service;
	
	
	@RequestMapping("/projectManageMain.do")
	public String projectManageMain(Model d) {
		d.addAttribute("list", service.list());
		return "/projectManage/main";
	}
	
	
	
	
}
