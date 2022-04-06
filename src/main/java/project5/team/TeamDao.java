package project5.team;

import java.util.List;

//project5.team.TeamDao

public interface TeamDao {
	public List<TeamVo> getTeamList(TeamSch sch);
	public List<TeamVo> selectPrjList();
	public List<TeamVo> selectdptList();
	public List<TeamVo> selectMemList();
	public int totCnt(TeamSch sch);
	public void insTeam(TeamVo ins);
	public void uptTeam(TeamVo upt);
//	public List<TeamVo> getTeamDetail(TeamVo sch);
	public void delTeam(int memberprojectkey);

}

