package project5.bid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class BidController {

	@Autowired
	BidService service;
	
	@RequestMapping("/bidMain.do")
	public String attendance(Model d) {
		return "WEB-INF\\views\\bid\\main.jsp";
	}
	
	
	
	
	
	
}
