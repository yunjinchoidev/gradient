package project5.dashBoard;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import project5.member.MemberVO;
import project5.memo.MemoService;
import project5.output.OutputVO;
import project5.project.ProjectService;
import project5.workSort.WorkSortService;

@Controller
public class DashBoardController {
	
	
	
	@Autowired
	ProjectService service;
	
	@Autowired
	MemoService service2;
	
	@Autowired
	DashBoardService service3;
	
	@Autowired
	WorkSortService service4;
	
	
	@RequestMapping("/dashBoard.do")
	public String dashBoard(Model d, int projectkey,MemberVO vo, OutputVO vo2) {
		d.addAttribute("pjList", service.list());
		d.addAttribute("project", service.get(projectkey));
		d.addAttribute("memoList",service2.list());
		d.addAttribute("riskDashBoardList", service3.riskDashBoard());
		d.addAttribute("calendarCountBelongTodayCnt", service3.calendarCountBelongTodayCnt()); // 오늘 껴있는 숫자 수
		d.addAttribute("EmergencyCalendarTask", service3.EmergencyCalendarTask()); // 오늘 껴있는 숫자 수
		d.addAttribute("outputCnt", service3.outputCnt(vo2)); // 오늘 껴있는 숫자 수
		return "WEB-INF\\views\\dashBoard\\main.jsp";
	}
	
	@PostMapping("/riskDashBoardData.do")
	public String riskDashBoardData(Model d) {
		System.out.println("riskDashBoardData.do 진입");
		d.addAttribute("get", service3.riskDashBoard());
		return "pageJsonReport";
	}

	
	
	@RequestMapping("/outputSortCnt.do")
	public String outputSortCnt(Model d,  String memberkey) {
		int memberkeyN = Integer.parseInt(memberkey);
		System.out.println("outputSortCnt.do 진입");
		d.addAttribute("outputSortCnt", service3.outputSortCnt());
		d.addAttribute("worksortList", service4.list());
		d.addAttribute("outputSortCntByMemberkey", service3.outputSortCntByMemberkey(memberkeyN));
		return "pageJsonReport";
	}

	
	@RequestMapping("/teamCnt.do")
	public String teamCnt(Model d,  String projectkey) {
		int projectkeyN = Integer.parseInt(projectkey);
		System.out.println("teamCnt.do 진입");
		System.out.println("????");
		d.addAttribute("teamCntByProject", service3.teamCntByProject(projectkeyN));
		d.addAttribute("teamCntByProject1", service3.teamCntByProject1(projectkeyN));
		d.addAttribute("teamCntByProject2", service3.teamCntByProject2(projectkeyN));
		d.addAttribute("teamCntByProject3", service3.teamCntByProject3(projectkeyN));
		System.out.println(service3.teamCntByProject3(1));
		return "pageJsonReport";
	}
	

	
	
	
	
	
	
}
