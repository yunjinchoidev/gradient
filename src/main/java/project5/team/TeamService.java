package project5.team;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class TeamService {
	
	@Autowired
	private TeamDao dao;
	
	public List<TeamVo> TeamList(TeamVo sch){
		return dao.TeamList(sch);
	}
	public String insertTeam(TeamVo ins) {
		dao.insertTeam(ins);
		String msg = "등록 성공";
		return msg;
	}
	public TeamVo getTeam(int no) {
		dao.getTeam(no);
		TeamVo t = dao.getTeam(no);
		return t;
	}
	public void deleteTeam(int no) {
		dao.deleteTeam(no);
	}
	public void updateTeam(TeamVo upt) {
		dao.updateTeam(upt);
	}
}
