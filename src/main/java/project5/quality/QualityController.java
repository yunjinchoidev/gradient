package project5.quality;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class QualityController {
	
	@RequestMapping("/communiList.do")
	public String unifyIndex() {
		return "communication/list";
	}

	
	
	
	
}
