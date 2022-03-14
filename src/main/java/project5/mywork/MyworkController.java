package project5.mywork;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import project5.fullCalendar.A10_FullCalService;

@Controller
public class MyworkController {

	@Autowired
	A10_FullCalService service;
	
	
	@RequestMapping("/mywork.do")
	public String myWork(Model d, int memberkey) {
		d.addAttribute("list", service.mywork(memberkey));
		return "/mywork/main";
	}
	
	
	
	
	
	
	
	
	
	
}
