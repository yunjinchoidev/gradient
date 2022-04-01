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
		d.addAttribute("prjList", service.selectPrjList());
		d.addAttribute("dptList", service.selectdptList());
		d.addAttribute("MemList", service.selectMemList());
		return "WEB-INF\\views\\team\\Teamlist.jsp";
	}
	@RequestMapping("/detail.do")
	public String getDetail(TeamVo member_project_key, Model d) {
		d.addAttribute("detail", service.getDetail(member_project_key));
		return "WEB-INF\\views\\team\\detail.jsp";
		
	}
	
	// http://localhost:7080/project5/insertTeam.do
	@RequestMapping("/insertTeam.do")
	public String insertTeam(TeamVo ins, Model d) {
		d.addAttribute("proc", "배정완료");
		System.out.println("##test##");
		System.out.println(ins.getProjectkey());
		System.out.println(ins.getMemberkey());
		service.insertTeam(ins);
		return "redirect:/teamlist.do";
	}
	// http://localhost:7080/project5/updateTeam.do
	@RequestMapping("/updateTeam.do")
	public String updateTeam(TeamVo upt, Model d) {
		d.addAttribute("proc", "배정되었습니다.");
		return "WEB-INF\\views\\team\\Teamlist.jsp";
	}
}
