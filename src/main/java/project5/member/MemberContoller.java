package project5.member;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

@Controller
@SessionAttributes("member")
public class MemberContoller {
	@Autowired
	MemberService service;
	
	
	
	
	
	
	@ModelAttribute("member")
	public MemberVO getUserVO() {
		return new MemberVO();
	}
	
	@GetMapping("/login.do")
	public String login() {
		return "member/login";
	}

	@GetMapping("/memberEdit.do")
	public String memberEdit() {
		return "member/edit";
	}
	
	@PostMapping("/login.do")
	public String login(Model d, @ModelAttribute("member") MemberVO vo) {
		vo = service.login(vo);
		if(vo==null) {
			d.addAttribute("psc", "fail");
			System.out.println("fail");
			return "member/login";
		}else {
			d.addAttribute("psc", "success");
			d.addAttribute("member", service.login(vo));
			System.out.println("로그인 성공하였습니다.");
			return "forward:/main.do";
		}
	}
	
	
	@RequestMapping("/logout.do")
	public String logout(Model d,  @ModelAttribute("member") MemberVO vo) {
		vo = service.logout();
		d.addAttribute("psc", "logout");
		d.addAttribute("member", vo);
		return "redirect:/main.do";
	}
	
	
	
	@RequestMapping("/memberRegisterForm.do")
	public String registerForm() {
		return "member/registerForm";
	}
	
	
	@RequestMapping("/memberRegister.do")
	public String register(Model d, MemberVO vo) {
		service.register(vo);
		d.addAttribute("psc", "success");
		return "forward:/main.do";
	}
	
	

	
}
