package project5.member;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import oracle.net.aso.d;

@Controller
public class MemberContoller {
	@Autowired
	MemberService service;
	
	@GetMapping("/login.do")
	public String login() {
		return "member/login";
	}
	
	@RequestMapping("/login.do")
	public String login(Model d, MemberVO vo) {
		if(service.login(vo)==null) {
			d.addAttribute("psc", "fail");
			return "member/login";
		}else {
			d.addAttribute("psc", "success");
			return "/main.do";
		}
	}
	
	@RequestMapping("/registerForm.do")
	public String registerForm() {
		return "member/registerForm";
	}
	@RequestMapping("/register.do")
	public String register(Model d) {
		d.addAttribute("psc", "success");
		return "member/main.do";
	}

	
}
