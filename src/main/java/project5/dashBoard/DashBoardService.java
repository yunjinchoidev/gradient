package project5.dashBoard;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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
	
	public int outputSortCnt() {
		return dao.outputSortCnt();
	}
	
	
}
