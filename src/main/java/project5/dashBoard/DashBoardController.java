package project5.dashBoard;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.google.gson.JsonArray;

import project5.cost.CostDetail;
import project5.member.MemberVO;
import project5.memo.MemoSch;
import project5.memo.MemoService;
import project5.output.OutputVO;
import project5.project.ProjectService;
import project5.project.ProjectVO;
import project5.workSort.WorkSortService;

@Controller
@SessionAttributes("project")
public class DashBoardController {
	
	@ModelAttribute("project")
	public ProjectVO getUserVO() {
		return new ProjectVO();
	}

	
	
	
	@Autowired
	ProjectService service;
	
	@Autowired
	MemoService service2;
	
	@Autowired
	DashBoardService service3;
	
	@Autowired
	WorkSortService service4;
	
	
	
	@RequestMapping("/dashBoard.do")
	public String dashBoard(Model d, int projectkey,MemberVO vo, OutputVO vo2, MemoSch sch, @ModelAttribute("project") ProjectVO vo4) {
		d.addAttribute("pjList", service.list());
		d.addAttribute("project", service.get(projectkey));
		d.addAttribute("memoList",service2.list(sch));
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
		d.addAttribute("costDetailGet", service3.costDetailGet(1));
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
	
	
	@RequestMapping("/dashCostDetailGet.do")
	public String dashCostDetailGet(Model d, int no) {
		System.out.println("dashCostDetailGet 진입!");
		List<CostDetail> detailGet = service3.costDetailGet(no);
		d.addAttribute("get", detailGet);
		System.out.println("확인:"+  service3.costDetailGet(no).get(no).getCostcontent());
		return "pageJsonReport";
	}
	
	
	
	@RequestMapping("/projectVacationCnt.do")
	public String projectVacationCnt(Model d, int projectkey) {
		System.out.println("projectVacationCnt 진입!");
		int yesterdayCanCnt = service3.yesterdayCanCnt(projectkey);
		int tommorwCanCnt = service3.tommorwCanCnt(projectkey);
		int todayCanCnt = service3.todayCanCnt(projectkey);
		int projectTotalCnt = service3.projectTotalCnt(projectkey);
		d.addAttribute("yesterdayCanCnt", yesterdayCanCnt);
		d.addAttribute("tommorwCanCnt", tommorwCanCnt);
		d.addAttribute("todayCanCnt", todayCanCnt);
		d.addAttribute("projectTotalCnt", projectTotalCnt);
		return "pageJsonReport";
	}
	
	@RequestMapping("/TotalOutputCntByDayList.do")
	public String todayTotalCnt(Model d) {
		System.out.println("projectVacationCnt 진입!");
		List<TotalOutputCntByDayVO> TotalOutputCntByDayList = service3.TotalOutputCntByDay();
		d.addAttribute("TotalOutputCntByDayList", TotalOutputCntByDayList);
		return "pageJsonReport";
	}
	
	
	
	@RequestMapping("/outputEvaluationDayByDay.do")
	public String outputEvaluationDayByDay(Model d) {
		d.addAttribute("list", service3.outputEvaluationDayByDay());
		return "pageJsonReport";
	}
	
	
	
}
