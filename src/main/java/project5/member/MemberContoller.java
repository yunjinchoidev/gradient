package project5.member;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import project5.fileInfo.FileInfoService;
import project5.mail.A10_MailService;
import project5.mail.Mail;

@Controller
@SessionAttributes("member")
public class MemberContoller {
	@Autowired
	MemberService service;

	@Autowired
	A10_MailService service2;

	@Autowired
	FileInfoService service3;

	@ModelAttribute("member")
	public MemberVO getUserVO() {
		return new MemberVO();
	}

	@GetMapping("/loginForm.do")
	public String loginForm() {
		return "WEB-INF\\views\\member\\login.jsp";
	}

	@GetMapping("/memberEdit.do")
	public String memberEdit(Model d, MemberVO vo) {
		System.out.println("회원 정보 수정 창으로 이동");
		d.addAttribute("get", service.get(vo.getMemberkey()));
		return "WEB-INF\\views\\member\\edit.jsp";
	}

	@RequestMapping("/login.do")
	public String login(Model d, @ModelAttribute("member") MemberVO vo) {
		vo = service.login(vo);
		MemberVO vo2 = new MemberVO(1);
		if (vo != null) {
			d.addAttribute("psc", "success");
			d.addAttribute("member", service.login(vo));
			System.out.println("vo : " + vo);
			System.out.println("로그인 성공하였습니다.");
			service.updateVisitCnt(vo.getMemberkey());
			return "forward:/main.do";
		} else {
			d.addAttribute("psc", "fail");
			d.addAttribute("member", vo2);
			System.out.println("vo : " + vo);
			System.out.println("로그인 실패");
			return "forward:/loginFail.do";
		}
	}

	@RequestMapping("/loginFail.do")
	public String loginFail() {
		System.out.println("로그인실패 성공");
		return "WEB-INF\\views\\member\\loginFail.jsp";
	}

