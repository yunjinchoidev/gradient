package project5.scheduleNotice;

import java.util.List;

import org.springframework.stereotype.Repository;

@Repository
public interface ScheduleNoticeDao {
	public List<ScheduleNoticeVO> getList();
	public void insert(ScheduleNoticeVO vo);
	
}
