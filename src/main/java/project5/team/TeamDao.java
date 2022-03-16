package project5.team;

import java.util.List;

//project5.team.TeamDao

public interface TeamDao {
	public List<TeamVo> TeamList(TeamVo sch);
	public void insertTeam(TeamVo ins);
	public TeamVo getTeam(int no);
	public void deleteTeam(int no);
	public void updateTeam(TeamVo upt);
}
