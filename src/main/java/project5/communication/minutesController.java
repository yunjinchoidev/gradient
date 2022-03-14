package project5.communication;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/minutes.do")
public class minutesController {
	@Autowired
	private minutesService service;
	
	@RequestMapping(params="method=list")
	public String minutesList(minutesVO sch, Model d) {
		d.addAttribute("mList",service.minutesList(sch));
		return "communication/minutesList";
	}
	
	@RequestMapping(params="method=detail")
	public String minutesDetail(int minutesKey, Model d) {
		d.addAttribute("m",service.getMinutes(minutesKey));
		return "";
	}
	
	

	@RequestMapping("/chat.do")
	public String chat() {
		return "communication/chat";
	}

	
	
	
}
