package project5.risk;

import java.util.List;

import org.springframework.stereotype.Repository;

@Repository
public interface RiskDao {
	// 리스크 게시판 조회
	public List<RiskVO> riskboardlist();
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
	
}
