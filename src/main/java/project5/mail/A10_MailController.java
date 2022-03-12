package project5.mail;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;


@Controller
public class A10_MailController {
	
	
	@Autowired
	private A10_MailService service;
	
	
	// http://localhost:7080/springweb/mailFrm.do
	@GetMapping("/mailFrm.do")
	public String mailForm() {
		return "mail/a10_mailForm";
	}
	
	
	
	
	@PostMapping("/mailsend.do")
	public String mailsend(Mail mail, Model d) {
		System.out.println(mail.getReciever());
		d.addAttribute("msg", service.sendMail(mail));
		return "mail/a10_mailForm";
	}
	
	
	
	
	
	
	
	
}
