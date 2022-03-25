package project5.procuSituation;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class ProcuSituationController {

	@Autowired
	ProcuSituationService service;
	
	@RequestMapping("/procuSituationMain.do")
	public String attendance(Model d) {
		return "WEB-INF\\views\\procuSituation\\main.jsp";
	}
	
	
	
}
