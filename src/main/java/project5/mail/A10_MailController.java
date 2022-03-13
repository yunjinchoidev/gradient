package project5.mail;

import java.util.List;import javax.lang.model.util.AbstractAnnotationValueVisitor14;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import project5.member.MemberService;
import project5.member.MemberVO;


@Controller
public class A10_MailController {
	
	
	@Autowired
	private A10_MailService service;
	
	
	@Autowired
	private MemberService service2;
	
	// http://localhost:7080/springweb/mailFrm.do
	@GetMapping("/mailFrm.do")
	public String mailForm() {
		return "mail/a10_mailForm";
	}

	@RequestMapping("/mailFrm2.do")
	public String mailForm2(Model d, MemberVO vo) {
		System.out.println(vo.getMemberkey());
		d.addAttribute("box", service2.get(vo.getMemberkey()));
		System.out.println(vo.getMemberkey());
		
		return "mail/mailForm2";
	}


	
	
	
	
	
	
	
	@PostMapping("/mailsend.do")
	public String mailsend(Mail mail, Model d) {
		System.out.println(mail.getReciever());
		d.addAttribute("msg", service.sendMail(mail));
		return "mail/a10_mailForm";
	}

	
	
	
	
	
}
