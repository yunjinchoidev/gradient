package project5.schedule;

import java.util.List;

import org.springframework.stereotype.Repository;

@Repository
public interface ScheduleDao {
	public List<ScheduleVO> getList();
	public void insert(ScheduleVO vo);
	
}
