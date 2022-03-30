package project5.sample;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class SampleController {
	
	@GetMapping("/all.do")
	public String doall() {
		return "WEB-INF\\views\\sample\\all.jsp";
	}

	@GetMapping("/member.do")
	public String domember() {
		return "WEB-INF\\views\\sample\\member.jsp";
	}

	@GetMapping("/admin.do")
	public String doadmin() {
		return "WEB-INF\\views\\sample\\admin.jsp";
	}
	@GetMapping("/gg.do")
	public String gg() {
		return "WEB-INF\\views\\sample\\gg.jsp";
	}
}
