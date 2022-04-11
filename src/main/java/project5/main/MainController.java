package project5.main;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import project5.member.MemberService;
import project5.project.ProjectService;
import project5.project.ProjectVO;

@Controller
public class MainController {
	
	@Autowired
	MemberService service;
	
	
	@Autowired
	ProjectService service2;
	
	
	@RequestMapping("/main.do")
	public String Main() {
		return "WEB-INF\\views\\main.jsp";
	}
	
	@RequestMapping("/main2")
	public String Main2() {
		return "WEB-INF\\views\\main2.jsp";
	}

	@RequestMapping("/aboutUs.do")
	public String aboutUs() {
		return "WEB-INF\\views\\aboutUs.jsp";
	}
	
	
	
	@RequestMapping("/authCount.do")
	public String authCount(Model d) {
		d.addAttribute("authCount", service.authCount());
		return "pageJsonReport";
	}
	@RequestMapping("/visitCount.do")
	public String visitCount(Model d) {
		d.addAttribute("visitCount1", service.visitCount1());
		d.addAttribute("visitCount2", service.visitCount2());
		d.addAttribute("visitCount3", service.visitCount3());
		d.addAttribute("visitCount4", service.visitCount4());
		return "pageJsonReport";
	}
	
	@RequestMapping("/progressCnt.do")
	public String progressCnt(Model d) {
		d.addAttribute("progressCnt", service2.progressCnt());
		return "pageJsonReport";
	}
	
	@RequestMapping("/projectTeamCnt.do")
	public String projectTeamCnt(Model d) {
		d.addAttribute("projectTeamCnt", service2.projectTeamCnt());
		return "pageJsonReport";
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
