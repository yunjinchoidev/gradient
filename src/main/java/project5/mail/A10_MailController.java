package project5.mail;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

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

	// 메일 발송 폼
	@GetMapping("/mailFrm.do")
	public String mailForm() {
		return "WEB-INF\\views\\mail\\a10_mailForm.jsp";
	}

	// 메일 발송하기 // 내 마음대로
	@PostMapping("/mailsend.do")
	public String mailsend(Mail mail, Model d) {
		System.out.println(mail.getReciever());
		d.addAttribute("msg", service.sendMail(mail));
		return "WEB-INF\\views\\mail\\a10_mailForm.jsp";
	}

	// 회원을 골라서 메일 보내주는 것
	@RequestMapping("/memberChkSendMail.do")
	public String memberChkSendMail(Model d,@RequestParam HashMap<String, Object> commandMap) throws Exception{ 
		System.out.println(commandMap); //{arrayParam=1,2,3, email=1}
		String[] code_array=null;
		String code=commandMap.get("arrayParam").toString();
		System.out.println(code); //1,2,3
		code_array =code.split(",");
		System.out.println(code_array); //[Ljava.lang.String;@4538a7fd
		System.out.println(code_array.length); // 3
		System.out.println(code_array[0]); // 3
		
		//ArrayList<Integer> results = new ArrayList<Integer>();
		ArrayList<String> results2 = new ArrayList<String>();
		
		for(int i=0; i<code_array.length; i++) {
			//results.add(Integer.parseInt(code_array[i]));
			results2.add(code_array[i]);
		}
		
		System.out.println(results2);
		System.out.println(results2.size());
	d.addAttribute("list",commandMap);
	d.addAttribute("results",results2);
	return "WEB-INF\\views\\mail\\memberchk.jsp";
	
}
	
	
	
	
	@RequestMapping("/MailSendArrays.do")
	public String MailSendArrays(Model d, List<Mail> mail)  {
		return "pageJsonReport";
	}
	
	
	// 메일 발송하기 // 내 마음대로
	@RequestMapping("/mailsend2.do")
	public String mailsend2(List<String> reciever,Mail mail, Model d) {
			service.sendArrays(reciever, mail);
		return "pageJsonReport";
	}
	
	// 회원을 골라서 메일 보내주는 것
		@RequestMapping("/mailsend3.do")
		public String mailsend3(Model d,@RequestParam HashMap<String, Object> commandMap, Mail mail) throws Exception{ 
			System.out.println(commandMap); //{arrayParam=1,2,3, email=1}
			String[] code_array=null;
			String code=commandMap.get("arrayParam").toString();
			System.out.println(code); //1,2,3
			code_array =code.split(",");
			System.out.println(code_array); //[Ljava.lang.String;@4538a7fd
			System.out.println(code_array.length); // 3
			System.out.println(code_array[0]); // 3
			
			//ArrayList<Integer> results = new ArrayList<Integer>();
			ArrayList<String> results2 = new ArrayList<String>();
			
			for(int i=0; i<code_array.length; i++) {
				//results.add(Integer.parseInt(code_array[i]));
				results2.add(code_array[i]);
			}
			
			System.out.println(results2);
			System.out.println(results2.size());
		d.addAttribute("list",commandMap);
		d.addAttribute("results",results2);
		d.addAttribute("mail", service.sendArrays(results2, mail));
		d.addAttribute("psc","success");
		
		
		return "WEB-INF\\views\\mail\\memberchk.jsp";
	}
	
	
	
	

}
