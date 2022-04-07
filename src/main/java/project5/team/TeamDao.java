package project5.team;

import java.util.List;

//project5.team.TeamDao

public interface TeamDao {
	// 팀 관리 리스트
	public List<TeamVo> getTeamList(TeamSch sch);
	// 프로젝트, 부서, 회원명 select 리스트
	public List<TeamVo> selectPrjList();
	public List<TeamVo> selectdptList();
	public List<TeamVo> selectMemList();
	// 게시글 카운트
	public int totCnt(TeamSch sch);
	public void insTeam(TeamVo ins);
	public void uptTeam(TeamVo upt);
	public void delTeam(int memberprojectkey);
//	public List<TeamVo> getTeamDetail(TeamVo sch);
	public TeamVo getTeam(int member_project_key);
}

