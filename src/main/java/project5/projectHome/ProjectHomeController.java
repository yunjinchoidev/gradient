package project5.projectHome;

import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import project5.member.MemberService;
import project5.project.ProjectSch;
import project5.project.ProjectService;
import project5.project.ProjectVO;
import project5.vote.VoteService;

@Controller
public class ProjectHomeController {

	@Autowired
	ProjectHomeService service;
	
	@Autowired
	ProjectService service2;
	
	@Autowired
	VoteService service3;
	
	@RequestMapping("/projectHome.do")
	public String projectHome(Model d, ProjectHomeSch sch) {
		System.out.println(sch.getProjectkey());
		// 프로젝트 홈에서 사용하는 공지 내용들 
		d.addAttribute("list", service.listWithPaging(sch)); //
		d.addAttribute("voteList", service3.list());
		return "WEB-INF\\views\\projectHome\\home.jsp";
	}
	
	
	@RequestMapping("/projectHomeWriteForm.do")
	public String projectHomeWriteForm(Model d) {
		System.out.println(service2.list().size());
		d.addAttribute("pjList", service2.list()); 
		d.addAttribute("workSort", service.getWorkSortList());
		return "WEB-INF\\views\\projectHome\\writeForm.jsp";
	}

	
	@RequestMapping("/projectHomeWrite.do")
	public String projectHomeWrite(Model d, ProjectHomeVO vo) {
		service.insert(vo);
		d.addAttribute("msg", "write");
		System.out.println("프로젝트 홈 공지 작성 완료");
		d.addAttribute("project", service2.get(30001));
		return "WEB-INF\\views\\projectHome\\home.jsp";
	}

	
	
	@RequestMapping("/projectHomeUpdateForm.do")
	public String projectHomeUpdateFrom(Model d, ProjectHomeVO vo) {
		d.addAttribute("get", service.get(vo.getProjectHomekey()));
		d.addAttribute("pjList", service2.list());
		d.addAttribute("workSort", service.getWorkSortList());
		return "WEB-INF\\views\\projectHome\\updateForm.jsp";
	}

	@RequestMapping("/projectHomeUpdate.do")
	public String projectHomeUpdate(Model d, ProjectHomeVO vo) {
		service.update(vo);
		d.addAttribute("msg", "update");
		return "WEB-INF\\views\\projectHome\\home.jsp";
	}
	
	
	
	@RequestMapping("/projectHomeGet.do")
	public String projectHomeGet(Model d, int projectHomekey) {
		d.addAttribute("get", service.get(projectHomekey));
		//return "pageJsonReport";
		return "WEB-INF\\views\\projectHome\\get.jsp";
	}
	
	
	
	@RequestMapping("/projectHomeDelete.do")
	public String projectHomeDelete(Model d, int projectHomekey, int projectkey) {
		service.delete(projectHomekey);
		//System.out.println(service2.get(projectHomekey).getProjectkey());
		//d.addAttribute("project", service2.get(service2.get(projectHomekey).getProjectkey()));
		d.addAttribute("msg", "delete");
		System.out.println("프로젝트 공지사항 삭제 완료");
		return "WEB-INF\\views\\projectHome\\home.jsp";
	}
}
