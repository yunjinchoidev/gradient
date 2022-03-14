package project5.communication;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class minutesService {
	@Autowired
	private minutesDao dao;
	
	public List<minutesVO> minutesList(minutesVO sch){
		return dao.minutesList(sch);
	}
	public minutesVO getMinutes(int minutesKey) {
		return dao.getMinutes(minutesKey);
	}
	public String insMinutes(minutesVO ins) {
		dao.insMinutes(ins);
		String msg="등록성공";
		return msg;
	}
	public void uptMinutes(minutesVO upt) {
		dao.uptMinutes(upt);
	}
	public void delMinutes(int minutesKey) {
		dao.delMinutes(minutesKey);
	}
}
