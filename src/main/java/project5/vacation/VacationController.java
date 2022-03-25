package project5.vacation;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class VacationController {

	@Autowired
	VacationService service;
	
	@RequestMapping("/vacationMain.do")
	public String attendance(Model d) {
		return "WEB-INF\\views\\vacation\\main.jsp";
	}
	
	
	
	
	
	
}
