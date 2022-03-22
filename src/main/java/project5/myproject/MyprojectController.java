package project5.myproject;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import project5.member.MemberVO;
import project5.member_project.Member_ProjectService;
import project5.project.ProjectService;

@Controller
public class MyprojectController {

	@Autowired
	MyprojectService service;
	
	@Autowired
	Member_ProjectService service2;
	
	@Autowired
	ProjectService service3;
	
	
	
	@RequestMapping("/myProject.do")
	public String myProject(Model d, MemberVO vo) {
		List<Integer> projectkeyList = service2.getProjectkey(vo.getMemberkey());
		System.out.println(service3.get2(projectkeyList));
		for(int i=0; i<service3.get2(projectkeyList).size(); i++) {
			System.out.println(service3.get2(projectkeyList).get(i).getName());
		}
		d.addAttribute("list", service3.get2(projectkeyList));
		return "WEB-INF\\views\\myProject\\main.jsp";
	}

	@RequestMapping("/myProject2.do")
	public String myProject2(Model d, MemberVO vo) {
		List<Integer> projectkeyList = service2.getProjectkey(vo.getMemberkey());
		System.out.println(service3.get2(projectkeyList));
		for(int i=0; i<service3.get2(projectkeyList).size(); i++) {
			System.out.println(service3.get2(projectkeyList).get(i).getName());
		}
		d.addAttribute("list", service3.get2(projectkeyList));
		return "WEB-INF\\views\\myProject\\main2.jsp";
	}
	
	
	
	
	
	
	
	
	
	
	
}
