package project5.communication;

import java.util.List;

import org.springframework.stereotype.Repository;

@Repository
public interface minutesDao {
	public List<minutesVO> minutesList(minutesVO sch);
	public minutesVO getMinutes(int minutesKey);
	public void insMinutes(minutesVO ins);
	public void uptMinutes(minutesVO upt);
	public void delMinutes(int minutesKey);
}
