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
		d.addAttribute("list", service.getList()); //
		d.addAttribute("pjList", service2.list()); // 프로젝트 리스트 조회를 위한
		return "/projectHome/home";
	}

	
	
	@RequestMapping("/projectHomeWriteForm.do")
	public String projectHomeWriteForm() {
		return "projectHome/writeForm";
	}

	@RequestMapping("/projectHomeWrite.do")
	public String projectHomeWrite(Model d, ProjectHomeVO vo) {
		
		service.insert(vo);
		d.addAttribute("psc", "write");
		System.out.println("공지사항 작성 완료");
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
