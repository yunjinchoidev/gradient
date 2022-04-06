package project5.vacation;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import project5.project.ProjectService;

@Controller
public class VacationController {

	@Autowired
	VacationService service;
	
	@Autowired
	ProjectService service2;
	
	@RequestMapping("/vacationMain.do")
	public String attendance(Model d) {
		return "WEB-INF\\views\\vacation\\main.jsp";
	}
	
	@RequestMapping("/vacationWriteForm.do")
	public String vacationWriteForm(Model d) {
		d.addAttribute("projectList", service2.list());
		return "WEB-INF\\views\\vacation\\writeForm.jsp";
	}

	@RequestMapping("/vacationWrite.do")
	public String vacationWrite(Model d, VacationVO vo) {
		service.insert(vo);
		return "WEB-INF\\views\\vacation\\writeForm.jsp";
	}
	
	
	
	
	
	
}
