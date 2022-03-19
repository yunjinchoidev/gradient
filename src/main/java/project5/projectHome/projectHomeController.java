package project5.projectHome;

import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import project5.member.MemberService;
import project5.project.ProjectService;
import project5.project.ProjectVO;

@Controller
public class projectHomeController {

	@Autowired
	ProjectHomeService service;
	
	@Autowired
	ProjectService service2;
	
	
	@RequestMapping("/projectHome.do")
	public String projectHome(Model d, ProjectVO vo) {
		// 프로젝트 홈에서 사용하는 공지 내용들 
		d.addAttribute("list", service.getList(vo.getProjectkey())); //
		
		// 프로젝트 명단 // 공통
		d.addAttribute("pjList", service2.list()); 
		d.addAttribute("project", service2.get(vo.getProjectkey())); 
		return "/projectHome/home";
	}

	
	
	@RequestMapping("/projectHomeWriteForm.do")
	public String projectHomeWriteForm(Model d) {
		System.out.println(service2.list().size());
		d.addAttribute("pjList", service2.list()); 
		d.addAttribute("workSort", service.getWorkSortList());
		return "projectHome/writeForm";
	}

	
	@RequestMapping("/projectHomeWrite.do")
	public String projectHomeWrite(Model d, ProjectHomeVO vo) {
		service.insert(vo);
		d.addAttribute("psc", "write");
		System.out.println("프로젝트 홈 공지 작성 완료");
		return "forward:/projectHome.do";
	}

	
	
	
	
	
	@RequestMapping("/projectHomeUpdateForm.do")
	public String projectHomeUpdateFrom(Model d, ProjectHomeVO vo) {
		d.addAttribute("projectHome", service.get(vo.getProjectHomekey()));
		return "projectHome/update";
	}

	@RequestMapping("/projectHomeUpdate.do")
	public String projectHomeUpdate(Model d, ProjectHomeVO vo) {
		service.update(vo);
		d.addAttribute("psc", "update");
		return "forward:/projectHome.do";
	}
	
	
	
	@RequestMapping("/projectHomeGet.do")
	public String projectHomeGet(Model d, int projectHomekey) {
		d.addAttribute("projectHome", service.get(projectHomekey));
		return "projectHome/get";
	}
	
	@RequestMapping("/projectHomeDelete.do")
	public String projectHomeDelete(Model d, int projectHomekey) {
		service.delete(projectHomekey);
		d.addAttribute("psc", "delete");
		System.out.println("공지사항 삭제 완료");
		return "forward:/projectHome.do";
	}
}
