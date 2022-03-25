package project5.dashBoard;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import project5.cost.CostDetail;
import project5.fullCalendar.Calendar;
import project5.output.OutputVO;



@Service
public class DashBoardService {
	@Autowired
	private DashBoardDao dao;
	
	public List<RiskDashBoardVO> riskDashBoard(){
		return dao.riskDashBoard();
	}
	
	 // 오늘이 껴있는 것들
	public int calendarCountBelongTodayCnt(){
		return dao.calendarCountBelongTodayCnt();
	}
	
	public Calendar EmergencyCalendarTask() {
		return dao.EmergencyCalendarTask();
	}
	
	public int outputCnt(OutputVO vo) {
		return dao.outputCnt(vo);
	}
	
	public List<OutputDashBoardVO> outputSortCnt() {
		return dao.outputSortCnt();
	}
	
	public List<OutputDashBoardVO> outputSortCntByMemberkey(int memberkey) {
		return dao.outputSortCntByMemberkey(memberkey);
	}
	
	
	public int teamCntByProject(int projectkey){
		return dao.teamCntByProject(projectkey);
	}

	public int teamCntByProject1(int projectkey) {
		return dao.teamCntByProject1(projectkey);
	}
	public int teamCntByProject2(int projectkey) {
		return dao.teamCntByProject2(projectkey);
	}
	public int teamCntByProject3(int projectkey) {
		return dao.teamCntByProject3(projectkey);
	}
	
	public List<CostDetail> costDetailGet(int no) {
		return dao.costDetailGet(no);
	}
	
	
}
