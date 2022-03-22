package project5.team;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class TeamController {
	
	@Autowired
	TeamService service;
	
	@RequestMapping("/addmen.do")
	public String addmen(Model d) {
		return "\\WEB-INF\\views\\team\\Addmem.jsp";
	}
	@RequestMapping("/allteam.do")
	public String Allteam(Model d) {
		return "\\WEB-INF\\views\\team\\Allteam.jsp";
	}
	@RequestMapping("/regTeam.do")
	public String RegTeam(Model d) {
		return "\\WEB-INF\\views\\team\\RegTeam.jsp";
	}
	@RequestMapping("/teamAllocation.do")
	public String TeamAllocation(Model d) {
		return "\\WEB-INF\\views\\team\\TeamAllocation.jsp";
	}
	@RequestMapping("/teamDetail.do")
	public String TeamDetail(Model d) {
		return "\\WEB-INF\\views\\team\\TeamDetail.jsp";
	}
	@RequestMapping("/teamlist.do")
	public String Teamlist(Model d) {
		return "\\WEB-INF\\views\\team\\Teamlist.jsp";
	}
	

}
