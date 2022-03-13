package project5.kanban;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class KanbanController {

	@RequestMapping("/kanbanMain.do")
	public String kanbanMain(Model d) {
		return "/kanban/main";
	}
	@RequestMapping("/kanbanMain2.do")
	public String kanbanMain2(Model d) {
		return "/kanban/main2";
	}
}
