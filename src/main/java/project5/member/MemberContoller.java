package project5.member;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import project5.mail.A10_MailService;
import project5.mail.Mail;

@Controller
@SessionAttributes("member")
public class MemberContoller {
	@Autowired
	MemberService service;

	@Autowired
	A10_MailService service2;

	@ModelAttribute("member")
	public MemberVO getUserVO() {
		return new MemberVO();
	}

	@GetMapping("/login.do")
	public String login() {
		return "WEB-INF\\views\\member\\login.jsp";
	}

	@GetMapping("/memberEdit.do")
	public String memberEdit(Model d, MemberVO vo) {
		System.out.println("회원 정보 수정 창으로 이동");
		d.addAttribute("get", service.get(vo.getMemberkey()));
		return "WEB-INF\\views\\member\\edit.jsp";
	}

	
	
	
	
	
	
	@PostMapping("/login.do")
	public String login(Model d, @ModelAttribute("member") MemberVO vo) {
		vo = service.login(vo);
		MemberVO vo2 = new MemberVO(1);
		if (vo != null) {
			d.addAttribute("psc", "success");
			d.addAttribute("member", service.login(vo));
			System.out.println("vo : "+vo);
			System.out.println("로그인 성공하였습니다.");
			return "forward:/main.do";
		} else {
			d.addAttribute("psc", "fail");
			d.addAttribute("member", vo2);
			System.out.println("vo : "+vo);
			System.out.println("로그인 실패");
			return "WEB-INF\\views\\member\\loginFail.jsp";
		}
		
		
		
		
		

	}

	@RequestMapping(value = "/logout.do")
	public String userRemove(@ModelAttribute("member") MemberVO member, Model d) {
		MemberVO vo = new MemberVO(1);
		System.out.println("로그아웃 진입");
		d.addAttribute("member", vo);
		System.out.println(member);
		System.out.println(member.getId());
		System.out.println("로그아웃 성공");
		return "redirect:/login.do";
	}

	@RequestMapping(value = "/memberDeleteForm.do")
	public String memberDeleteForm() {
		return "WEB-INF\\views\\member\\deleteForm.jsp";
	}

	@RequestMapping(value = "/memberDelete.do")
	public String memberDeleteForm(Model d, int memberkey, @ModelAttribute("member") MemberVO member) {
		service.delete(memberkey);
		MemberVO vo = new MemberVO(1);
		d.addAttribute("member", vo);
		return "WEB-INF\\views\\member\\deleteResult.jsp";
	}

	@RequestMapping("/memberRegisterForm.do")
	public String registerForm(Model d) {
		d.addAttribute("reginum", service.reginum());
		return "WEB-INF\\views\\member\\registerForm.jsp";
	}

	@RequestMapping("/memberRegister.do")
	public String register(Model d, MemberVO vo, Mail mail) {
		System.out.println(vo.getMemberkey());
		System.out.println(mail.toString());
		d.addAttribute("psc", service2.sendidpassMail(vo.getMemberkey(), mail.getReciever()));
		System.out.println("임시 아이디 비밀번호 발급 성공");
		return "WEB-INF\\views\\member\\memberRegisterResult.jsp";
	}

	@RequestMapping("/memberRegisterResult.do")
	public String memberRegisterResult() {
		return "WEB-INF\\views\\member\\memberRegisterResult.jsp";
	}

	
	
	// 회원 정보 수정
	@RequestMapping("/memberEdit.do")
	public String memberEdit(MemberVO vo, Model d, @ModelAttribute("member") MemberVO member) {
		System.out.println("회원 정보 수정 진입");
		service.edit(vo);
		MemberVO vo2 = new MemberVO(1); // 로그아웃
		d.addAttribute("member", vo2);
		System.out.println("회원 정보 수정 완료");
		d.addAttribute("psc", "success");
		return "WEB-INF\\views\\member\\EditSuccess.jsp";
		}
	
	
	
	
	
	
	
	
	@RequestMapping("/memberList.do")
	public String memberList(Model d) {
		d.addAttribute("list", service.list());
		return "WEB-INF\\views\\member\\list.jsp";
	}
	
	@RequestMapping("/memberFindForm.do")
	public String memberFindForm(Model d) {
		return "WEB-INF\\views\\member\\memberFindForm.jsp";
	}
	
		// 아이디 중복 검사
		@RequestMapping("/memberIdChk.do")
		@ResponseBody
		public void memberIdChk(String memberkey) throws Exception{
			System.out.println(memberkey);
			System.out.println("진입");
		} 
		@RequestMapping("/header.do")
		public String header(Model d) {
			return "WEB-INF\\views\\common\\header.jsp";
		}
	

}