	@RequestMapping(value = "/logout.do")
	public String userRemove(@ModelAttribute("member") MemberVO member, Model d) {
		MemberVO vo = new MemberVO(1);
		d.addAttribute("member", vo);
		System.out.println("로그아웃 성공");
		return "redirect:/loginForm.do";
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

	@RequestMapping(value = "/memberDelete2.do")
	public String memberDelete2(Model d, int memberkey) {
		service.delete(memberkey);
		d.addAttribute("psc", "memberDeleteSuccess");
		return "forward:/memberList.do";
	}

	@RequestMapping("/memberRegisterForm.do")
	public String registerForm(Model d) {
		d.addAttribute("reginum", service.reginum());
		return "WEB-INF\\views\\member\\registerForm.jsp";
	}

	@RequestMapping("/reginum.do")
	public String reginumCurrvalAjax(Model d) {
		d.addAttribute("reginum", service.reginum());
		return "pageJsonReport";
	}

	@RequestMapping("/memberInfoByMemberKey.do")
	public String memberInfoByMemberKey(Model d, int memberkey) {
		d.addAttribute("memberInfoByMemberKey", service.get(memberkey));
		return "pageJsonReport";
	}

	/////////////////////////////////////////////////////////////////////
	@RequestMapping("/memberRegisteraa.do")
	public String memberRegister(Model d, MemberVO vo, Mail mail) {
		System.out.println(vo.getMemberkey());
		System.out.println(mail.toString());
		d.addAttribute("psc", service2.sendidpassMail(vo.getMemberkey(), mail.getReciever()));
		System.out.println("회원 신청 완료");
		return "";
	}

	@RequestMapping("/memberRegister.do")
	public String memberRegister(Model d, MemberVO vo) {
		System.out.println(vo.getMemberkey());
		MemberVO vo2 = service.get(vo.getMemberkey());
		service2.sendidpassMail(vo.getMemberkey(), vo2.getEmail());
		service.memberRegisterComplete(vo.getMemberkey());
		d.addAttribute("psc", "EmailSuccess");
		System.out.println("임시 아이디 비밀번호 발급 성공");
		return "forward:/memberList.do";
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
	public String memberList(Model d, MemberSch sch) {
		d.addAttribute("list", service.listWithPaging(sch));
		return "WEB-INF\\views\\member\\list.jsp";
	}

	@RequestMapping("/memberFindForm.do")
	public String memberFindForm(Model d) {
		return "WEB-INF\\views\\member\\memberFindForm.jsp";
	}

	@RequestMapping("/memberIdFind.do")
	public String memberIdFind(Model d, MemberVO vo) {
		d.addAttribute("get", service.memberIdFind(vo));
		return "WEB-INF\\views\\member\\memberIdFind.jsp";
	}

	@RequestMapping("/memberPassFindApply.do")
	public String memberPassFindApply(Model d, MemberVO vo) {
		System.out.println(vo.getMemberkey());
		d.addAttribute("get", service.memberPassFind(vo));
		MemberVO vo2 = service.memberPassFind(vo);
		service.newIssuePassword(vo);
		MemberVO vo3 = service.getByNameAndEmail(vo);
		if (vo2 != null) {
			service.updateStatus(new MemberVO(vo3.getMemberkey(), 3)); // 비밀번호 변경 신청 상태 3로 바꿔준다.
			return "WEB-INF\\views\\member\\memberPassFind.jsp";
		} else {
			return "WEB-INF\\views\\member\\memberPassFind.jsp";
		}
	}

	@RequestMapping("/memberPassFind.do")
	public String memberPassFind(Model d, int memberkey) {
		MemberVO vo2 = service.get(memberkey);
		service2.sendpassIssueMail(vo2.getMemberkey(), vo2.getEmail());
		service.updateStatus(new MemberVO(memberkey, 2));
		return "forward:/memberList.do";
	}

	@RequestMapping("/updatePricing.do")
	public String updatePricing(Model d, MemberVO vo) {
		service.updatePricing(vo);
		return "pageJsonReport";
	}

	@RequestMapping("/insertMemberAjax.do")
	public String insertMemberAjax(Model d, MemberVO vo) {
		service.insertMemberAjax(vo);
		d.addAttribute("insertMemberAjax", "succeess");
		return "pageJsonReport";
	}

	// 아이디 중복 검사
	@RequestMapping("/memberIdChk.do")
	@ResponseBody
	public void memberIdChk(String memberkey) throws Exception {
		System.out.println(memberkey);
		System.out.println("진입");
	}

	@RequestMapping("/header.do")
	public String header(Model d) {
		return "WEB-INF\\views\\common\\header.jsp";
	}

	@PostMapping("/myfaceData.do")
	public String projectdata(int memberkey, Model d) {
		System.out.println("/myfaceData.do 진입");
		System.out.println("memberkey:" + memberkey);
		d.addAttribute("myfaceData", service3.findbyfno(memberkey));
		return "pageJsonReport";
	}

	@RequestMapping("/readreadread.do")
	public String readreadread(String id, Model d) {
		System.out.println("/readreadread.do 진입");
		System.out.println("id:" + id);
		d.addAttribute("readreadread", service.read(id));
		return "pageJsonReport";
	}

	// 카카오 api 로그인
	@RequestMapping("/loginKaKao.do")
	public String loginKaKao(@RequestParam("code") String code, Model d) {
		System.out.println("===================================");
		System.out.println(code);
		d.addAttribute("code", code);
		return "WEB-INF\\views\\member\\login.jsp";
	}

	// 네이버 api 로그인
	@RequestMapping("/loginNaver.do")
	public String loginNaver(@RequestParam("access_token") String access_token, Model d) {
		System.out.println("===================================");
		System.out.println(access_token);
		d.addAttribute("access_token", access_token);
		return "WEB-INF\\views\\member\\login.jsp";
	}

	@RequestMapping("/memberRegisterApplyFirst.do")
	public String memberRegisterApply(Model d, MemberVO vo) {
		service.memberRegisterApply(vo);
		return "WEB-INF\\views\\member\\memberRegisterResult.jsp";
	}
	
	
	@RequestMapping("/duplicateEmail.do")
	public String duplicateEmail(String email, Model d) {
		
		MemberVO vo =service.duplicateEmail(email);
		if(vo==null) {
			d.addAttribute("duplicateEmail", "can");
		}else {
			d.addAttribute("duplicateEmail", "already");
		}
		return "pageJsonReport";
	}
	
	
	
	
	@RequestMapping("/duplicateId.do")
	public String duplicateId(String id, Model d) {
		d.addAttribute("id", id);
		return "WEB-INF\\views\\member\\duplicateId.jsp";
	}
	
	@RequestMapping("/duplicateIdCheck.do")
	public String duplicateIdCheck(String id, Model d) {
		MemberVO vo =service.duplicateId(id);
		System.out.println("아이디 중복 검사 진입");
		System.out.println("입력 받은 아이디"+id);
		if(vo==null) {
			d.addAttribute("duplicateId", "can");
		}else {
			d.addAttribute("duplicateId", "already");
		}
		
		System.out.println("아이디 중복 검사 완료");
		return "pageJsonReport";
	}
	
	
	
	
	
	

}
