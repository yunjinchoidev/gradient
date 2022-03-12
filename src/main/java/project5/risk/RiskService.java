package project5.risk;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class RiskService {
	
	@Autowired
	RiskDao dao;
	
	// 리스크 게시판 조회
	public List<RiskVO> riskboardlist(){
		return dao.riskboardlist();
	}
	// 프로젝트 조회
	public List<RiskVO> selectprjlist() {
		return dao.selectprjlist();
	}
	// 리스크 게시글 조회
	public RiskVO riskDetail(int riskkey){
		return dao.riskDetail(riskkey);
	}
	// 리스크 등록
	public void insertRisk(RiskVO ins) {
		dao.insertRisk(ins);
	}	
	// 리스크 삭제
	public void delRisk(int riskkey) {
		dao.delRisk(riskkey);
	}
	// 리스크 수정
	public void uptRisk(RiskVO upt) {
		dao.uptRisk(upt);
	}
}
