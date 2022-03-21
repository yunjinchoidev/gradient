package project5.mail;

import java.util.List;import javax.lang.model.util.AbstractAnnotationValueVisitor14;

import org.apache.ibatis.annotations.Param;
import org.hibernate.validator.internal.engine.groups.ValidationOrderGenerator;
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
		return "WEB-INF\\views\\mail\\a10_mailForm.jsp";
	}

	@RequestMapping("/mailFrm2.do")
	public String mailForm2(Model d, MemberVO vo) {
		System.out.println(vo.getMemberkey());
		d.addAttribute("member", service2.get(vo.getMemberkey()));
		return "WEB-INF\\views\\mail\\mailForm2.jsp";
	}
	
	@PostMapping("/mailsend.do")
	public String mailsend(Mail mail, Model d) {
		System.out.println(mail.getReciever());
		d.addAttribute("msg", service.sendMail(mail));
		return "WEB-INF\\views\\mail\\a10_mailForm.jsp";
	}
	
}
