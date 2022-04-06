package project5.team;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class TeamService {
	
	@Autowired
	private TeamDao dao;
	
	public List<TeamVo> getTeamList(TeamVo sch){
		return dao.getTeamList(sch);
	}
	public void insertTeam(TeamVo sch) {
		dao.insertTeam(sch);
	}
	public void updateTeam(TeamVo upt) {
		dao.updateTeam(upt);
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
}

