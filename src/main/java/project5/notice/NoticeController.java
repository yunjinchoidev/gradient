package project5.notice;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class NoticeController {
	
	@RequestMapping("/notice.do")
	public String unifyIndex() {
		return "notice/list";
	}

	
	
	
	
}
