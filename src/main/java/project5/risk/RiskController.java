package project5.risk;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class RiskController {
	
	@RequestMapping("/risk.do")
	public String unifyIndex() {
		return "risk/list";
	}

	
	
	
	
}
