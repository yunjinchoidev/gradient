package project5.member;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class MemberContoller {
	@RequestMapping("/member.do")
	public String login(Model d, MemberVO m) {
		d.addAttribute("psc", "로그인시도");
		return "member/login";
	}

}
