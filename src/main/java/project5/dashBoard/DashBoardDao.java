package project5.dashBoard;

import java.util.List;

import org.springframework.stereotype.Repository;

import project5.fullCalendar.Calendar;
import project5.output.OutputVO;



@Repository
public interface DashBoardDao {
	
	public List<RiskDashBoardVO> riskDashBoard();
	public int calendarCountBelongTodayCnt(); // 오늘이 껴있는 것들
	public Calendar EmergencyCalendarTask(); // 가장 긴급한 일
	public int outputCnt(OutputVO vo);
	public int outputSortCnt();
	
	
	
}