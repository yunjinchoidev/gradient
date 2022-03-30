package project5.sample;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
public class CommonController {

	@GetMapping("/accessError.do")
	public String accessDenied(Authentication auth, Model model) {
		model.addAttribute("msg", "Access Denied");
		System.out.println("실패");
		return "WEB-INF\\views\\accessError.jsp";
	}
	
	
	@GetMapping("/customLogin.do")
	public String loginInput(String error, String logout, Model model) {
		if (error != null) {
			model.addAttribute("error", "Login Error Check Your Account");
		}
		if (logout != null) {
			model.addAttribute("logout", "Logout!!");
		}
		return "WEB-INF\\views\\customLogin.jsp";
	}

	
	
	@GetMapping("/customLogout.do")
	public String logoutGET() {
		return "WEB-INF\\views\\customLogout.jsp";
	}
	
	@PostMapping("/customLogout.do")
	public String logoutPost() {
		return "WEB-INF\\views\\customLogin.jsp";
	}

}
