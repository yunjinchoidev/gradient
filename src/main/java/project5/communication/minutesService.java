package project5.communication;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class minutesService {
	@Autowired
	private minutesDao dao;
	
	public List<minutesVO> minutesList(minutesSch sch){
		
		sch.setCount(dao.totCnt(sch));
		
		if(sch.getPageSize()==0) {
			sch.setPageSize(5);
		}
		
		double totPage1 = sch.getCount()/(double)sch.getPageSize();
		totPage1 = Math.ceil(totPage1); 
		int totPage = (int)(totPage1);
		sch.setPageCount( totPage );
		
		if(sch.getCurPage()==0) {
			sch.setCurPage(1);
		}
		
		sch.setStart((sch.getCurPage()-1)*sch.getPageSize()+1);
		sch.setEnd(sch.getCurPage()*sch.getPageSize());
		
		sch.setBlockSize(5);
		
		int curBlockGrpNo = (int)Math.ceil(sch.getCurPage()/(double)sch.getBlockSize());
		sch.setStartBlock((curBlockGrpNo-1)*sch.getBlockSize()+1);
		
		int endBlockGrpNo = curBlockGrpNo*sch.getBlockSize();
		sch.setEndBlock(endBlockGrpNo>sch.getPageCount()?sch.getPageCount():endBlockGrpNo);
	
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
