package project5.team;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;


@Controller
public class TeamController {
	
	@Autowired
	TeamService service;
	// http://localhost:7080/project5/teamlist.do
	@RequestMapping("/teamlist.do")
	public String getTeamList(TeamSch sch, Model d) {
		d.addAttribute("tlist", service.getTeamList(sch));
		return "WEB-INF\\views\\team\\Teamlist.jsp";
	}
	
	// http://localhost:7080/project5/insertTeam.do
	@RequestMapping("/teamInsertForm.do")
	public String insForm(Model d) {
		d.addAttribute("prjList", service.selectPrjList());
		d.addAttribute("dptList", service.selectdptList());
		d.addAttribute("MemList", service.selectMemList());
		return "WEB-INF\\views\\team\\writeTeam.jsp";
	}
	
	
	
	
	
	
	
	// http://localhost:7080/project5/insertTeam.do
	@RequestMapping("/insertTeam.do")
	public String insTeam(TeamVo ins, Model d){
		d.addAttribute("prjList", service.selectPrjList());
		d.addAttribute("dptList", service.selectdptList());
		d.addAttribute("MemList", service.selectMemList());
		d.addAttribute("msg", "배정완료");
		service.insTeam(ins);
		return "WEB-INF\\views\\team\\writeTeam.jsp";	
	}
	
	
	
	
	
	
	
	@RequestMapping("/uptForm.do")
	public String uptForm(Model d) {
		d.addAttribute("prjList", service.selectPrjList());
		d.addAttribute("dptList", service.selectdptList());
		d.addAttribute("MemList", service.selectMemList());
		return "WEB-INF\\views\\team\\uptTeam.jsp";	
	}
	
	@RequestMapping("/uptTeam.do")
	public String uptTeam(TeamVo upt, Model d) {
		d.addAttribute("msg", "수정되었습니다.");
		service.uptTeam(upt);
		return "WEB-INF\\views\\team\\Teamlist.jsp";
	}
	//@RequestMapping("/teamdetail.do")
	//public String getTeamDetail(TeamVo sch, Model d) {
	//	return "WEB-INF\\views\\team\\detail.jsp";
//	}
	@RequestMapping("/delTeam.do")
	public String delTeam(int memberprojectkey, Model d) {
		d.addAttribute("msg", "삭제되었습니다.");
		service.delTeam(memberprojectkey);
		return "forward:/teamlist.do";
	}
}
