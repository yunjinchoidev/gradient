package project5.cost;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class CostController {
	
	@RequestMapping("/cost.do")
	public String unifyIndex() {
		return "cost/list";
	}

	
	
	
	
}
