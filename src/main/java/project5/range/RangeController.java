package project5.range;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class RangeController {
	
	@RequestMapping("/rangeKanban.do")
	public String unifyIndex() {
		return "range/Kanban";
	}

	@RequestMapping("/range.do")
	public String range() {
		return "range/list";
	}
	
}
