package project5.scheduleNotice;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ScheduleNoticeService {

	@Autowired
	ScheduleNoticeDao dao;

	public List<ScheduleNoticeVO> getList() {
		return dao.getList();
	}

	public void insert(ScheduleNoticeVO vo) {
		 dao.insert(vo);
	}

}
