package project5.todayItodo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class TodayItodo {

	@RequestMapping("/todayItodo.do")
	public String schduleList(Model d) {
		return "/schedule/todayItodo";
	}
	
}
