package project5.team;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class TeamController {
	
	@Autowired
	TeamService service;
	
	@RequestMapping("/teamlist.do")
	public String Teamlist(Model d) {
		d.addAttribute("teamlist", service.teamList());
		return "\\WEB-INF\\views\\team\\Teamlist.jsp";
	}
	@RequestMapping("/addmem.do")
	public String addmem(Model d) {
		return "\\WEB-INF\\views\\team\\Addmem.jsp";
	}
	@RequestMapping(params="method=update")
	public String uptTeam() {
		return "\\WEB-INF\\views\\team\\Teamlist.jsp";
	}
	@RequestMapping("/allocation.do")
	public String allocation(Model d) {
		return "\\WEB-INF\\views\\team\\Allocation.jsp";
	}
}
