package project5.pricing;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class pricingContoller {

	
	@RequestMapping("/pricing.do")
	public String plan(Model d) {
		return "WEB-INF\\views\\member\\pricing.jsp";
	}
}
