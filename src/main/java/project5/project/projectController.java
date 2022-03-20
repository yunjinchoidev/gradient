package project5.project;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import oracle.net.aso.i;

@Controller
public class projectController {

	@Autowired
	ProjectService service;
	
	
	@RequestMapping("/projectList.do")
	public String projectList(Model d) {
		d.addAttribute("list", service.list());
		return "pageJsonReport";
	}

	@RequestMapping("/projectGet.do")
	public String projectManageMain(Model d, int proejctkey) {
		d.addAttribute("list", service.get(proejctkey));
		return "pageJsonReport";
	}
	
	
	
	
	
	
	
}
