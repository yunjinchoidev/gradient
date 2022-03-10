package project5.Mail;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class MailContoller {
	
	@GetMapping("mailFrm")
	public String mailForm() {
		return "/mail/A10_MailForm";
	}
}
