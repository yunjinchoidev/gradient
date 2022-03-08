package project5.risk;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class RiskController {
	
	@RequestMapping("/communiList.do")
	public String unifyIndex() {
		return "communication/list";
	}

	
	
	
	
}
