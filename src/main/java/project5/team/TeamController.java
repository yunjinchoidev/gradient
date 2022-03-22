package project5.team;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class TeamController {
	
	@Autowired
	TeamService service;
	
	@RequestMapping("/team.do")
	public String getTeamList(TeamSch sch, Model d) {
		
	}

}
