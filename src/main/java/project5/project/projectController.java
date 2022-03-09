package project5.project;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class projectController {

	@RequestMapping("/projectHome.do")
	public String projectHome(Model d) {
		return "/project/home";
	}

	@RequestMapping("/projectWriteForm.do")
	public String projectWriteForm(Model d) {
		return "/project/write";
	}

	@RequestMapping("/projectWrite.do")
	public String projectWrite(Model d) {
		d.addAttribute("psc", "success");
		return "redirect:/projectHome.do";
	}
	
	
	
	
	
}
