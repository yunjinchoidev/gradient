package project5.mail;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
public class MailContoller {
	
	@Autowired
	private MailService service;
	
	@GetMapping("mailFrm.do")
	public String mailForm() {
		return "/mail/a10_mailForm";
	}

	
	@PostMapping("mailSend.do")
	public String mailSend() {
		
		return "/mail/a10_mailForm";
	}
	
	
	
}
