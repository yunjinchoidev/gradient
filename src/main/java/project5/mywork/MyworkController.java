package project5.mywork;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class MyworkController {

	@RequestMapping("/mywork.do")
	public String myWork(Model d) {
		return "/mywork/main";
	}
}
