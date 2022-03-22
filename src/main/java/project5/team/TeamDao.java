package project5.team;

import java.util.List;

//project5.team.TeamDao

public interface TeamDao {
	public List<TeamVo> TeamList(TeamSch sch);
	public List<TeamVo> schTeamList(TeamSch sch); 
	public List<TeamVo> getPrjList();

}
