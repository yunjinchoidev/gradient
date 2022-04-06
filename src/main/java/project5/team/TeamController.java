package project5.team;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;


@Controller
public class TeamController {
	
	@Autowired
	TeamService service;
	// http://localhost:7080/project5/teamlist.do
	@RequestMapping("/teamlist.do")
	public String getTeamList(TeamVo sch, Model d) {
		d.addAttribute("tlist",service.getTeamList(sch));
		d.addAttribute("prjList", service.selectPrjList());
		d.addAttribute("dptList", service.selectdptList());
		d.addAttribute("MemList", service.selectMemList());
		return "WEB-INF\\views\\team\\Teamlist.jsp";
	}
	
	
	// http://localhost:7080/project5/insertTeam.do
	@RequestMapping("/insertTeam.do")
	public String insertTeam(TeamVo ins, Model d) {
		d.addAttribute("proc", "배정완료");
		service.insertTeam(ins);
		return "WEB-INF\\views\\team\\detail.jsp";
	}
	// http://localhost:7080/project5/updateTeam.do
	@RequestMapping("/updateTeam.do")
	public String updateTeam(TeamVo upt, Model d) {
		d.addAttribute("proc", "배정되었습니다.");
		return "WEB-INF\\views\\team\\uptTeam.jsp";
	}
}
