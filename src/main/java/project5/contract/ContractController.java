package project5.contract;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class ContractController {

	@Autowired
	ContractService service;
	
	@RequestMapping("/contractMain.do")
	public String attendance(Model d) {
		return "WEB-INF\\views\\contract\\main.jsp";
	}
	
	@RequestMapping("/contractWriteForm.do")
	public String contractWriteForm(Model d) {
		return "WEB-INF\\views\\contract\\writeForm.jsp";
	}
	
	
	
	
	
	
	
}
