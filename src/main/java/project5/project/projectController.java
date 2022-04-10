package project5.project;

import org.apache.poi.hssf.util.HSSFColor.TEAL;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import project5.attendance.AttendanceService;
import project5.attendance.attendanceSch;
import project5.member.MemberSch;
import project5.member.MemberService;
import project5.team.TeamSch;
import project5.team.TeamService;
import project5.vacation.Team_MemberVO;

@Controller
public class projectController {

	@Autowired
	ProjectService service;

	@Autowired
	AttendanceService service2;
	
	@Autowired
	TeamService service3;
	
	// 데이터 전달
	@RequestMapping("/projectList.do")
	public String projectList(Model d, ProjectSch sch) {
		d.addAttribute("list", service.listWithPaging(sch));
		return "pageJsonReport";
	}

	// 프로젝트 정보 하나 얻기
	@RequestMapping("/projectGet.do")
	public String projectGet(Model d, int proejctkey) {
		d.addAttribute("list", service.get(proejctkey));
		return "pageJsonReport";
	}

	// 프로젝트 관리를 위한 프로젝트 리스트
	@RequestMapping("/projectManageMain.do")
	public String projectManageMain(Model d, ProjectSch sch,MemberSch sch2, TeamSch sch3) {
		d.addAttribute("list", service.listWithPaging(sch));
		d.addAttribute("list3", service2.listWithPagingComplete(sch2));
		d.addAttribute("pjList", service.list());
		d.addAttribute("tlist", service3.getTeamList(sch3));
		return "WEB-INF\\views\\projectManage\\main.jsp";
	}
	
	
	
	
	// 프로젝트 관리를 위한 프로젝트 리스트
	@RequestMapping("/projectManageMain2.do")
	public String projectManageMain2(Model d, ProjectSch sch) {
		d.addAttribute("list", service.listWithPaging(sch));
		return "WEB-INF\\views\\projectManage\\main2.jsp";
	}

	// 프로젝트 관리를 위한 프로젝트 조회
	@RequestMapping("/projectManageGet.do")
	public String projectManageGet(Model d, int projectkey) {
		d.addAttribute("get", service.get(projectkey));
		return "WEB-INF\\views\\projectManage\\get.jsp";
	}

	// 프로젝트 관리를 위한 프로젝트 인서트폼
	@RequestMapping("/projectManageInsertForm.do")
	public String projectManageInsertForm(Model d) {
		return "WEB-INF\\views\\projectManage\\writeForm.jsp";
	}

	// 프로젝트 관리를 위한 프로젝트 업데이트폼
	@RequestMapping("/projectManageUpdateForm.do")
	public String projectManageUpdateForm(Model d, int projectkey) {
		d.addAttribute("get", service.get(projectkey));
		return "WEB-INF\\views\\projectManage\\updateForm.jsp";
	}

	// 프로젝트 관리를 위한 프로젝트 리스트
	@RequestMapping("/projectManageInsert.do")
	public String projectManageGet(Model d, ProjectVO vo) {
		service.insert(vo);
		return "WEB-INF\\views\\projectManage\\main.jsp";
	}

	
	
	
	// 프로젝트 관리를 위한 프로젝트 리스트
	@RequestMapping("/projectManageUpdate.do")
	public String projectManageUpdate(Model d, ProjectVO vo) {
		service.update(vo);
		d.addAttribute("msg", "프로젝트가 성공적으로 수정되었습니다.");
		return "WEB-INF\\views\\projectManage\\main.jsp";
	}

	
	
	
	
	
	
	
	// 프로젝트 관리를 위한 프로젝트 상태 업데이트
	@RequestMapping("/updateProjectProgress.do")
	public String projectProgressUpdate(Model d, ProjectVO vo) {
		service.progressUpdate(vo);
		d.addAttribute("msg", "updateProjectProgress");
		System.out.println("프로젝트 상황 업데이트 되었습니다.");
		return "WEB-INF\\views\\projectManage\\main.jsp";
	}

	
	
	
	
	
	
	// 프로젝트 관리를 위한 프로젝트 업데이트폼
	@RequestMapping("/projectManageDelete.do")
	public String projectManageDelete(Model d, int projectkey) {
		service.delete(projectkey);
		return "WEB-INF\\views\\projectManage\\get.jsp";
	}

}
