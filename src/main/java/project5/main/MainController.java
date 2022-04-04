package project5.main;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class MainController {
	@RequestMapping("/main.do")
	public String Main() {
		return "WEB-INF\\views\\main.jsp";
	}
	
	
	
	@RequestMapping("/main2")
	public String Main2() {
		return "WEB-INF\\views\\main2.jsp";
	}

	@RequestMapping("/aboutUs.do")
	public String aboutUs() {
		return "WEB-INF\\views\\aboutUs.jsp";
	}
	
}
