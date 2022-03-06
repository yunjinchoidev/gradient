package project5.schedule;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ScheduleService {

	@Autowired
	ScheduleDao dao;

	public List<ScheduleVO> getList() {
		return dao.getList();
	}

	public void insert(ScheduleVO vo) {
		 dao.insert(vo);
	}

}
