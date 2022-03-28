package project5.communication;

import java.util.List;

import org.springframework.stereotype.Repository;

@Repository
public interface minutesDao {
	public int totCnt(minutesSch sch);
	
	public List<minutesVO> minutesList(minutesSch sch);
	public List<minutesVO> selectPrjList();
	public List<minutesVO> selectDptList();
	
	public minutesVO getMinutes(int minutesKey);
	
	public void insMinutes(minutesVO ins);
	public void uptMinutes(minutesVO upt);
	public void delMinutes(int minutesKey);
	
	public void uptReadCnt(int no);
}
