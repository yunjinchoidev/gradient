package project5.team;

import java.util.List;

//project5.team.TeamDao

public interface TeamDao {
	public List<TeamVo> getTeamList(TeamVo sch);
	public void insertTeam(TeamVo sch);
	public void updateTeam(TeamVo upt);
	// 모달창 프로젝트 리스트 & 부서 리스트 & 회원 리스트
	public List<TeamVo> selectPrjList();
	public List<TeamVo> selectdptList();
	public List<TeamVo> selectMemList();
	
	public TeamVo getDetail(TeamVo member_project_key);
}
