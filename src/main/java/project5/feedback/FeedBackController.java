package project5.feedback;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class FeedBackController {

	@Autowired
	FeedBackService service;
	
	@RequestMapping("/feedBackMain.do")
	public String attendance(Model d) {
		return "WEB-INF\\views\\feedBack\\main.jsp";
	}
	
	
	
	
	
	
}
