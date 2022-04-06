package project5.team;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class TeamService {
	
	@Autowired
	private TeamDao dao;
	
	public List<TeamVo> getTeamList(TeamSch sch){
		sch.setCount(dao.totCnt(sch));
		if (sch.getPageSize() == 0) {
			sch.setPageSize(5);
		}
		double totPage1 = sch.getCount() / (double) sch.getPageSize();
		totPage1 = Math.ceil(totPage1);
		int totPage = (int) (totPage1);
		sch.setPageCount(totPage);
		if (sch.getCurPage() == 0) {
			sch.setCurPage(1);
		}
		sch.setStart((sch.getCurPage() - 1) * sch.getPageSize() + 1);
		sch.setEnd(sch.getCurPage() * sch.getPageSize());sch.setBlockSize(5);

		int curBlockGrpNo = (int) Math.ceil(sch.getCurPage() / (double) sch.getBlockSize());
		sch.setStartBlock((curBlockGrpNo - 1) * sch.getBlockSize() + 1);
		int endBlockGrpNo = curBlockGrpNo * sch.getBlockSize();
		sch.setEndBlock(endBlockGrpNo > sch.getPageCount() ? sch.getPageCount() : endBlockGrpNo);
		return dao.getTeamList(sch);
	}
	public List<TeamVo> selectPrjList(){
		return dao.selectPrjList();
	}
	public List<TeamVo> selectdptList(){
		return dao.selectdptList();
	}
	public List<TeamVo> selectMemList(){
		return dao.selectMemList();
	}
	public void insTeam(TeamVo ins) {
		dao.insTeam(ins);
	}
	public void uptTeam(TeamVo upt) {
		dao.uptTeam(upt);
	}
//	public List<TeamVo> getTeamDetail(TeamVo sch){
//		return dao.getTeamDetail(sch);
//	}
	public void delTeam(int memberprojectkey) {
		dao.delTeam(memberprojectkey);
	}
}

