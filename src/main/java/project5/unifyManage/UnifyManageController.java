package project5.unifyManage;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class UnifyManageController {
	
	@RequestMapping("/unifyManage.do")
	public String unifyIndex() {
		return "unify/manage";
	}
	
}
