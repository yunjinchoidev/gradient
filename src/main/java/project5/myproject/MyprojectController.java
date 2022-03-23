package project5.myproject;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseStatus;

import project5.fileInfo.FileInfoService;
import project5.member.MemberVO;
import project5.member_project.Member_ProjectService;
import project5.project.ProjectService;
import project5.project.ProjectVO;

@Controller
public class MyprojectController {

	@Autowired
	MyprojectService service;
	
	@Autowired
	Member_ProjectService service2;
	
	@Autowired
	ProjectService service3;
	
	
	@Autowired
	FileInfoService service4;
	
	
	@RequestMapping("/myProject.do")
	public String myProject(Model d, MemberVO vo) {
		// 내가 참여하는 프로젝트 들
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
	
	
	// 프로젝트 하나의 데이터
	@PostMapping("/projectData.do")
	public String projectdata(String projectkey, Model d) {
		int projectkeyN = Integer.parseInt(projectkey);
		System.out.println("/projectkey.do 진입");
		System.out.println("memberkey:"+projectkeyN);
		ProjectVO vo = service3.get(projectkeyN);
		System.out.println("pname" + vo.getName());
		// vo 로 보낸다
		d.addAttribute("projectInfo", service3.get(projectkeyN));
		d.addAttribute("fileInfo", service4.findbyfno(projectkeyN));
		return "pageJsonReport";
	}
	
	
	
	
	
	
	
	
}
