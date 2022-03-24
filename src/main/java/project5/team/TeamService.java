package project5.team;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class TeamService {
	
	@Autowired
	private TeamDao dao;
	public List<TeamVo> teamList(){
		return dao.teamList();
	}
}
