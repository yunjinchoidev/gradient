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
	public String teamlist(TeamVo sch, Model d) {
		d.addAttribute("tlist",service.getTeamList(sch));
		return "\\WEB-INF\\views\\team\\Teamlist.jsp";
	}
	// http://localhost:7080/project5/insertTeam.do
	@RequestMapping("insertTeam.do")
	public String insertTeam(TeamVo ins, Model d) {
		d.addAttribute("proc", "등록완료");
		service.insertTeam(ins);
		return "\\WEB-INF\\views\\team\\Teamlist.jsp";
	}
	// http://localhost:7080/project5/uptTeam.do
	@RequestMapping("uptTeam.do")
	public String uptTeam(TeamVo upt, Model d) {
		d.addAttribute("proc", "부서 수정 완료");
		return "\\WEB-INF\\views\\team\\Teamlist.jsp";
	}
}
