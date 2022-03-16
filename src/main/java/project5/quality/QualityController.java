package project5.quality;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import project5.risk.RiskService;

@Controller
public class QualityController {
	
	
	
	@RequestMapping("/quality.do")
	public String unifyIndex() {
		return "quality/list";
	}

	
	
	
	
}
