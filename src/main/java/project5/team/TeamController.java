package project5.team;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
// http://localhost:7080/project5/team.do
public class TeamController {
	@RequestMapping("/team.do")
	public String TeamList() {
		return "Team/Teamlist";
	}
	@RequestMapping(params="method=insert")
	public String TeamListInsert(TeamVo insert, Model d) {
		return "Team/TeamInsert";
	}
	@RequestMapping(params="method=detail")
	public String TeamDetail(int no, Model d) {
		System.out.println("번호:"+no);
		return "";
	}
	@RequestMapping(params="method=del")
	public String TeamDelete(int no, Model d) {
		System.out.println("삭제 번호:"+no);
		d.addAttribute("msg", "삭제되었습니다");
		return "";
	}
	@RequestMapping(params="method=upt")
	public String TeamUpdate(TeamVo upt, Model d) {
		d.addAttribute("msg", "수정되었습니다");
		return ""; 
	}
}
