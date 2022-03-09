package project5.dashboard;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class DashBoardController {
	
	@RequestMapping("/dashBoard.do")
	public String dashBoard(Model d) {
		return "dashBoard/main";
	}

}
