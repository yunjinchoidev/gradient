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

@Controller
public class DashBoardController {
	
	
	
	@Autowired
	ProjectService service;
	
	@Autowired
	MemoService service2;
	
	@Autowired
	DashBoardService service3;
	
	
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

	
	
	@PostMapping("/outputSortCnt.do")
	public String outputSortCnt(Model d) {
		System.out.println("outputSortCnt.do 진입");
		d.addAttribute("outputSortCnt", service3.outputSortCnt());
		return "pageJsonReport";
	}

	
	
	
}
