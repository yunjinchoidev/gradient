package project5.risk;

import java.util.List;

import org.springframework.stereotype.Repository;

@Repository
public interface RiskDao {
	// 리스크 게시판 조회
	public List<RiskVO> riskboardlist(RiskSch sch);
	// 리스크 프로젝트 별 게시판 조회
	public List<RiskVO> riskboardprlist(RiskSch sch);
	// 프로젝트 조회
	public List<RiskVO> selectprjlist();
	// 리스크 등록
	public void insertRisk(RiskVO ins);
	// 리스크 상세정보
	public RiskVO riskDetail(int riskkey);
	// 리스크 삭제
	public void delRisk(int riskkey);
	// 리스크 수정
	public void uptRisk(RiskVO upt);
	// 총 게시글
	public int totCnt(RiskSch sch);
	// 프로젝트 별 게시글
	public int totprjCnt(RiskSch sch);
	// 리스크 게시글 검색
	public List<RiskVO> schRiskList(RiskSch sch);
	// 댓글 등록
	public void insertcomm(InsRiskcomm ins);
	// 댓글 조회
	public List<Riskcomm> getCommList(int riskkey);
	// 댓글 삭제
	public void delcomm(int rcommkey);
	// 답글 등록
	public void insertrecomm(InsRiskcomm ins);
	// 답글 삭제
	public void delrecomm(int rcommkey);
	
}
